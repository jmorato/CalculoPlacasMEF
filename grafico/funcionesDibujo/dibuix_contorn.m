% T�TULO: Funci�n dibuix_carreganus para CalculoPlacasMEF
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
% Esta funci�n realiza el dibujo en pantalla de los objetos contorno, es
% decir, dibuja sobre el gr�fico los nodos seg�n su condici�n de contorno
% (apoyo, libre, empotramiento...). Recibe los par�metros necesarios para
% realizar el dibujo: la posici�n, el valor, el �ngulo, el tama�o de
% fuente, etc. y devuelve finalmente el objeto gr�fico correspondiente

function [contorn] = dibuix_contorn(tipus,distnum,fontnusos,tamanyfontnusos,flagMalla)
contorn=hgtransform;
text(-distnum,distnum,'0','FontName',fontnusos,'FontUnits','pixels','FontSize',tamanyfontnusos,'HorizontalAlignment','right','Parent',contorn,'Clipping','on','HitTest','off');
if flagMalla==1;
    midaCreu=0;
else
    midaCreu=0.1;
end
switch tipus
    case {'libre',1}
        line([-midaCreu,midaCreu],[0,0],[0,0],'color','k','Parent',contorn,'Clipping','on','HitTest','off');
        line([0,0],[-midaCreu,midaCreu],[0,0],'color','k','Parent',contorn,'Clipping','on','HitTest','off');
        line([0,0],[0,0],[-midaCreu,midaCreu],'color','k','Parent',contorn,'Clipping','on','HitTest','off');
    case {'apoyoPuntual',2}
        cercle(contorn,0,0,.030); % C�rculo
        line([-.08,0,.08,-.08],[-.170,-.030,-.170,-.170],'color','k','Parent',contorn,'Clipping','on','HitTest','off'); % Tri�ngulo
        
    case {'apoyoX',3}
        cercle(contorn,0,0,.030); % C�rculo
        line([-.08,0,.08],[-.170,-.030,-.170],'color','k','Parent',contorn,'Clipping','on','HitTest','off'); % Tri�ngulo
        massis(contorn,-.16,.16,-.170);
    case {'apoyoY',4}
        cercle(contorn,0,0,.030); % C�rculo
        line([-.08,0,.08],[-.170,-.030,-.170],'color','k','Parent',contorn,'Clipping','on','HitTest','off'); % Tri�ngulo
        massis(contorn,-.16,.16,-.170);        
    case {'empotramiento',5}
        cercle(contorn,0,0,.030);
        massis(contorn,-.16,.16,0);
end
set(contorn,'Clipping','on','HitTestArea','on','HitTest','off');

end

function [] = massis(h,xini,xfin,y)
line([xini,xfin],[y,y],'color','k','LineWidth',2,'Parent',h,'Clipping','on','HitTest','off'); % L�nia secci�n horizontal
line([xini,xini+.04],[y-.04,y],'color','k','Parent',h,'Clipping','on','HitTest','off');
line([xini,xini+.08],[y-.08,y],'color','k','Parent',h,'Clipping','on','HitTest','off');
for x=xini:.04:xfin-.12
    line([x,x+.12],[y-.12,y],'color','k','Parent',h,'Clipping','on','HitTest','off');
end
line([xfin-.08,xfin],[y-.12,y-.04],'color','k','Parent',h,'Clipping','on','HitTest','off');
line([xfin-.04,xfin],[y-.12,y-.08],'color','k','Parent',h,'Clipping','on','HitTest','off');
end

function [] = cercle(h,x,y,r)
c=0:pi/12:2*pi;
line(r*sin(c)-x,r*cos(c)+y,'color','k','Parent',h,'Clipping','on','HitTest','off');
end
