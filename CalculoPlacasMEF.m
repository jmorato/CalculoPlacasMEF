% TÍTULO: Script CalculoPlacasMEF para CalculoPlacasMEF
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
% Este es el script inicial para correr el programa. Elimina todas las
% variables previas, cierra las ventanas creadas por Matlab y limpia la
% pantalla de comandos y añade todas las subcarpetas de interés al entorno
%
% Para correr el programa, se crea un objeto de la clase MainCalculo,
% núcleo del módulo de calculo, y luego se llama la función MainGrafico,
% que es la interfaz del programa, pasando este objeto como parámetro en la
% función. De esta forma, se ejecuta la interfaz con comunicación con el
% módulo de cálculo a través de este objeto


addpath(genpath(pwd));
clear all;
clc;
clear;
close all;

calculo=MainCalculo();
MainGrafico(calculo);