% TÍTULO: Clase CargaPunt para CalculoPlacasMEF
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
% Clase que almacena una carga puntual. Se almacena el nodo de aplicación
% de la malla y el valor de la carga

classdef CargaPunt < handle


%% Propiedades de clase
    properties
        nodo            %Vector con las coordenadas de aplicación
        carga           %Carga Puntual aplicada
        NodoPlaca       %Objeto del Nodo de la malla donde se aplica la carga
    end
    
    properties (Access=private) 
        % propiedades que no se pueden consultar desde Matlab ni desde el
        % exterior del método (código más limpio y encapsulado)
        
        pointNodes      %Creación del poligono para el programa de mallado
        meshNodes       %Nodos para el programa de mallado
        meshNum         %Número para el programa de mallado
        meshEdges       %Líneas de contorno para el programa de mallado
    end    
    
%% Método Constructor
methods (Access=public)
    
        function e=CargaPunt(nodo, carga)
            if nargin >0
            e.nodo=nodo;
            e.carga=carga;
            e.pointNodes=e.setMeshNodes(e.nodo);
            e.meshNodes=e.calcMeshNodes(e.pointNodes);
            e.meshNum=size(e.meshNodes,1);
            e.meshEdges=[(1:e.meshNum-1)', (2:e.meshNum)'; e.meshNum, 1];
            e.NodoPlaca=repmat(Nodo,0,0);
            end
        end
 end
    
%% Métodos Gets y Sets: acceso público
methods (Access=public)
    
        function nodo= getNode(e)
            nodo=e.nodo;
        end
        
        function meshNodes= getMeshNodes(e)
            meshNodes=e.meshNodes;
        end
        
        function meshNum= getMeshNum(e)
            meshNum=e.meshNum;
        end
        
        function meshEdges= getMeshEdges(e)
            meshEdges=e.meshEdges;
        end
        
        function carga= getCarga(e)
            carga=e.carga;
        end
end 

%% Métodos de acceso externo: acceso público
methods (Access=public)
        
        function setNodoCargaPunt(e,nodos)
            % Recorre la lista de nodos hasta que encuentra el nodo donde
            % está aplicada la carga puntual. Entonces añade la carga al
            % nodo.
            
            for i=1:length(nodos)
                if (e.nodo(1)==nodos(i).getX() && e.nodo(2)==nodos(i).getY()) 
                    e.NodoPlaca=nodos(i);
                    nodos(i).addCargaPunt(e.carga);
                    break
                end
            end   
        end   
end
    
%% Métodos de acceso interno: acceso privado
methods (Access=private)
            
        function [n] = calcMeshNodes( e, areaCargada )
            % Calcula la serie de nodos como parametros del programa de
            % mallado
            
            n=zeros(2*size(areaCargada,1)+1,2);
            for i=1:size(areaCargada,1)
                n(i,:)=areaCargada(i,:);
            end
                i=i+1;
                n(i,:)=areaCargada(1,:);

            for j=1:size(areaCargada,1)
                n(i+j,:)=areaCargada(size(areaCargada,1)+1-j,:);
            end
        end
        
        function [n] = setMeshNodes( e, nodo )
            % Obtiene los nodos de una linea vertical unida con una
            % horizontal, de pequeño tamaño, unidas en el nodo de la carga.
            % Se usa para el mallado
            
            size=0.5;
            n=[nodo(1)-size nodo(2); nodo(1) nodo(2); ...
            nodo(1) nodo(2)+size];      
        end
end    
end