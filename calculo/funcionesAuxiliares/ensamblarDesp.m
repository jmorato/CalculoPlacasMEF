% TÍTULO: Función ensamblarDesp para CalculoPlacasMEF
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
% Esta función recibe el vector resultante de desplazamientos del sistema y
% crea el vector global de desplazamientos, añadiendo en las posiciones
% adecuadas los desplazamientos impedidos

function [DespEnsamblada]=ensamblarDesp(nodos,desp,listFreeRows, DOF)

DespEnsamblada=zeros(length(nodos)*DOF,1);

for i=1:size(listFreeRows,1)
    DespEnsamblada(listFreeRows(i,1))=desp(i);
    nodos(listFreeRows(i,2)).setDesp(desp(i),listFreeRows(i,3));
end