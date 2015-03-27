% T�TULO: Clase Contorno para CalculoPlacasMEF
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
% Clase que almacena el poligono que forma el contorno de la placa

classdef Contorno < handle

%% Propiedades de clase    
    properties
        nodos       %Nodos que forman el contorno de la placa
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
    
        function e=Contorno(nodos)
            if nargin >0
            e.nodos=nodos;
            e.meshNodes=e.nodos;
            e.meshNum=size(e.meshNodes,1);
            e.meshEdges=[(1:e.meshNum-1)', (2:e.meshNum)'; e.meshNum, 1];
            end
        end
        
end

%% M�todos Gets y Sets: acceso p�blico
methods (Access=public)
    
        function nodos= getNodes(e)
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
end    
end