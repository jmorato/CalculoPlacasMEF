% T�TULO: Funci�n dlgacerca para CalculoPlacasMEF
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
% La funci�n muestra una caja de texto por pantalla donde se
% muestran las principales caracter�sticas del programa, autor,
% descripci�n, licencia, etc. hasta que es cerrado por el usuario

function  dlgacerca()
%% CREA LA VENTANA, LOS PANELES Y BOTONES
tamanycme2=get(gcf,'Position');
tm=[tamanycme2(3)*0.8 tamanycme2(4)*0.8] ;
sc=(tamanycme2(3:4)-tm(1:2))/2+tamanycme2(1:2);
bg=get(0,'defaultUicontrolBackgroundColor');
f = figure('Units','pixels','Position',[sc,tm],'NumberTitle','off','Name','Tutorial','Toolbar','none','Menubar','none','Resize','off','WindowStyle','modal','color',bg,'KeyPressFcn',@tecla);
uicontrol(f,'Units','pixels','Position',[tm(1)/2-110/2,5+30/2,110,30],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Acceptar','Callback',@acceptar);

%% CREACI�N DEL TEXTO QUE SE MUESTRA POR PANTALLA.

   string=sprintf(['Programa desarrollado por: Joan Morat� Guardia\ne-mail: j.morato.91@gmail.com\n\n'...
       'Tesina: Creaci�n de software abierto con fin pedag�gico de c�lculo de placas por elementos finitos\n'...
       'Universidad: Universitat Polit�cnica de Catalunya\n'...
       'Licenciatura: Ingenier�a de Caminos, Canales y Puertos\n'...
       'A�o: 2015\n\n'...
       'Menciones especiales: \n    - Sergio Guerrero Miralles, de cuyo programa se han adaptado partes de la interfaz gr�fica y que ha servido de gran inspiraci�n.'...
       '\n    - Darren Engwirda, creador del programa "Mesh2d" que sirve como mallador a este programa.\n\n'...
       'Agradecimientos: a los profesores Miguel Cervera y Joan Baiges, por tutorizar la tesina y'...
       ' apoyar su desarrollo en todo momento\n\n'...
       '�ltima actualizaci�n: Marzo 2015\n'...
       'Licencia: El usuario es libre de usar, modificar y redistribuir este software, mencionando siempre su origen y manteniendo la licencia en redistribuciones posteriores\n\n'...
       'Por favor, notificar por e-mail cualquier sugerencia, bug o error observado. �Gracias por su colaboraci�n!']);
uicontrol(f,'Units','pixels','Position',[15,50,tm(1)-10,tm(2)-80],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String',string); % Etiqueta.
uiwait(f) % Para la ejecuci�n de Matlab hasta que se cierre la ventana y se devuelvan los datos

%% FUNCI�N QUE SE EJECUTA CUANDO SE PULSA ACEPTAR
% Cierra la caja de texto

    function acceptar(hObject, eventdata, handles)
        close(f)
    end

%% FUNCI�N QUE SE EJECUTA CUANDO SE PULSA ALGUNA TECLA
% Si se pulsa retorno o ESC, se cierra la caja de di�logo

    function tecla(hObject,eventdata,handles)
        switch eventdata.Key
            case 'escape'
                acceptar
            case 'return'
                uicontrol(hObject)
                acceptar
        end
    end
end