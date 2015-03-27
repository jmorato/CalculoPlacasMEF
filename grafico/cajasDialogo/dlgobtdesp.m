% TÍTULO: Función dlgobtdesp para CalculoPlacasMEF
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
% Esta caja de diálogo obtiene las coordenadas entradas por el usuario para
% calcular los desplazamientos en ese punto

function [punto,err] = dlgobtdesp()
%% CREA LA VENTANA, LOS PANELES Y BOTONES
err=-1;
tamanycme2=get(gcf,'Position');
tm=[255,100];
sc=(tamanycme2(3:4)-tm(1:2))/2+tamanycme2(1:2);
bg=get(0,'defaultUicontrolBackgroundColor');
f = figure('Units','pixels','Position',[sc,tm],'NumberTitle','off','Name','Introducir coordenadas: ','Toolbar','none','Menubar','none','Resize','off','WindowStyle','modal','color',bg,'KeyPressFcn',@tecla);
panelpos=uipanel(f,'Units','pixels','Position',[5 tm(2)-50 245 45],'BorderType','etchedin','BorderWidth',1,'FontName','default','FontUnits','pixels','FontSize',14,'Title','Posición:');
uicontrol(f,'Units','pixels','Position',[5,10,110,30],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Acceptar','Callback',@acceptar);
uicontrol(f,'Units','pixels','Position',[140,10,110,30],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Cancel·lar','Callback',@cancelar);

%% CREA EL PANEL SUPERIOR CON INFORMACIÓN DE LAS COORDENADAS

uicontrol(panelpos,'Units','pixels','Position',[5,5,30,20],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String','X:'); % Etiqueta.
uicontrol(panelpos,'Units','pixels','Position',[95,5,30,20],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String','Y:'); % Etiqueta.
editpos(1)=uicontrol(panelpos,'Units','pixels','Position',[35,5,45,20],'Style','edit','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','right','BackgroundColor','white','String','','KeyPressFcn',@tecla); % Caixa de text coordenada x.
editpos(2)=uicontrol(panelpos,'Units','pixels','Position',[125,5,45,20],'Style','edit','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','right','BackgroundColor','white','String','','KeyPressFcn',@tecla); % Caixa de text coordenada y.

uiwait(f)  % Para la ejecución de Matlab hasta que se cierre la ventana y se devuelvan los datos

%% FUNCIÓN QUE SE EJECUTA CUANDO SE PULSA ACEPTAR
% Se lee la información de las cajas de texto y se comprueba su validez
% (variable err). Luego se devuelven los datos

    function acceptar(hObject, eventdata, handles)
        err=0;
        try
        punto(1)=str2double(get(editpos(1),'String'));
        punto(2)=str2double(get(editpos(2),'String'));
        
        if isnan(punto(1)) || isnan(punto(2))
            err=1;
        end
        catch
            err=1;
        end
        close(f)
    end

%% FUNCIÓN QUE SE EJECUTA CUANDO SE PULSA CANCELAR
% Cierra la ventana sin devolver datos

    function cancelar(hObject, eventdata, handles)
        err=-1;
        punto=[0,0];
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
