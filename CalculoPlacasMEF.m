% T�TULO: Script CalculoPlacasMEF para CalculoPlacasMEF
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
% Este es el script inicial para correr el programa. Elimina todas las
% variables previas, cierra las ventanas creadas por Matlab y limpia la
% pantalla de comandos y a�ade todas las subcarpetas de inter�s al entorno
%
% Para correr el programa, se crea un objeto de la clase MainCalculo,
% n�cleo del m�dulo de calculo, y luego se llama la funci�n MainGrafico,
% que es la interfaz del programa, pasando este objeto como par�metro en la
% funci�n. De esta forma, se ejecuta la interfaz con comunicaci�n con el
% m�dulo de c�lculo a trav�s de este objeto


addpath(genpath(pwd));
clear all;
clc;
clear;
close all;

calculo=MainCalculo();
MainGrafico(calculo);