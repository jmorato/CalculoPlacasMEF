% TÍTULO: Clase cargaunif para CalculoPlacasMEF
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
% Esta clase almacena la información de todos los objetos tipo cargaunif de
% la interfaz del programa. Almacena la información referente a todas las
% cargas que actúan sobre una área repartida. Se almacenan las
% características del contorno y los nodos y líneas asociados, así como el
% valor de la carga y el objeto gráfico correspondiente


classdef cargaunif 
    
    properties
        nusos;           % Lista de nodos que forman el contorno del área cargada
        barres;          % Lista de lineas que forman el contorno del área cargada         
        carga=[0;0;0];   % Vector de la carga aplicada sobre el área
        hg=[];           % handle del objeto hgtransform que contiene el dibujo de la carga repartida
    end
    
    methods
    end
    
end