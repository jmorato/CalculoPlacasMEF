% TÍTULO: Función dlgcondcont para CalculoPlacasMEF
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
% seleccionar de un menú desplegable la condición de contorno del nodo

function n = dlgcondcont(n)
%% CREA LA VENTANA, LOS PANELES Y BOTONES

tamanycme2=get(gcf,'Position');
tm=[255,160];
sc=(tamanycme2(3:4)-tm(1:2))/2+tamanycme2(1:2);
bg=get(0,'defaultUicontrolBackgroundColor');
f = figure('Units','pixels','Position',[sc,tm],'NumberTitle','off','Name',['Nodo nº: ',num2str(n.num)],'Toolbar','none','Menubar','none','Resize','off','WindowStyle','modal','color',bg,'KeyPressFcn',@tecla);
panelpos=uipanel(f,'Units','pixels','Position',[5 tm(2)-50 245 45],'BorderType','etchedin','BorderWidth',1,'FontName','default','FontUnits','pixels','FontSize',14,'Title','Posición:');
panelcontorn=uipanel(f,'Units','pixels','Position',[5 45 245 55],'BorderType','etchedin','BorderWidth',1,'FontName','default','FontUnits','pixels','FontSize',14,'Title','Condición de contorno:');
uicontrol(f,'Units','pixels','Position',[5,10,110,30],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Acceptar','Callback',@acceptar);
uicontrol(f,'Units','pixels','Position',[140,10,110,30],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Cancel·lar','Callback',@cancelar);

uicontrol(panelpos,'Units','pixels','Position',[5,5,30,20],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String','X:'); % Etiqueta.
uicontrol(panelpos,'Units','pixels','Position',[95,5,30,20],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String','Y:'); % Etiqueta.
editpos(1)=uicontrol(panelpos,'Units','pixels','Position',[35,5,45,20],'Style','edit','Enable','off','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','right','BackgroundColor','white','String',num2str(n.posicio(1)),'KeyPressFcn',@tecla); % Caixa de text coordenada x.
editpos(2)=uicontrol(panelpos,'Units','pixels','Position',[125,5,45,20],'Style','edit','Enable','off','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','right','BackgroundColor','white','String',num2str(n.posicio(2)),'KeyPressFcn',@tecla); % Caixa de text coordenada y.

%% CREA EL PANEL CON LAS CONDICIONES DE CONTORNO

     switch (n.contorn)
        case 'libre'
            valor=1;
        case 'apoyoPuntual'
            valor=2;
        case 'apoyoX'
            valor=3;
        case 'apoyoY';
            valor=4;
        case 'empotramiento'
            valor=5;
    end
popupcontorn=uicontrol(panelcontorn,'Units','pixels','Position',[5,15,235,20],'Style','popupmenu','FontName','default','FontUnits','pixels','FontSize',14,'BackgroundColor','white','Value',valor,'String',{'Nodo libre','Apoyo Simple','Apoyo a lo largo del eje X','Apoyo a lo largo del eje Y','Empotramiento'}); % Menú desplegable con las condiciones de contorno

uiwait(f) % Para la ejecución de Matlab hasta que se cierre la ventana y se devuelvan los datos

%% FUNCIÓN QUE SE EJECUTA CUANDO SE PULSA ACEPTAR
% Lee la condición de contorno obtenida del menú desplegable y la asigna al
% nodo

    function acceptar(hObject, eventdata, handles)
     switch (get(popupcontorn,'Value'))
        case 1
            n.contorn='libre';
        case 2
            n.contorn='apoyoPuntual';
        case 3
            n.contorn='apoyoX';
        case 4
            n.contorn='apoyoY';
        case 5
            n.contorn='empotramiento';
    end
        close(f)
    end

%% FUNCIÓN QUE SE EJECUTA CUANDO SE PULSA CANCELAR
% Cierra la ventana sin devolver datos

    function cancelar(hObject, eventdata, handles)
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


