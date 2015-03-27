% TÍTULO: Función dibuix_carreganus para CalculoPlacasMEF
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
% Esta función realiza el dibujo en pantalla de los objetos carreganus, es
% decir, dibuja sobre el gráfico las cargas puntuales aplicadas sobre nodos y sus
% valores según corresponde. Recibe los parámetros necesarios para realizar
% el dibujo: la posición, el valor, el ángulo, el tamaño de fuente, etc. y
% devuelve finalmente el objeto gráfico correspondiente

function hgcarrega = dibuix_carreganus(n,posicio,cargas,fontcarregues,tamanyfontcarregues)

    tol=1e-8; % Valor mínim, per evitar mostrar errors d'arrodoniment a 0.
    if any(cargas)
        hgcarrega=hgtransform('HitTestArea','on','Clipping','on','UserData',n); % Crea l'objecte hgtransform.
            halin='center';
            size=0.15;
            rombo=[-size 0 size 0 -size;0 size 0 -size 0; 0 0 0 0 0];
            line(rombo(1,:),rombo(2,:),rombo(3,:),'color','k','LineWidth',1.5,'Parent',hgcarrega,'HitTest','off','Clipping','on');
            patch(rombo(1,:)*1/3,rombo(2,:)*1/3,rombo(3,:)*1/3,'k','Parent',hgcarrega,'HitTest','off','Clipping','on');
            postxt=[0, size+0.1,0];
            string='';
            fz=0;
            mx=0;
            if abs(cargas(1))>tol
                string=strcat('Fz= ',num2str(cargas(1)),' N');
                fz=1;
            end
            if abs(cargas(2))>tol
                if fz
                    string= [string sprintf('\n')];
                end
                string= [string sprintf('%s',strcat('Mx= ',num2str(cargas(2)),' Nm'))];
                mx=1;
            end
            if abs(cargas(3))>tol
                if mx
                    string= [string sprintf('\n')];
                elseif fz
                    string= [string sprintf('\n')];
                end
                string= [string sprintf(strcat('My= ',num2str(cargas(3)),' Nm'))];
            end
            text(postxt(1),postxt(2),postxt(3),string,'FontName',fontcarregues,'FontUnits','pixels','FontSize',tamanyfontcarregues,'Parent',hgcarrega,'HorizontalAlignment',halin,'Clipping','on','HitTest','off','VerticalAlignment','Bottom')
    else
        hgcarrega=[];
    end
end

