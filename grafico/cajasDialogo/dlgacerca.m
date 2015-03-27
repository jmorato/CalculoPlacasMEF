% TÍTULO: Función dlgacerca para CalculoPlacasMEF
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
% La función muestra una caja de texto por pantalla donde se
% muestran las principales características del programa, autor,
% descripción, licencia, etc. hasta que es cerrado por el usuario

function  dlgacerca()
%% CREA LA VENTANA, LOS PANELES Y BOTONES
tamanycme2=get(gcf,'Position');
tm=[tamanycme2(3)*0.8 tamanycme2(4)*0.8] ;
sc=(tamanycme2(3:4)-tm(1:2))/2+tamanycme2(1:2);
bg=get(0,'defaultUicontrolBackgroundColor');
f = figure('Units','pixels','Position',[sc,tm],'NumberTitle','off','Name','Tutorial','Toolbar','none','Menubar','none','Resize','off','WindowStyle','modal','color',bg,'KeyPressFcn',@tecla);
uicontrol(f,'Units','pixels','Position',[tm(1)/2-110/2,5+30/2,110,30],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Acceptar','Callback',@acceptar);

%% CREACIÓN DEL TEXTO QUE SE MUESTRA POR PANTALLA.

   string=sprintf(['Programa desarrollado por: Joan Morató Guardia\ne-mail: j.morato.91@gmail.com\n\n'...
       'Tesina: Creación de software abierto con fin pedagógico de cálculo de placas por elementos finitos\n'...
       'Universidad: Universitat Politècnica de Catalunya\n'...
       'Licenciatura: Ingeniería de Caminos, Canales y Puertos\n'...
       'Año: 2015\n\n'...
       'Menciones especiales: \n    - Sergio Guerrero Miralles, de cuyo programa se han adaptado partes de la interfaz gráfica y que ha servido de gran inspiración.'...
       '\n    - Darren Engwirda, creador del programa "Mesh2d" que sirve como mallador a este programa.\n\n'...
       'Agradecimientos: a los profesores Miguel Cervera y Joan Baiges, por tutorizar la tesina y'...
       ' apoyar su desarrollo en todo momento\n\n'...
       'Última actualización: Marzo 2015\n'...
       'Licencia: El usuario es libre de usar, modificar y redistribuir este software, mencionando siempre su origen y manteniendo la licencia en redistribuciones posteriores\n\n'...
       'Por favor, notificar por e-mail cualquier sugerencia, bug o error observado. ¡Gracias por su colaboración!']);
uicontrol(f,'Units','pixels','Position',[15,50,tm(1)-10,tm(2)-80],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String',string); % Etiqueta.
uiwait(f) % Para la ejecución de Matlab hasta que se cierre la ventana y se devuelvan los datos

%% FUNCIÓN QUE SE EJECUTA CUANDO SE PULSA ACEPTAR
% Cierra la caja de texto

    function acceptar(hObject, eventdata, handles)
        close(f)
    end

%% FUNCIÓN QUE SE EJECUTA CUANDO SE PULSA ALGUNA TECLA
% Si se pulsa retorno o ESC, se cierra la caja de diálogo

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