% T�TULO: Funci�n dlgmalla para CalculoPlacasMEF
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
% Se muestra una caja de di�logo por pantalla donde se escoge el tama�o
% m�ximo del elemento finito, y si se debe considerar el peso propio
% (checkbox). Seg�n lo que pulsa el usuario, se ejecutar� o no la malla

function [pesopropio,meshsize,err] = dlgmalla()
%% CREA LA VENTANA, LOS PANELES Y BOTONES

tamanycme2=get(gcf,'Position');
tm=[255,130];
sc=(tamanycme2(3:4)-tm(1:2))/2+tamanycme2(1:2);
bg=get(0,'defaultUicontrolBackgroundColor');
f = figure('Units','pixels','Position',[sc,tm],'NumberTitle','off','Name','Opciones de Mallado','Toolbar','none','Menubar','none','Resize','off','WindowStyle','modal','color',bg,'KeyPressFcn',@tecla);
uicontrol(f,'Units','pixels','Position',[5,10,110,30],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Acceptar','Callback',@acceptar);
uicontrol(f,'Units','pixels','Position',[140,10,110,30],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Cancel�lar','Callback',@cancelar);

%% CREA EL PANEL CON LA CAJA DE TEXTO DE TAMA�O M�XIMO DE ELEMENTO Y LA CHECKBOX DEL PESO PROPIO

uicontrol(f,'Units','pixels','Position',[5 tm(2)-60 245 45],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String','Tama�o m�ximo de elemento:'); % Etiqueta.
editmeshsize(1)=uicontrol(f,'Units','pixels','Position',[200 tm(2)-35 40 25],'Style','edit','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','right','BackgroundColor','white','String','0.5','KeyPressFcn',@tecla); % Caixa de text coordenada z.
uicontrol(f,'Units','pixels','Position',[5 tm(2)-90 245 45],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String','Considerar peso propio:'); % Etiqueta.
checkpeso= uicontrol(f,'Style','checkbox','Position',[170 tm(2)-67 40 25], 'Value',0,'FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left'); % Etiqueta.)

uiwait(f) % Para la ejecuci�n de Matlab hasta que se cierre la ventana y se devuelvan los datos

%% FUNCI�N QUE SE EJECUTA CUANDO SE PULSA ACEPTAR
% Lee el tama�o de elemento entrado y el estado actual de la checkbox del
% peso propio. La variable err controla si los datos entrados son v�lidos

    function acceptar(hObject, eventdata, handles)
        err=0;
        try
        meshsize=str2double(get(editmeshsize,'String'));           
        catch
            err=1; 
        end
        
        if isnan(meshsize)
            err=1; end    
        if err==0 && (meshsize<0)
                err=2;
        end
     switch (get(checkpeso,'Value'))
         case 1
             pesopropio=1;
         case 0
             pesopropio=0;
    end
        close(f)
    end

%% FUNCI�N QUE SE EJECUTA CUANDO SE PULSA CANCELAR
% Cierra la ventana sin devolver datos

    function cancelar(hObject, eventdata, handles)
        err=-1;
        meshsize=0;
        pesopropio=0;
        close(f)
    end

%% FUNCI�N QUE SE EJECUTA CUANDO SE PULSA ALGUNA TECLA
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


