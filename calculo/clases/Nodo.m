% T�TULO: Clase Nodo para CalculoPlacasMEF
% AUTOR: Joan Morat� Guardia
% CONTACTO: j.morato.91@gmail.com
% ESTUDIOS: Tesina de Ingenier�a de Caminos, Canales y Puertos
% UNIVERSIDAD: Universitat Polit�cnica de Catalunya
% FECHA: Marzo 2015
% LICENCIA: El usuario puede redistribuir, modificar, extender o adaptar el
% programa sin restricciones, citando la fuente original y manteniendo la
% licencia.
%
% DESCRIPCI�N: 
%
% Clase para guardar la informaci�n de los nodos. Esto es, coordenadas
% y numeraci�n, as� como los elementos de los que forma parte y las cargas
% que tiene asignadas

classdef Nodo < handle
    
    properties (GetAccess = 'public', SetAccess = 'private')        
        ID          % Numeraci�n del nodo
        x, y        % Coordenadas de los nodos
        elems       % Array de los elementos de los que forma parte el nodo
        cargaPunt   % Vector de carga puntual aplicada
        cargaUnif   % Vector de las cargas equivalentes debidas a cargas repartidas en sus elementos adyacentes
        vectCarga   % Vector total de carga
        cc          % condiciones de contorno: array de 3 valores, uno para cada desplazamiento
                    % flecha y giros x e y. Vale 1 si el desplazamiento
                    % est� impedido o 0 en cualquier otro caso
        desp
    end
    
    properties (Access=private) 
    % propiedades que no se pueden consultar desde Matlab ni desde el
    % exterior del m�todo (c�digo m�s limpio y encapsulado)

        index       % �ndice del n�mero de elementos
    end    
        
%% M�todo Constructor
    methods (Access=public)
        function e = Nodo(n, x, y)
            if nargin>0
           e.ID=n;
           e.x=x;
           e.y=y;
           e.index=1;
           e.elems = repmat(DKTElem(),1,0);
           e.cargaPunt=0;
           e.cargaUnif=[0;0;0];
           e.vectCarga=[0;0;0];
           e.cc=[0;0;0];
           e.desp=zeros(3,1);
            end
        end
 end

%% M�todos Gets y Sets: acceso p�blico
methods (Access=public)
    
        function carga= getCarga(e)
            carga=e.cargaPunt;
        end
        
        function ID= getID(e)
            ID=e.ID;
        end
        
        function x= getX(e)
            x=e.x;
        end
        
        function y= getY(e)
            y=e.y;
        end
        
        function vectCarga= getVectCarga(e)
            vectCarga=e.vectCarga;
        end
        
        function cc= getCC(e)
            cc=e.cc;
        end
        
        function elementos=getElementos(e)
            elementos=e.elems;
        end
        
        function setDesp(e,desp,i)
            e.desp(i)=desp;
        end
        
        function desp=getDesp(e)
            desp=e.desp;
        end

end
    
%% M�todos de acceso externo: acceso p�blico
methods (Access=public)
    
        function addElement(e, element)
            % A�ade un elemento al cual pertenece el nodo
            e.elems(e.index)=element;
            e.index=e.index+1;
        end
        
        function addCargaPunt (e,carga)
            % Suma una carga puntual al vector de cargas puntuales
            e.cargaPunt=e.cargaPunt+carga;
        end 
        
        function addCargaUnif (e,carga)
            % Suma una carga repartida equivalente al vector correspondiente
            e.cargaUnif=e.cargaUnif+carga;
        end
        
        function addCC(e,tipo)
            % Asigna una condici�n de contorno al nodo, determinando los
            % desplazamientos impedidos
            
            switch tipo
                case 'empotramiento'
                    e.cc=[1;1;1];
                    e.desp=[0;0;0];             
                case 'apoyoX'
                    e.cc(1)=1;
                    e.cc(2)=1;
                    e.desp(1)=0;
                    e.desp(2)=0;
                case 'apoyoY'
                    e.cc(1)=1;
                    e.cc(3)=1;
                    e.desp(1)=0;
                    e.desp(3)=0;
                case 'apoyoPuntual'
                    e.cc(1)=1;
                    e.desp(1)=0;
                otherwise
                    error('Condici�n de contorno mal escrita. Comprobar String');
            end
        end
        
        function calcVectCarga (e)
            % Calcula el vector global de carga del Nodo
            e.vectCarga=e.cargaUnif+e.cargaPunt;
        end
        
    end
end