% T�TULO: Funci�n ensamblarMatriz para CalculoPlacasMEF
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
% Esta funci�n recibe un array de elementos, el n�mero de grados de
% libertad de los nodos y el n�mero total de nodos del sistema. Con la
% uni�n adecuada de las distintas matrices de rigidez de los elementos,
% devuelve la matriz de rigidez global del sistema.

function [ Kensamblada ] = ensamblarMatriz(elementos, DOF, totalNodos)

mat=zeros(totalNodos*DOF);
numNodos=length(elementos(1).getNodos());

%Se recorren todas las submatrices de todos los elementos y se a�aden a la matriz de rigidez global seg�n la
%numeracion global de los nodos de la submatriz

for m=1:length(elementos);
    nodos=elementos(m).getNodos();
    for i=1:numNodos
        for j=1:numNodos
            Kelem=elementos(m).getK();
            submatK=Kelem(1+(i-1)*DOF:(i*DOF),1+(j-1)*DOF:(j*DOF));
            ID1=nodos(i).getID();
            ID2=nodos(j).getID();
            mat(1+(ID1-1)*DOF:(ID1*DOF),1+(ID2-1)*DOF:(ID2*DOF))=...
                mat(1+(ID1-1)*DOF:(ID1*DOF),1+(ID2-1)*DOF:(ID2*DOF))+submatK;
        end
        
    end
end
Kensamblada=mat;

end

