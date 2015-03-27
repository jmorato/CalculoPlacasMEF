% T�TULO: Clase nus para CalculoPlacasMEF
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
% Esta clase almacena la informaci�n de todos los objetos tipo nodo de la
% interfaz del programa. Es decir, de todos los puntos dibujados,
% que se usan para aplicar cargas, para dibujar contornos, para mostrar la
% malla, etc. Se guardan los datos importantes como sus coordenadas o sus
% desplazamientos, as� como los objetos gr�ficos que les coresponden


classdef nus 

    properties
        num=0; % N�mero de nodo
        posicio=[0,0,0]; % Coordenadas
        contorn='libre'; % Tipo de condici�n de contorno (5 posibles)
        desp=[0;0;0]; % vector de desplazamientos del nodo
        gir=0; % rotaci�n del dibujo del nodo
        hg=[]; % handle del objeto hgtransform que contiene el dibujo del nodo
        hgc=[]; % handle del objeto hgtransform que contiene el dibujo de la carga aplicada al nodo
        puntual=[0;0;0]; % Vector de cargas aplicadas sobre el nodo
        moment=[0;0;0]; % Vector de momentos resultantes
    end
    
    methods
        function x=getX(e)
            x=e.posicio(1);
        end
        
        function y=getY(e)
            y=e.posicio(2);
        end 
    end
    
end

