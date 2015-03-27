% T�TULO: Clase AreaCargada para CalculoPlacasMEF
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
% Clase que almacena un �rea (seg�n los puntos del pol�gono que la
% forman) donde hay una carga repartida sobre la placa. Se almacena el
% �rea y la carga

classdef AreaCargada < handle

%% Propiedades de clase
    properties
        nodos       %Nodos que forman el poligono donde se aplica la carga
        carga       %Carga repartida aplicada sobre el �rea
        elemPlaca   %Array de los elementos de placa que se ven afectados por
                    %la carga uniforme
    end
    
    properties (Access=private) 
        % propiedades que no se pueden consultar desde Matlab ni desde el
        % exterior del m�todo (c�digo m�s limpio y encapsulado)
        
        meshNodes   %Nodos para el programa de mallado
        meshNum     %N�mero para el programa de mallado
        meshEdges   %L�neas de contorno para el programa de mallado
    end
    
%% M�todo Constructor
methods (Access=public)
        function e=AreaCargada(nodos, carga)
            if nargin >0
            e.nodos=nodos;
            e.carga=carga;
            e.meshNodes=e.calcMeshNodes(e.nodos);
            e.meshNum=size(e.meshNodes,1);
            e.meshEdges=[(1:e.meshNum-1)', (2:e.meshNum)'; e.meshNum, 1];
            e.elemPlaca=repmat(DKTElem,0,0);
            end
        end
end
    
%% M�todos Gets y Sets: acceso p�blico
methods (Access=public)
        function nodos= getNodos(e)
            nodos=e.nodos;
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
    
%% M�todos de acceso externo: acceso p�blico
methods (Access=public)       
        
        function setElemCargaUnif(e,elementos)
            %Recorre los elementos de la placa y aplica la carga uniforme a
            %los que est�n dentro del area de aplicaci�n
            
            poly=e.nodos;
            polyX=poly(:,1)';
            polyY=poly(:,2)';
            for i=1:length(elementos)
                centro=elementos(i).getCentro();
                if (inpolygon(centro(1),centro(2),polyX,polyY))
                    e.addElem(elementos(i));
                    elementos(i).addCargaUnif(e.getCarga());
                end
            end
        end
        
end
    
%% M�todos de acceso interno: acceso privado
methods (Access=private)
    
        function addElem(e,element)
            %A�ade un elemento al array de elementos afectados por la carga            
            e.elemPlaca(length(e.elemPlaca)+1)=element;
        end
        
        function [n] = calcMeshNodes( e, areaCargada )
            %Calcula la serie de nodos como par�metros del programa de mallado            
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
end
end

