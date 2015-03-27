% T�TULO: Clase cargaunif para CalculoPlacasMEF
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
% Esta clase almacena la informaci�n de todos los objetos tipo cargaunif de
% la interfaz del programa. Almacena la informaci�n referente a todas las
% cargas que act�an sobre una �rea repartida. Se almacenan las
% caracter�sticas del contorno y los nodos y l�neas asociados, as� como el
% valor de la carga y el objeto gr�fico correspondiente


classdef cargaunif 
    
    properties
        nusos;           % Lista de nodos que forman el contorno del �rea cargada
        barres;          % Lista de lineas que forman el contorno del �rea cargada         
        carga=[0;0;0];   % Vector de la carga aplicada sobre el �rea
        hg=[];           % handle del objeto hgtransform que contiene el dibujo de la carga repartida
    end
    
    methods
    end
    
end