% T�TULO: Funci�n crearMatricesSistema para CalculoPlacasMEF
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
% Esta funci�n recibe la matriz global de rigidez ensamblada y el vector de
% cargas global ensamblado, as� como los nodos y el n�mero de grados de
% libertad por nodo. Lee las condiciones de contorno de los nodos para
% devolver las matrices y vectores reducidos seg�n los desplazamientos
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
            %Si un desplazamiento est� impedido, se crea una nueva fila en
            %la lista de filas con desplazamiento impedido
            listCCRows(index,1)=1+(ID-1)*DOF+(j-1); %posici�n global de la fila
            listCCRows(index,2)=ID; %Numeraci�n del nodo
            listCCRows(index,3)=j; %Posici�n del desplazamiento impedido dentro del nodo (1-3)
            index=index+1;
        else
            %Si un desplazamiento es libre, se crea una nueva fila en
            %la lista de filas con desplazamiento libre
            listFreeRows(index2,1)=1+(ID-1)*DOF+(j-1); %posici�n global de la fila
            listFreeRows(index2,2)=ID; %Numeraci�n del nodo
            listFreeRows(index2,3)=j; %Posici�n del desplazamiento impedido dentro del nodo (1-3)
            index2=index2+1;
        end
    end 
end

index=0;
Ksistema=K;
Fsistema=F;

%Se eliminan todas las filas y columnas de K donde el desplazamiento est�
%impedido seg�n la lista creada, y las mismas filas en el vector de cargas
for i=1:size(listCCRows,1)
    j=listCCRows(i,1)-index;
    Ksistema(j,:)=[];
    Ksistema(:,j)=[];
    Fsistema(j)=[];
    index=index+1;
end

end