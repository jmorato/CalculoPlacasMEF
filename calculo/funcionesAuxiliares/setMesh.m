% T�TULO: Funci�n setMesh para CalculoPlacasMEF
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
% Esta funci�n recibe los objetos de contorno, cargas puntuales, cargas
% repartidas y el tama�o m�ximo del elemento. Prepara y junta los datos y
% env�a la informaci�n al programa de mallado Mesh2D, seg�n la entrada que
% necesita este programa. Devuelve dos vectores con los nodos y sus
% adyacencias

function [p,t] = setMesh( contorno,AreasCargadas,CargasPunt,meshsize )

%Opciones de Mallado
hdata.hmax=meshsize;
options=[];

%Junta el contorno y las Areas de carga uniforme y puntual para determinar
%los nodos necesarios y sus relaciones para establecer la malla

nodes=[];
pos=0;
conn=[];
for i=1:length(contorno)
    conn=[conn;contorno(i).getMeshEdges()+pos];
    nodes=[nodes;contorno(i).getMeshNodes()];
    pos=pos+contorno(i).getMeshNum();
end

for i=1:length(AreasCargadas)
    conn=[conn;AreasCargadas(i).getMeshEdges()+pos];
    nodes=[nodes;AreasCargadas(i).getMeshNodes()];
    pos=pos+AreasCargadas(i).getMeshNum();
end

for i=1:length(CargasPunt)
    conn=[conn;CargasPunt(i).getMeshEdges()+pos];
    nodes=[nodes;CargasPunt(i).getMeshNodes()];
    pos=pos+CargasPunt(i).getMeshNum();
end

%C�lculo de la malla con el programa Mesh2d
[p,t]=mesh2d(nodes,conn,hdata,options);
end