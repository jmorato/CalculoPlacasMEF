% T�TULO: Funci�n ensamblarCargas para CalculoPlacasMEF
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
% Esta funci�n recibe la lista de nodos y los grados de libertad por nodo y
% ensambla el vector global de cargas. Se recorren todas las submatrices de
% todos los elementos, y se a�aden a la matriz de rigidez global seg�n la
% numeraci�n global de los nodos de la submatriz

function [ Fensamblada ] = ensamblarCargas(nodos, DOF)

mat=zeros(length(nodos)*DOF,1);
for i=1:length(nodos);
    ID=nodos(i).getID();
    mat(1+(ID-1)*DOF:(ID*DOF),1)=nodos(i).getVectCarga();
end
Fensamblada=mat;
end

