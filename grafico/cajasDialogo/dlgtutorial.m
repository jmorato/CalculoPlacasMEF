% T�TULO: Funci�n dlgtutorial para CalculoPlacasMEF
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
% Esta caja de di�logo muestra un texto de gu�a r�pida de uso del programa

function  dlgtutorial()
%% CREA LA VENTANA, LOS PANELES Y BOTONES
tamanycme2=get(gcf,'Position');
tm=[tamanycme2(3)*0.8 tamanycme2(4)*0.8] ;
sc=(tamanycme2(3:4)-tm(1:2))/2+tamanycme2(1:2);
bg=get(0,'defaultUicontrolBackgroundColor');
f = figure('Units','pixels','Position',[sc,tm],'NumberTitle','off','Name','Tutorial','Toolbar','none','Menubar','none','Resize','off','WindowStyle','modal','color',bg,'KeyPressFcn',@tecla);
uicontrol(f,'Units','pixels','Position',[tm(1)/2-110/2,5+30/2,110,30],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Acceptar','Callback',@acceptar);

%% CREACI�N DEL TEXTO QUE SE MUESTRA POR PANTALLA.
 string=sprintf(['Este programa calcula desplazamientos, giros y tensiones el�sticas en placas poligonales. Se usa la teor�a de placas gruesas de Reissner-Mindlin y el elemento finito triangular DKT.'...
       'Los resultados se muestran mediante la interfaz, aunque tambi�n se puede acceder a ellos mediante la variable "calculo" creada en Matlab.\n\n'...
       'La barra de herramientas superior sirve para dibujar todas las caracter�sticas de la placa: contorno, cargas puntuales y repartidas y condiciones de contorno. Botones:\n\n'...
       'Crear: crea un nuevo elemento del tipo seleccionado \nModificar: modifica un elemento del tipo seleccionado \nBorrar: borra un elemento del tipo seleccionado \n\n'...
       '1. Nodo: Nuevo nodo en el espacio gr�fico \n2. Contorno: linea entre dos nodos, que forma parte del contorno de la placa o agujeros internos '...
       '\n3. Carga Puntual: aplica una carga puntual sobre un nodo \n4. �rea de Carga: l�nea entre dos nodos, que forma parte de un �rea de carga repartida'...
       '\n5. Cargar �rea: aplica una carga repartida sobre un �rea dibujada. Pulsar sobre una de las l�neas. \n6. Condici�n de contorno: aplica condiciones de contorno sobre un nodo'...
       '(apoyo simple, apoyo a lo largo de X, apoyo a lo largo de Y o empotramiento\n\n'...      
       'El panel de botones laterales "introducir c�lculos" introduce los par�metros gr�ficos en el programa y es necesarios para el desarrollo del mismo. Se recomienda introducir los par�metros'...
       ' de forma ordenada seg�n se muestra en pantalla. Para calcular la malla es necesario introducir, como m�nimo, el contorno de la placa y el material.'...
       'Para calcular los desplazamientos es necesario introducir tambi�n las condiciones de contorno.']);
   
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

