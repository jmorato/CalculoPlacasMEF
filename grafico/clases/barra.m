% T�TULO: Clase barra para CalculoPlacasMEF
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
% Esta clase almacena la informaci�n de todos los objetos tipo l�nea de la
% interfaz del programa. Es decir, de las l�neas que unen nodos para formar
% los contornos de la placa o las �reas de carga repartida, as� como los
% objetos gr�ficos temporales que se crean.

classdef barra

    properties
        num=0;                      % N�mero de barra.
        nusinf=0;                   % N�mero de nodo inferior
        nussup=0;                   % N�mero de nodo superior
        color='k';                  % Color de la barra.
        hg                          % handle al objeto gr�fico
        esCarga=0;                  % Variable que controla si la linea es de contorno o de carga repartida
        cargada=0;                  % Variable que controla si la l�nea forma parte de una �rea ya cargada
    end
    
    methods       
    end
    
end

