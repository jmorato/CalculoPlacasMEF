% T�TULO: Funci�n dlgmallacargas para CalculoPlacasMEF
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
% Esta caja se muestra cuando el usuario pulsa mallar sin haber introducido
% cargas. Se le pregunta si quiere continuar y se devuelve la respuesta

function [continuar] = dlgmallacargas(continuar)
%% CREA LA VENTANA, LOS PANELES Y BOTONES.

tamanycme2=get(gcf,'Position');
tm=[255,130];
sc=(tamanycme2(3:4)-tm(1:2))/2+tamanycme2(1:2);
bg=get(0,'defaultUicontrolBackgroundColor');
f = figure('Units','pixels','Position',[sc,tm],'NumberTitle','off','Name','Opciones de Mallado','Toolbar','none','Menubar','none','Resize','off','WindowStyle','modal','color',bg,'KeyPressFcn',@tecla);
uicontrol(f,'Units','pixels','Position',[5,10,110,30],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Acceptar','Callback',@acceptar);
uicontrol(f,'Units','pixels','Position',[140,10,110,30],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Cancel�lar','Callback',@cancelar);

%% CREA EL TEXTO CON LA PREGUNTA PREGUNTA

uicontrol(f,'Units','pixels','Position',[5 tm(2)-60 245 45],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String','No se han a�adido cargas. Continuar de todas formas?'); % Etiqueta.

uiwait(f) % Para la ejecuci�n de Matlab hasta que se cierre la ventana y se devuelvan los datos


%% FUNCI�N QUE SE EJECUTA CUANDO SE PULSA ACEPTAR
% Se devuelve que el usuario s� quiere continuar, con la variable continuar

    function acceptar(hObject, eventdata, handles)
       continuar=1;
        close(f)
    end

%% FUNCI�N QUE SE EJECUTA CUANDO SE PULSA CANCELAR
% Cierra la ventana sin continuar con el mallado

    function cancelar(hObject, eventdata, handles)
        continuar=0;
        close(f)
    end

%% FUNCI�N QUE SE EJECUTA CUANDO SE PULSA ALGUNA TECLA
% Si se pulsa retorno se contin�a, si se pulsa ESC no

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
