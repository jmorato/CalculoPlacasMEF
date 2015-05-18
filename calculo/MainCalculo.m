% TÍTULO: Clase MainCalculo para CalculoPlacasMEF
% AUTOR: Joan Morató Guardia
% CONTACTO: j.morato.91@gmail.com
% ESTUDIOS: Tesina de Ingeniería de Caminos, Canales y Puertos
% UNIVERSIDAD: Universitat Politècnica de Catalunya
% FECHA: Marzo 2015
% LICENCIA: El usuario puede redistribuir, modificar, extender o adaptar el
% programa sin restricciones, citando la fuente original y manteniendo la
% licencia.
%
% DESCRIPCIÓN: 
%
% Esta clase es la clase principal del módulo de cálculo del programa.
% Almacena toda la información de interés referente a los cálculos y crea
% todos los objetos necesarios y llama a las funciones auxiliares. la
% interfaz (la función MainGrafico) se comunica con el módulo de cálculo
% mediante un objeto de esta clase. Por lo tanto, aquí se encuentran todos
% los métodos necesarios para llevar a cabo el cálculo de la placa de forma
% ordenada

classdef MainCalculo < handle
    
%% Propiedades de clase  
    properties (GetAccess = 'public', SetAccess = 'private')        
        vPoisson                %Módulo de Poisson
        EYoung                  %Módulo de Elasticidad
        thickness               %Espesor (constante)
        densidad                %Densidad del material
        
        AreasCargadas           %Lista de objetos AreaCargada (cargas repartidas)
        CargasPunt              %Lista de objetos AreaCargada (cargas repartidas)
        contorno                %Lista de objetos Contorno (contorno y agujeros)
        
        nodos                   %Lista de objetos Nodo (nodos)
        elementos               %Lista de objetos DKTElem (elementos)
        Kensamblada             %Matriz de rigidez global ensamblada
        Fensamblada             %Vector de cargas global ensamblado
        DespEnsamblada          %Vector global de desplazamientos
    end
    
    properties (Access=private) 
        % propiedades que no se pueden consultar desde Matlab ni desde el
        % exterior del método (código más limpio y encapsulado)
        
        numNodosElemento        %Número de nodos por elemento
        DOF                     %Grados de libertad de cada nodo
        p                       %lista con la posición de cada nodo
        t                       %lista con las adyacencias de cada elemento en numeración global de nodos
        Ksistema                %Matriz de rigidez reducida para el cálculo del sistema
        Fsistema                %Vector global de cargas reducido para el cálculo del sistema
        listFreeRows            %Lista de filas del sistema con desplazamiento impedido
        listCCRows              %Lista de filas del ssitema con desplazamiento libre
        Desp                    %Resultado de desplazamientos de las filas sin restricción según el sistema de ecuaciones       
    end
    
%% Método Constructor
methods (Access=public)
        
        function e = MainCalculo()
            e.DOF=3;                     
            e.numNodosElemento=3;
            e.CargasPunt=repmat(CargaPunt,0,0);
            e.AreasCargadas= repmat(AreaCargada,0,0);
            e.contorno=repmat(Contorno,0,0);
            e.contorno=repmat(Contorno,0,0);
        end
end
%% Métodos de Interacción externa: acceso público
methods (Access=public) 
    
        function reset(e)
            % Resetea todos los valores para volver el estado de cálculo al
            % principio
            
            e.vPoisson=[];
            e.EYoung=[];
            e.thickness=[];
            e.DOF=3;
            e.numNodosElemento=3;
            e.AreasCargadas=repmat(AreaCargada,0,0);
            e.CargasPunt=repmat(CargaPunt,0,0);
            e.contorno=repmat(Contorno,0,0);
            e.p=[];
            e.t=[];
            e.Kensamblada=[];
            e.nodos=repmat(Nodo(),0,0);
            e.elementos=repmat(DKTElem(),0,0);
            e.Fensamblada=[];
            e.Ksistema=[];
            e.Fsistema=[];
            e.DespEnsamblada=[];
            e.Desp=[];
            e.listFreeRows=[];
            e.listCCRows=[];
        end
        
        function addAreaCargada(e,nodos,carga)
            % Añade una carga repartida, creando el objeto de AreaCargada y
            % añadiéndolo a la lista
            Acarga=AreaCargada(nodos,carga);
            e.AreasCargadas(length(e.AreasCargadas)+1)=Acarga;
        end
        
        function addCargaPunt(e,nodo,carga)
            % Añade una carga puntual, creando el objeto de CargaPunt y
            % añadiéndolo a la lista           
            cargaP=CargaPunt(nodo,carga);
            e.CargasPunt(length(e.CargasPunt)+1)=cargaP;
        end
        
        function setMaterial(e,poisson,E,th,density)
            % Actualiza los valores de las variables de las propiedades
            % materiales según los parámetros de entrada de la función
            
            e.vPoisson=poisson;
            e.EYoung=E;
            e.thickness=th;
            e.densidad=density;
        end
        
        function [desp,momentos,err]=obtenerDespMomentos(e,punto)
            % Dado un punto cualquiera, se mira si el punto pertenece a
            % algún elemento de la placa y se calculan los desplazamientos
            % y momentos aproximados. Si no existe se envía error
            
            desp=[0;0;0];
            err=1;
            for i=1:length(e.elementos)
                if inpolygon(punto(1),punto(2),e.elementos(i).getX(),e.elementos(i).getY())
                    desp=e.elementos(i).obtenerDesplazamiento(punto);
                    momentos=e.elementos(i).obtenerMomentos(punto);
                    err=0;
                    break;
                end
            end
        end
        
        function momentos=getMomentosNodo(e,n)
            % Se obtienen los momentos de un nodo de la placa, según la
            % media de todos los elementos que incluyen el nodo
            elems=e.nodos(n).getElementos();
            momentosMatriz=[];
            for i=1:length(elems)
            momentosMatriz=[momentosMatriz elems(i).obtenerMomentos([e.nodos(n).getX(),e.nodos(n).getY()])];
            end
            momentos=[0;0;0];
            for i=1:size(momentosMatriz,2)
                momentos=momentos+momentosMatriz(:,i);
            end
            momentos=momentos/i;
        end
        
        function desp=getDesp(e,numnodo)
            % Se obtienen los desplazamientos de un nodo
            desp=e.nodos(numnodo).getDesp();
        end
        
        function addContorno(e,nodosCont)
            % Añade un contorno o agujero a la placa, creando el objeto de
            % Contorno y añadiéndolo a la lista
            e.contorno(length(e.contorno)+1)=Contorno(nodosCont);
        end
        
        function addCondCont(e,numnodo,contorno)
            % Asigna una condición de contorno determinadas a un nodo
            e.nodos(numnodo).addCC(contorno);
        end
        
        function calcularDesplazamientos(e)
            % Crea las matrices reducidas del sistema según las condiciones
            % impuestas, calcula los desplazamientos y crea el vector
            % global de desplazamientos.
            
            [e.Ksistema, e.Fsistema,e.listCCRows,e.listFreeRows]= crearMatricesSistema(e.nodos,e.Kensamblada,e.Fensamblada,e.DOF);
            e.Desp= e.Ksistema\e.Fsistema;
            e.DespEnsamblada=ensamblarDesp(e.nodos,e.Desp,e.listFreeRows,e.DOF);
        end
        
        function [pp,tt]=calcularMalla(e,pesopropio,meshsize)
            % Crea la malla y después Crea la lista de nodos, la lista de elementos, y calcula la
            % matriz ensamblada y el vector de fuerzas ensamblado.
            
            %Creación de la malla
            [e.p,e.t]=setMesh(e.contorno,e.AreasCargadas,e.CargasPunt,meshsize);
            
            %Creación de los nodos (array de objetos Nodo)
            e.nodos = repmat(Nodo(),1,size(e.p,1));
            for i=1:size(e.p,1)
                e.nodos(i)=Nodo(i,e.p(i,1),e.p(i,2));
            end

            %Creación de los elementos (array de objetos DKT)
            e.elementos = repmat(DKTElem(),1,size(e.t,1));
            for i=1:size(e.t,1)
                 e.elementos(i)=DKTElem(e.vPoisson, e.EYoung, e.thickness, i, e.nodos(e.t(i,1)), e.nodos(e.t(i,2)), e.nodos(e.t(i,3)));
            end

            %Cálculo de la matriz de rigidez ensamblada
            e.Kensamblada=ensamblarMatriz(e.elementos, e.DOF,length(e.nodos));

            %Se asignan las cargas puntuales a sus nodos
            for i=1:length(e.CargasPunt)
            e.CargasPunt(i).setNodoCargaPunt(e.nodos);
            end
            
            %Se asignan las cargas repartidas a los elementos que se ven
            %afectados
            for i=1:length(e.AreasCargadas)
            e.AreasCargadas(i).setElemCargaUnif(e.elementos);
            end
            
            %Se añade el peso propio como una carga repartida más si la
            %opción está activa
            if (pesopropio==1)
                e.addPesoPropio();
            end
            
            %Se calculan los vectores de cargas equivalentes de los nodos
            %para todos los elementos
            for i=1:length(e.elementos)
                e.elementos(i).calcVectorCargas();
            end
            
            %Se calculan los vectores finales de carga de todos los nodos
            for i=1:length(e.nodos)
                e.nodos(i).calcVectCarga();
            end
            
            %Se crea el vector global ensamblado de cargas
            e.Fensamblada=ensamblarCargas(e.nodos, e.DOF);
            
            pp=e.p;
            tt=e.t;
        end
end

%% Metodos internos: acceso privado
methods (Access=private) 
        function addPesoPropio(e)
            %Añade a todos los elementos una carga repartida igual al peso
            %del material
            for i=1:length(e.elementos)
                e.elementos(i).addCargaUnif([-e.densidad*e.thickness*9.81;0;0]);
            end
        end
                 
        function plotMalla(e)
            %Crea un gráfico con la malla
            figure('Name','Meshplot')
            plot(e.p(:,1),e.p(:,2),'b.','markersize',1);
        end
            
    end
end
