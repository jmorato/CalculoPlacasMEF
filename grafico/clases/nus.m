% TÍTULO: Clase nus para CalculoPlacasMEF
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
% Esta clase almacena la información de todos los objetos tipo nodo de la
% interfaz del programa. Es decir, de todos los puntos dibujados,
% que se usan para aplicar cargas, para dibujar contornos, para mostrar la
% malla, etc. Se guardan los datos importantes como sus coordenadas o sus
% desplazamientos, así como los objetos gráficos que les coresponden


classdef nus 

    properties
        num=0; % Número de nodo
        posicio=[0,0,0]; % Coordenadas
        contorn='libre'; % Tipo de condición de contorno (5 posibles)
        desp=[0;0;0]; % vector de desplazamientos del nodo
        gir=0; % rotación del dibujo del nodo
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

