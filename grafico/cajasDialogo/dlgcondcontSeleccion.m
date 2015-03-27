% TÍTULO: Función dlgcondcontSeleccion para CalculoPlacasMEF
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
% Se muestra una caja de diálogo por pantalla donde el usuario puede
% seleccionar de un menú desplegable la condición de contorno para todos
% los nodos dentro de la selección


function [contorno,err] = dlgcondcontSeleccion()
%% CREA LA VENTANA, LOS PANELES Y BOTONES
err=1;
tamanycme2=get(gcf,'Position');
tm=[255,100];
sc=(tamanycme2(3:4)-tm(1:2))/2+tamanycme2(1:2);
bg=get(0,'defaultUicontrolBackgroundColor');
f = figure('Units','pixels','Position',[sc,tm],'NumberTitle','off','Name','Aplicar Condición de contorno a la selección','Toolbar','none','Menubar','none','Resize','off','WindowStyle','modal','color',bg,'KeyPressFcn',@tecla);
panelcontorn=uipanel(f,'Units','pixels','Position',[5 45 245 55],'BorderType','etchedin','BorderWidth',1,'FontName','default','FontUnits','pixels','FontSize',14,'Title','Condición de contorno:');
uicontrol(f,'Units','pixels','Position',[5,10,110,30],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Acceptar','Callback',@acceptar);
uicontrol(f,'Units','pixels','Position',[140,10,110,30],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Cancel·lar','Callback',@cancelar);

%% CREA EL PANEL CON LAS CONDICIONES DE CONTORNO

popupcontorn=uicontrol(panelcontorn,'Units','pixels','Position',[5,15,235,20],'Style','popupmenu','FontName','default','FontUnits','pixels','FontSize',14,'BackgroundColor','white','Value',1,'String',{'Nodo libre','Apoyo Simple','Apoyo a lo largo del eje X','Apoyo a lo largo del eje Y','Empotramiento'}); % Llista selecció condició de contorn.

uiwait(f) % Para la ejecución de Matlab hasta que se cierre la ventana y se devuelvan los datos


%% FUNCIÓN QUE SE EJECUTA CUANDO SE PULSA ACEPTAR
% Lee la condición de contorno obtenida del menú desplegable y la devuelve

    function acceptar(hObject, eventdata, handles)
     switch (get(popupcontorn,'Value'))
        case 1
            contorno='libre';
        case 2
            contorno='apoyoPuntual';
        case 3
            contorno='apoyoX';
        case 4
            contorno='apoyoY';
        case 5
            contorno='empotramiento';
     end
    err=0;
        close(f)
    end

%% FUNCIÓN QUE SE EJECUTA CUANDO SE PULSA CANCELAR
% Cierra la ventana sin devolver datos, con err se determina que ha habido
% un error

    function cancelar(hObject, eventdata, handles)
        err=1;
        contorno='libre';
        close(f)
    end

%% FUNCIÓN QUE SE EJECUTA CUANDO SE PULSA ALGUNA TECLA
% Si se pulsa retorno se aceptan los datos, si se pulsa ESC se cancelan

    function tecla(hObject,eventdata,handles)
        switch eventdata.Key
            case 'escape'
                cancelar
            case 'return'
                uicontrol(hObject)
                acceptar
        end
    end
end



