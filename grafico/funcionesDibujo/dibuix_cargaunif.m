% TÍTULO: Función dibuix_cargaunif para CalculoPlacasMEF
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
% Esta función realiza el dibujo en pantalla de los objetos cargaunif, es
% decir, dibuja sobre el gráfico las cargas repartidas aplicadas y sus
% valores según corresponde. Recibe los parámetros necesarios para realizar
% el dibujo: la posición, el valor, el ángulo, el tamaño de fuente, etc. y
% devuelve finalmente el objeto gráfico correspondiente

function hgcarrega = dibuix_cargaunif(n,posicio,cargas,fontcarregues,tamanyfontcarregues)

    tol=1e-8; % Valor mínim, per evitar mostrar errors d'arrodoniment a 0.

    if any(cargas)
        hgcarrega=hgtransform('HitTestArea','on','Clipping','on','UserData',n); % Crea l'objecte hgtransform.
        fz=0;
        mx=0;
        string='';
        if abs(cargas(1))>tol
            string=strcat('Fz= ',num2str(cargas(1)),' N/m^2');
            fz=1;
        end
        if abs(cargas(2))>tol
            if fz
                string= [string sprintf('\n')];
            end
            string= [string sprintf('%s',strcat('Mx= ',num2str(cargas(2)),' Nm/m^2'))];
            mx=1;
        end
        if abs(cargas(3))>tol
            if mx
                string= [string sprintf('\n')];
            elseif fz
                string= [string sprintf('\n')];
            end
            string= [string sprintf(strcat('My= ',num2str(cargas(3)),' Nm/m^2'))];
        end
        text(posicio(1),posicio(2),posicio(3),string,'FontName',fontcarregues,'FontUnits','pixels','FontSize',tamanyfontcarregues,'Parent',hgcarrega,'Color','b','HorizontalAlignment','center','VerticalAlignment','middle','HitTest','off','Clipping','on')
    else
        hgcarrega=[];
    end
end