% TÍTULO: Clase barra para CalculoPlacasMEF
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
% Esta clase almacena la información de todos los objetos tipo línea de la
% interfaz del programa. Es decir, de las líneas que unen nodos para formar
% los contornos de la placa o las áreas de carga repartida, así como los
% objetos gráficos temporales que se crean.

classdef barra

    properties
        num=0;                      % Número de barra.
        nusinf=0;                   % Número de nodo inferior
        nussup=0;                   % Número de nodo superior
        color='k';                  % Color de la barra.
        hg                          % handle al objeto gráfico
        esCarga=0;                  % Variable que controla si la linea es de contorno o de carga repartida
        cargada=0;                  % Variable que controla si la línea forma parte de una área ya cargada
    end
    
    methods       
    end
    
end

