% TÍTULO: Función crearMatricesSistema para CalculoPlacasMEF
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
% Esta función recibe la matriz global de rigidez ensamblada y el vector de
% cargas global ensamblado, así como los nodos y el número de grados de
% libertad por nodo. Lee las condiciones de contorno de los nodos para
% devolver las matrices y vectores reducidos según los desplazamientos
% impedidos

function [Ksistema,Fsistema,listCCRows,listFreeRows]=crearMatricesSistema(nodos,K,F,DOF)

listCCRows=[]; %Lista de las filas que tienen el desplazamiento impedido
index=1;
listFreeRows=[]; %Lista de las filas que tienen el desplazamiento libre
index2=1;
for i=1:length(nodos)
    %Lee las condiciones de contorno de cada nodo
    cc=nodos(i).getCC();
    ID=nodos(i).getID();
    for j=1:length(cc);
        if (cc(j)==1)
            %Si un desplazamiento está impedido, se crea una nueva fila en
            %la lista de filas con desplazamiento impedido
            listCCRows(index,1)=1+(ID-1)*DOF+(j-1); %posición global de la fila
            listCCRows(index,2)=ID; %Numeración del nodo
            listCCRows(index,3)=j; %Posición del desplazamiento impedido dentro del nodo (1-3)
            index=index+1;
        else
            %Si un desplazamiento es libre, se crea una nueva fila en
            %la lista de filas con desplazamiento libre
            listFreeRows(index2,1)=1+(ID-1)*DOF+(j-1); %posición global de la fila
            listFreeRows(index2,2)=ID; %Numeración del nodo
            listFreeRows(index2,3)=j; %Posición del desplazamiento impedido dentro del nodo (1-3)
            index2=index2+1;
        end
    end 
end

index=0;
Ksistema=K;
Fsistema=F;

%Se eliminan todas las filas y columnas de K donde el desplazamiento está
%impedido según la lista creada, y las mismas filas en el vector de cargas
for i=1:size(listCCRows,1)
    j=listCCRows(i,1)-index;
    Ksistema(j,:)=[];
    Ksistema(:,j)=[];
    Fsistema(j)=[];
    index=index+1;
end

end