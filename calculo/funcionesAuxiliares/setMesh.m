% TÍTULO: Función setMesh para CalculoPlacasMEF
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
% Esta función recibe los objetos de contorno, cargas puntuales, cargas
% repartidas y el tamaño máximo del elemento. Prepara y junta los datos y
% envía la información al programa de mallado Mesh2D, según la entrada que
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

%Cálculo de la malla con el programa Mesh2d
[p,t]=mesh2d(nodes,conn,hdata,options);
end