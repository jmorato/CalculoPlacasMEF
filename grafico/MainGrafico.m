% TÍTULO: Función MainGrafico para CalculoPlacasMEF
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
% Esta función es la función principal de la interfaz gráfica de usuario
% del programa. en ella se crea toda la interfaz y se responde a las
% acciones del usuario, y se llaman las funciones auxiliares de dibujo o
% cajas de diálogo según es conveniente. Asimismo, esta función recibe como
% parámetro un objeto de tipo MainCalculo, que es el núcleo del módulo de
% cálculo. a través de este objeto la interfaz se comunica con el módulo de
% cálculo, enviando datos y obteniendo resultados según convenga

function MainGrafico(calculo)

%% INICIACIÓN DE LAS VARIABLES DEL PROGRAMA. CARGA DE OPCIONES
% Se crean todas las variables globales que se usan en la función y se
% cargan las distintas opciones de la interfaz

[nusos,contnus,barres,contbarra,vista,flagbarra,primernusbarra,hbarra,flagclic,flagmourenus,posini,s,xmin,xmax,ymin,ymax,zmin,zmax,xm,ym,zm,xmed,ymed,zmed,angle3d,grafica,nom,thbarra,contbarracarga,cargasunif,contcargaunif,bwidth,bheight,colorcarregues,flagcondcont,rectanguloSeleccion,elementos]=inicialitza_variables;
[fontnusos,tamanyfontnusos,fontcarregues,tamanyfontcarregues,factorzoom,tamanynus,distnumnus,precini,XLimini,YLimini,ZLimini,colormodificar,coloresborrar,colorcarregues]=loadopcions; % Carga las opciones.
[figcme2,tm,bg]=creacio_finestra; % Crea la ventana principal del programa.

%% CREACIÓN DE LOS ELEMENTOS DE LA INTERFAZ GRÁFICA: PANELES, TEXTOS, ICONOS, BOTONES
% Se crean todos los elementos interactivos de la interfaz. Se estructuran
% por grupos para facilitar su manejo des del programa

[barraeines,botobarracrear,botobarramodificar,botobarraesborrar,botobarranus,botobarrabarra,botobarracarreganus,botobarracarregabarra,botobarracarregacarga,botobarraapoyo,botobarramoure,botobarraapropar,botobarraallunyar]=creacio_barra_eines; % Carga la barra de herramientas.
creacio_menus % Crea la barra de menús.
[panel1,logo,grafica_est,editx,edity,editprec]=creacio_panell_grafica; % Crea el panel con la gráfica de edición del programa y las cajas de coordenadas y precision

[resultados]=panel_resultados;                              %Crea el panel de resultados: es el panel 'Padre' de todos los paneles con los gráficos 3d de representacion de resultados
[resultados_flecha,grafico_flecha]=panel_resultados_flecha; %Crea el panel con el gráfico 3d de resultados de flecha
[resultados_girox,grafico_girox]=panel_resultados_girox;    %Crea el panel con el gráfico 3d de resultados de giro X
[resultados_giroy,grafico_giroy]=panel_resultados_giroy;    %Crea el panel con el gráfico 3d de resultados de giro Y
[resultados_Mx,grafico_Mx]=panel_resultados_Mx;             %Crea el panel con el gráfico 3d de resultados de Momento X
[resultados_My,grafico_My]=panel_resultados_My;             %Crea el panel con el gráfico 3d de resultados de Momento Y
[resultados_Mxy,grafico_Mxy]=panel_resultados_Mxy;          %Crea el panel con el gráfico 3d de resultados de Momento XY

[panel2,botoedicio,botoxy,boto3d]=panell_botons_vista; % Crea el panel con los botones que controlan las vistas y edición.
[panel3,botonumnodos,botoflecha,botogirox,botogiroy,botoMx,botoMy,botoMxy,botoObtDesp]=panell_botons_grafica; % Panel con los botones para seleccionar los elementos que se muestren en la presentación de resultados.
[panel4,botoCargaPunt,botoContorn,botoMaterial,botoMalla,botoReset,botoCargaUnif,botoCondCont,botoCalcDesp,flagbCon,flagbMat,flagbMalla,flagbCp,flagbCu,distnumnusmalla,flagbCc,flagbCalcDesp]=panel_calculo; %Panel lateral con los botones que envían los datos al programa de cálculo
[hg_nusos,hg_barres,hg_carreguesbarres,hg_carreganusos,hg_cargasunif]=inicialitza_hg(grafica_est);
resetflags();
updatebotons();

% Una vez creados los objetos, el programa espera la interacción con el
% usuario y ejectua las acciones programadas.

%% BARRA DE MENÚ: CREACIÓN Y ACCIONES
% Es la barra de menú superior del programa

    function creacio_menus
        % Crea la barra de menús.
        
        menuarxiu=uimenu(figcme2,'Label','Archivo'); % Menú Archivo
        menuayuda=uimenu(figcme2,'Label','Ayuda'); % Menú Ayuda
        uimenu(menuayuda,'Label','Tutorial (PDF)','Callback',@menututorial); % Submenú tutorial
        uimenu(menuayuda,'Label','Guía Rápida','Callback',@menuguiarapida); % Submenú tutorial
        uimenu(menuayuda,'Label','Acerca de...','Callback',@menuacerca); % Submenú Acerca de...
        uimenu(menuarxiu,'Label','Nuevo','Callback',@menunou); % Submenú Nuevo
        uimenu(menuarxiu,'Label','Salir','Callback',@sortir); % Submenú Salir
    end

    function menunou(hObject,eventdata,handles)
        % S'executa amb el menú 'nou'
        % Pregunta si es vol guardar i esborra l'estructura.
        %nou
%         resp=questdlg('Guardar abans d''esborrar l''estructura?','Nova estructura','Si','No','Cancelar','Si');
%         switch resp
%             case 'Si'
%                 menuguardar
%                 nou
%             case 'No'
%                 nou
%         end
    reset;
    end
    
    function menututorial(hObject,eventdata,handles)
        open('tutorial.pdf');
    end

    function menuguiarapida(hObject,eventdata,handles)
       dlgguiarapida();
    end

    function menuacerca(hObject,eventdata,handles)
      dlgacerca();  
    end

    function sortir(hObject,eventdata,handles)
        % Salir del programa. Se ejecuta al pulsar sobre la cruz o el
        % submenú Salir. Confirma que se quiere salir
        
        resp=questdlg('Seguro que quieres Salir? Se perderán los datos','Salir de Cálculo de Placas MEF','Si','No','Cancelar','Si');
        switch resp
            case 'Si'
                delete(figcme2) % Esborra la finestra.
                close all;
        end
    end

%% BARRA DE HERRAMIENTAS. CREACIÓN Y ACCIONES
% Barra superior de herramientas del programa. Iconos.

    function [barraeines,botobarracrear,botobarramodificar,botobarraesborrar,botobarranus,botobarrabarra,botobarracarreganus,botobarracarregabarra,botobarracarregacarga,botobarraapoyo,botobarramoure,botobarraapropar,botobarraallunyar]=creacio_barra_eines
        % Crea una nova barra d'eines i defineix els botons.
        % Per als botons de zoom i moviment en copia l'imatge de la barra
        % per defecte de Matlab, però només la imatge, les accions estan
        % reprogramades per tal de tenir el control i que Matlab no faci
        % accions extrañes.
        
        barraperdefecte=findall(figcme2,'Type','uitoolbar'); % Handle de la barra por defecto de Matlab
        barraeines=uitoolbar; % Creación de barra de herramientas propia
        botobarracrear=uitoggletool('TooltipString','Crear (C)','CData',imread('lapiz.png','BackgroundColor',bg),'State','on','ClickedCallback',@botocrear); % Botón Crear
        botobarramodificar=uitoggletool('TooltipString','Modificar (M)','Cdata',imread('editar.png','BackgroundColor',bg),'ClickedCallback',@botomodificar); % Botón modificar
        botobarraesborrar=uitoggletool('TooltipString','Borrar (B)','CData',imread('goma.png','BackgroundColor',bg),'ClickedCallback',@botoesborrar); % Botón Borrar
        botobarranus=uitoggletool('Separator','on','TooltipString','Nodo','CData',imread('nudo.png','BackgroundColor',bg),'State','on','ClickedCallback',@botonus); % Boton Nodo
        botobarrabarra=uitoggletool('Separator','on','TooltipString','Línea de contorno de placa','CData',imread('contorno.png','BackgroundColor',bg),'ClickedCallback',@botobarra); % Botón Línea de Contorno
        botobarracarreganus=uitoggletool('Separator','on','TooltipString','Carga Puntual en nodo','CData',imread('carganudo.png','BackgroundColor',bg),'ClickedCallback',@botocarreganus); % Botón Carga Puntual
        botobarracarregabarra=uitoggletool('Separator','on','TooltipString','Linea de área de carga','CData',imread('cargabarra.png','BackgroundColor',bg),'ClickedCallback',@botocarregabarra); % Boton Línea de Área de Carga
        botobarracarregacarga=uitoggletool('TooltipString','Cargar área','CData',imread('cargacarga.png','BackgroundColor',bg),'ClickedCallback',@botocarregacarga); % Botón Aplicar Carga Repartida
        botobarraapoyo=uitoggletool('Separator','on','TooltipString','Condición de contorno del nodo','CData',imread('apoyo.png','BackgroundColor',bg),'ClickedCallback',@botoapoyo); % Botón Condiciones de Contorno
        botobarramoure=uitoggletool('Separator','on','TooltipString','Mover','CData',get(findall(barraperdefecte,'TooltipString','Pan'),'CData'),'ClickedCallback',@botomoure); % Botón mover (se usa el mismo por defecto de Matlab)
        botobarraapropar=uitoggletool('TooltipString','Acercar','CData',get(findall(barraperdefecte,'TooltipString','Zoom In'),'CData'),'ClickedCallback',@botoapropar); %  Botón acercar (se usa el mismo por defecto de Matlab)
        botobarraallunyar=uitoggletool('TooltipString','Alejar','CData',get(findall(barraperdefecte,'TooltipString','Zoom Out'),'CData'),'ClickedCallback',@botoallunyar);%  Botón alejar (se usa el mismo por defecto de Matlab)
        set(figcme2,'Toolbar','none'); % Se desactiva la barra de herramientas original
    end

    function botocrear(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Crear
 
        botons_accions('on','off','off','off','off','off')
    end
    function botomodificar(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Modificar
        botons_accions('off','on','off','off','off','off')
    end
    function botoesborrar(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Borrar
        botons_accions('off','off','on','off','off','off')
    end
    function botomoure(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Mover
        botons_accions('off','off','off','on','off','off')
    end
    function botoapropar(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Acercar
        botons_accions('off','off','off','off','on','off')
    end
    function botoallunyar(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Alejar
        botons_accions('off','off','off','off','off','on')
    end
    function botonus(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Nodo
        botons_elements('on','off','off','off','off','off')
    end
    function botobarra(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Línea de Contorno
        botons_elements('off','on','off','off','off','off')
    end
    function botocarreganus(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Carga Puntual
        botons_elements('off','off','on','off','off','off')
    end
    function botocarregabarra(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Línea de Área de Carga
        botons_elements('off','off','off','on','off','off')
    end
    function botocarregacarga(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Aplicar Carga Repartida
        botons_elements('off','off','off','off','on','off')
    end
    function botoapoyo(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Condiciones de Contorno
        botons_elements('off','off','off','off','off','on')
    end

    function botons_accions(bcrear,bmodificar,besborrar,bmoure,bapropar,ballunyar)
        % Esta función determina la ejecución de los botones de acción, que
        % son Crear, Modificar, Borrar, Alejar, Acercar, Mover. Cuando se
        % activa uno se desactivan los demás
        
        set(botobarracrear,'State',bcrear);
        
        set(botobarramodificar,'State',bmodificar);
        set(botobarraesborrar,'State',besborrar);
        if strcmp('off',bmoure) 
            set(botobarramoure,'State',bmoure);
        end
        if strcmp('off',bapropar)
            set(botobarraapropar,'State',bapropar);
        end
        if strcmp('off',ballunyar)
            set(botobarraallunyar,'State',ballunyar);
        end
        colors
        clicable % Determina sobre qué objetos se puede hacer clic según el estado de los botones de acción
    end
    function botons_elements(bnus,bbarra,bcarreganus,bcarregabarra,bcarregacarga,bapoyo)
        % Esta función determina el estado de los botones que hacen
        % referencia a los elementos del programa que son: Nodo, Línea de
        % Contorno, Línea de Área de Carga, Carga Puntual, Aplicar Carga
        % Repartida, Condiciones de Contorno. Cuando uno se activa, se
        % desactivan los demás.
        
        set(botobarranus,'State',bnus);
        set(botobarrabarra,'State',bbarra);
        set(botobarracarreganus,'State',bcarreganus);
        set(botobarracarregabarra,'State',bcarregabarra);
        set(botobarracarregacarga,'State',bcarregacarga);
        set(botobarraapoyo,'State',bapoyo);
        colors
        clicable % Determina sobre qué objetos se puede hacer clic según el estado de los botones de elementos
    end
    function clicable(hObject,eventdata,handles)
        % Modifica el estado de los objetos gráficos según los botones
        % activados (por ejemplo, se muestran en rojo los elementos
        % borrables cuando el botón borrar está activo. La funcion
        % determina qué elementos gráficos pueden ser clicados en cada
        % momento según el estado de los botones.
        
        if get(botoedicio,'Value')
            if strcmp(get(botobarracrear,'State'),'on') % Si el botón Crear está activo
                if strcmp(get(botobarranus,'State'),'on') % Nodos: se clica directamente sobre la gráfica
                    canviestat('off','off','off','off')
                elseif strcmp(get(botobarrabarra,'State'),'on') % Línea de Contorno: se clica sobre los nodos
                    canviestat('on','off','off','off')
                elseif strcmp(get(botobarracarreganus,'State'),'on') % Carga Puntual: se clica sobre los nodos
                    canviestat('on','off','off','off')
                elseif strcmp(get(botobarracarregabarra,'State'),'on')% Línea de Área de Carga: se clica sobre los nodos
                    canviestat('on','off','off','off')
                elseif strcmp(get(botobarracarregacarga,'State'),'on')% Aplicar Carga Repartida: se clica sobre las líneas
                    canviestat('off','on','off','off')
                elseif strcmp(get(botobarraapoyo,'State'),'on') % Condiciones de Contorno: se clica directamente sobre la gráfica para seleccionar un área
                    canviestat('off','off','off','off')
                end
            elseif strcmp(get(botobarramodificar,'State'),'on') || strcmp(get(botobarraesborrar,'State'),'on') % Si el botón Modificar o Borrar están activos
                if strcmp(get(botobarranus,'State'),'on') % Nodos: se clica sobre los nodos
                    canviestat('on','off','off','off')
                elseif strcmp(get(botobarrabarra,'State'),'on') % Línea de Contorno: se clica sobre las líneas
                    canviestat('off','on','off','off')
                elseif strcmp(get(botobarracarreganus,'State'),'on') % Carga Puntual: se clica sobre los nodos y el texto
                    canviestat('off','off','on','off')
                elseif strcmp(get(botobarracarregabarra,'State'),'on') % Línea de Área de Carga: se clica sobre las líneas
                    canviestat('off','on','off','off')
                elseif strcmp(get(botobarracarregacarga,'State'),'on') % Aplicar Carga Repartida: se clica sobre las líneas y el texto
                    canviestat('off','on','off','on')
                elseif strcmp(get(botobarraapoyo,'State'),'on') % Condiciones de Contorno: se clica sobre los nodos
                    canviestat('on','off','off','off')
                end
            else
                canviestat('on','off','off','off') % Por defecto, que se pueda hacer clic sobre los nodos para moverlos
            end
        end
        if strcmp(get(botobarramoure,'State'),'on') % Cambia el cursor por una Mano si el botón Mover está activo
            set(figcme2,'Pointer','hand')
        elseif strcmp(get(botobarraapropar,'State'),'on') || strcmp(get(botobarraallunyar,'State'),'on') % Cambia el cursor por un círculo si Acercar o Alejar están activos
            set(figcme2,'Pointer','circle')
        else
            set(figcme2,'Pointer','arrow')
        end
    end

    function canviestat(clicnus,clicbarra,cliccarreganus,cliccarregabarra)
        % Cambia el estado de los elementos gráficos y determina si se
        % puede o no hacer clic sobre ellos
        for j=1:contnus
            set(nusos(j).hg,'HitTest',clicnus) % Objetos de los nodos
            set(nusos(j).hgc,'HitTest',cliccarreganus) % Objetos de las cargas puntuales
        end
        for j=1:contbarra
            set(barres(j).hg,'HitTest',clicbarra) % Objetos de las líneas
        end
        
        for j=1:contcargaunif
            set(cargasunif(j).hg,'HitTest',cliccarregabarra);
        end
    end

    function colornusos(hObject,eventdata,handles)
        % Actualiza el color de los nodos según la situación (negro normal,
        % azul modificar y rojo borrar
        
        % Si está activado el botón nodo o condiciones de Contorno, y la Edición está activa
        if (strcmp(get(botobarranus,'State'),'on') || strcmp(get(botobarraapoyo,'State'),'on')) && get(botoedicio,'Value') 
            if strcmp(get(botobarramodificar,'State'),'on') % Si Modificar está activado
                color=colormodificar;
            elseif strcmp(get(botobarraesborrar,'State'),'on') % Si Borrar está activado
                color=coloresborrar;
            else
                color='k'; % Color por defecto
            end
        else
            color='k'; % Color por defecto
        end
        for i=1:contnus
            chgcolor(nusos(i).hg,color); % Cambia el color del objeto gráfico
        end
    end

    function colorbarres(hObject,eventdata,handles)
       % Actualiza el color de las líneas según la situación y según su
       % tipo (lineas de área de carga o de contorno. Negro: normal, rojo:
       % borrar, azul: modificar
        
            color1='k'; % Color por defecto de las líneas de contorno
            color2='k'; % Color por defecto de las líneas de area de carga
        
        % Si está activado el botón Línea de Contorno la Edición está activa
        if strcmp(get(botobarrabarra,'State'),'on') && get(botoedicio,'Value') % botón Línea de Contorno activo y boton Edición Activo
            
            if strcmp(get(botobarramodificar,'State'),'on') % si Modificar está activo
                color1=colormodificar; 
            elseif strcmp(get(botobarraesborrar,'State'),'on') % si Borrar está activo
                color1=coloresborrar; 
            else
                color1='k'; % Color por defecto
            end
        
        % Si está activado el botón Línea de área de carga y la Edición
        % está activa
        elseif (strcmp(get(botobarracarregabarra,'State'),'on') || strcmp(get(botobarracarregacarga,'State'),'on')) && get(botoedicio,'Value')
            
            if strcmp(get(botobarramodificar,'State'),'on') % si Modificar está activo
                color2=colormodificar; 
            elseif strcmp(get(botobarraesborrar,'State'),'on') % si Borrar está activo
                color2=coloresborrar; 
            else
                color2='k'; % Color por defecto
            end       
        else
            color1='k'; % Color por defecto
            color2='k'; % Color por defecto
        end
            for i=1:contbarra
                if(barres(i).esCarga==0) %Asigna el color a las líneas de contorno
                            if strcmp(color1,'k')
                        set(barres(i).hg,'color',barres(i).color);
                            else
                        set(barres(i).hg,'color',color1);
                            end
                else %Asigna el color a las líneas de área de carga
                             if strcmp(color2,'k')
                        set(barres(i).hg,'color',barres(i).color);
                            else
                        set(barres(i).hg,'color',color2);
                            end
                end
            end
    end

    function colorcarreganusos(hObject,eventdata,handles)
        % Actualiza el color de las cargas sobre los nodos según la
        % situación

        if strcmp(get(botobarracarreganus,'State'),'on') && get(botoedicio,'Value') % Si el botón Nodo está activo y está en Modo Edicion.
            if strcmp(get(botobarramodificar,'State'),'on') % si Modificar está activo.
                color=colormodificar; 
            elseif strcmp(get(botobarraesborrar,'State'),'on') % si Borrar está activo
                color=coloresborrar;
            else
                color=colorcarregues;
            end
        else
            color='b'; %Color por defecto
        end
        
        %Cambia el color de los objetos gráficos de los nodos
        for i=1:contnus
            chgcolor(nusos(i).hgc,color)
        end
    end

    function colorcargasunif(hObject,eventdata,handles)
        % Actualiza el color de las cargas sobre los nodos según la
        % situación

        if strcmp(get(botobarracarregacarga,'State'),'on') && get(botoedicio,'Value') % Si el botón Nodo está activo y está en Modo Edicion.
            if strcmp(get(botobarramodificar,'State'),'on') % si Modificar está activo.
                color=colormodificar; 
            elseif strcmp(get(botobarraesborrar,'State'),'on') % si Borrar está activo
                color=coloresborrar;
            else
                color=colorcarregues;
            end
        else
            color='b'; %Color por defecto
        end
        
        %Cambia el color de los objetos gráficos de los nodos
        for i=1:contcargaunif
            chgcolor(cargasunif(i).hg,color)
        end
    end

    function colors(hObject,eventdata,handles)
        % Actualitza el color de todos los elementos
        
        colornusos
        colorbarres
        colorcarreganusos
        colorcargasunif
    end

    function chgcolor(h,color)
        % Funció que cambia el color de los objetos dentro del objeto
        % hgtransform
        
        set(findobj(h,'Type','line'),'color',color) % Color de las líneas
        set(findobj(h,'Type','text'),'color',color) % Color de los textos
        set(findobj(h,'Type','patch'),'FaceColor',color,'EdgeColor',color) % Color de los patch
    end

%% PANEL 1: GRÁFICO PRINCIPAL. CREACIÓN Y ACCIONES
%El panel 1 es el panel principal del programa, que contiene el gráfico en
%2D del plano XY donde se visualiza la placa y los cajetines inferiores que
%indican las coordenadas y la precisión

    function [panel1,logo,grafica_est,editx,edity,editprec]=creacio_panell_grafica
        % Creación del panel y sus elementos
        panel1=uipanel(figcme2,'Units','pixels','Position',[5,5,tm-[bwidth+25,10]],'BorderType','etchedin','BorderWidth',1); % Creacio del panell.
        logo=axes('Parent',panel1,'Units','pixels','Position',[36,50,tm-[176,70]]); % Objecte axes on es carreguen els logos.
        imagesc(imread('logo.jpg'),'ButtonDownFcn',@clic_grafica_res); % Carrega dels logos.
        set(logo,'handlevisibility','off','Visible','off'); % S'oculten els marges i es fa inaccessible. Queda com a imatge de fons sense alterar al treballar amb l'estructura, ampliar, reduïr, moure, etc.
        grafica_est=axes('Parent',panel1,'Units','pixels','Position',[36,50,tm-[176,70]],'color','none','MinorGridLineStyle',':','ButtonDownFcn',@clic_ratoli,'NextPlot','add','XLim',XLimini,'YLim',YLimini,'Box','on'); % Pantalla de treball amb la gràfica de l'estructura.
        uicontrol(panel1,'Units','pixels','Position',[36,5,15,20],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String','X:'); % Etiqueta.
        editx=uicontrol(panel1,'Units','pixels','Position',[51,5,50,20],'Style','edit','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','right','BackgroundColor','white','Enable','off'); % Caixa on s'indica o introueix la coordenada x.
        uicontrol(panel1,'Units','pixels','Position',[111,5,15,20],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String','Y:'); % Etiqueta.
        edity=uicontrol(panel1,'Units','pixels','Position',[126,5,50,20],'Style','edit','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','right','BackgroundColor','white','Enable','off'); % Caixa on s'indica o introdueix la coordenada y.
        uicontrol(panel1,'Units','pixels','Position',[200,5,65,20],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String','Precisión:'); % Etiqueta.
        editprec=uicontrol(panel1,'Units','pixels','Position',[270,5,50,20],'Style','edit','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','right','BackgroundColor','white','String',num2str(precini));  % Caixa on s'introdueix la precisió a l'introduïr punts amb el ratolí.
        grafica=grafica_est;
    end

   function clic_ratoli(hObject,eventdata,handles)
        % Se ejecuta cuando se hace clic sobre el gráfico. Anteriormente se
        % ejecuta clic_figure, que determina mediante flagclic qué botón
        % del ratón se pulsa

        % Si se pulsa el botón izquierdo, con el boton Nodo activo, y la
        % edición Activa, se crea un nodo
        if flagclic==1 &&get(botoedicio,'Value') && strcmp(get(botobarracrear,'State'),'on') && strcmp(get(botobarranus,'State'),'on') && ~strcmp(vista,'3d')
            crearnus
            
        % Si Acercar o Alejar están activos, se aplica el factor de zoom
        elseif (flagclic==1 && strcmp(get(botobarraapropar,'State'),'on')) || (flagclic==3 && strcmp(get(botobarraallunyar,'State'),'on'))
            zom(-3/factorzoom);
        elseif (flagclic==1 && strcmp(get(botobarraallunyar,'State'),'on')) || (flagclic==3 && strcmp(get(botobarraapropar,'State'),'on'))
            zom(3/factorzoom);
        
        % Si se pulsa el botón izquierdo, con el boton Condiciones de Contorno activo, y la
        % edición Activa, se selecciona un rectángulo (líneas discontínuas,
        % al que se le aplicarán las condiciones de contorno que determine
        % el usuario
        elseif (flagclic==1 && strcmp(get(botobarracrear,'State'),'on')) && strcmp(get(botobarraapoyo,'State'),'on')
            seleccionarCondCont();
        end
   end

    function clic_nus(gcbo,eventdata,handles)
        % Se ejecuta cuando se hace clic sobre un nodo. en el campo
        % 'UserData' del objeto gráfico hay el número del nodo, que permite
        % identificarlo. Dependiendo de qué botón está activo en la barra
        % de herramientas, se ejecuta una acción u otra

        n=get(gcbo,'UserData'); % Número de nodo
        if flagclic==1 && get(botoedicio,'Value') % Si se ha pulsado el botón izquierdo y la Edición está activa
            if strcmp(get(botobarraesborrar,'State'),'on') && strcmp(get(botobarranus,'State'),'on')
                esborrarnus(n) 
            elseif strcmp(get(botobarramodificar,'State'),'on') && strcmp(get(botobarranus,'State'),'on')
                modificarnus(n)
            elseif strcmp(get(botobarracrear,'State'),'on') && strcmp(get(botobarrabarra,'State'),'on')
                crearbarra(n,0)
            elseif strcmp(get(botobarracrear,'State'),'on') && strcmp(get(botobarracarregabarra,'State'),'on')
                aux=contbarra;
                crearbarra(n,1)
                % Si se ha creado una nueva línea, se le asigna el color
                % verde y esCarga=1 para determinar que es una línea de
                % área de carga
                if contbarra>aux
                    barres(contbarra).esCarga=1;
                    barres(contbarra).color='g';
                    contbarracarga=contbarracarga+1;
                    colorbarres;
                end
            elseif strcmp(get(botobarracrear,'State'),'on') && strcmp(get(botobarracarreganus,'State'),'on')
                crearmodificarcarreganus(n)
            elseif strcmp(get(botobarracrear,'State'),'on') && strcmp(get(botobarraapoyo,'State'),'on')
                modificarcondcont(n)
            elseif strcmp(get(botobarramodificar,'State'),'on') && strcmp(get(botobarraapoyo,'State'),'on')
                modificarcondcont(n)
            elseif strcmp(get(botobarraesborrar,'State'),'on') && strcmp(get(botobarraapoyo,'State'),'on')
                esborrarapoyo(n)    
            end
        elseif flagclic==3 && ~flagbarra && get(botoedicio,'Value') % Si se ha pulsado el botón derecho se mueve el nodo
            flagmourenus=n; % Activa el flag que indica que se modifique la posición del nodo con el movimiento del ratón
        end
    end
    
    function clic_cargaunif(gcbo,eventdata,handles)
        % Se ejecuta cuando se hace clic sobre una carga repartida. en el campo
        % 'UserData' del objeto gráfico hay el número de la carga repartida, que permite
        % identificarla. Dependiendo de qué botón está activo en la barra
        % de herramientas, se ejecuta una acción u otra
        
        fprintf('ejecutadooooo\n');
        n=get(gcbo,'UserData'); % Número de nodo
        if flagclic==1 && get(botoedicio,'Value') && strcmp(get(botobarracarregacarga,'State'),'on')% Si se ha pulsado el botón izquierdo y la Edición está activa
            if strcmp(get(botobarraesborrar,'State'),'on') 
                esborrarcargaunif(n)
            elseif strcmp(get(botobarramodificar,'State'),'on')
                modificarCargaRepartida(n)
                fprintf('moficiado \n');
            end
        end
    end

    function clic_carreganus(gcbo,eventdata,handles)
        % Se ejecuta cuando se hace clic sobre una carga puntual. en el campo
        % 'UserData' del objeto gráfico hay el número del nodo, que permite
        % identificarlo. Dependiendo de qué botón está activo en la barra
        % de herramientas, se ejecuta una acción u otra
        
        n=get(gcbo,'UserData'); % Número de nodo
        if flagclic==1 && get(botoedicio,'Value') && strcmp(get(botobarracarreganus,'State'),'on')% Si se ha pulsado el botón izquierdo y la Edición está activa
            fprintf('executat\n');
            if strcmp(get(botobarraesborrar,'State'),'on') 
                esborrarcarreganus(n)
            elseif strcmp(get(botobarramodificar,'State'),'on')
                crearmodificarcarreganus(n)
            end
        end
    end

    function clic_barra(gcbo,eventdata,handles)
        % Se ejecuta cuando se hace clic sobre una línea. en el campo
        % 'UserData' del objeto gráfico hay el número de la línea, que permite
        % identificarla. Dependiendo de qué botón está activo en la barra
        % de herramientas, se ejecuta una acción u otra
        
        n=get(gcbo,'UserData'); % Número de barra.
        
        if flagclic==1 && get(botoedicio,'Value') % Si se ha pulsado el botón izquierdo y la Edición está activa
            % Si es una Línea de Contorno
            if(barres(n).esCarga==0)
                if strcmp(get(botobarraesborrar,'State'),'on') && strcmp(get(botobarrabarra,'State'),'on')
                    esborrarbarra(n)
                    redibuixar_nusos
                    escalar_nusos               
                end
            % Si es una Línea de Área de Carga     
            elseif (barres(n).esCarga==1)
                % Si el botón Linea de Área de Carga está activo, se actúa
                % sobre la línea
                if strcmp(get(botobarraesborrar,'State'),'on') && strcmp(get(botobarracarregabarra,'State'),'on')
                    esborrarbarra(n)
                    redibuixar_nusos
                    escalar_nusos
                % Si el botón Aplicar Carga Repartida está activo, se actúa
                % sobre la carga aplicada sobre las líneas, si existe
                elseif strcmp(get(botobarramodificar,'State'),'on') && strcmp(get(botobarracarregacarga,'State'),'on')
                    crearmodificarcargaunif(n)
                elseif strcmp(get(botobarracrear,'State'),'on') && strcmp(get(botobarracarregacarga,'State'),'on')
                    crearmodificarcargaunif(n)
                elseif strcmp(get(botobarraesborrar,'State'),'on') && strcmp(get(botobarracarregacarga,'State'),'on')
                    %Se borran las cargas repartidas de las que la línea
                    %forma parte
                    for i=1:contcargaunif
                        for j=1:length(cargasunif(i).barres)
                            if barres(n).num==cargasunif(i).barres(j)
                                esborrarcargaunif(i);
                                break;
                            end
                        end
                    end
                end
            end
        end
    end

    function [hg_nusos,hg_barres,hg_carreguesbarres,hg_carreganusos,hg_cargasunif]=inicialitza_hg(graficaest)
       hg_carreguesbarres = hgtransform('Parent',graficaest);
       hg_carreganusos = hgtransform('Parent',graficaest);
       hg_cargasunif=hgtransform('Parent',graficaest);
       hg_barres = hgtransform('Parent',graficaest);
       hg_nusos = hgtransform('Parent',graficaest);
    end

%% PANEL 1.1 RESULTADOS: CREACIÓN Y ACCIONES
% El panel resultados es el padre de todos los paneles que incluyen los
% gráficos 3D de representación de resultados del programa

    function visibilidad_resultados()
        %Esta función determina la visibilidad de los gráficos 3D. Los
        %gráficos se ven sólo cuando el boton 3D color está activo, y sólo
        %se mostrará en cada momento el gráfico correspondiente al botón
        %que esté activo en el panel lateral Mostrar
        
        set(resultados,'Visible','off');
        
        if(get(boto3d,'Value')) 
            set(resultados,'Visible','on');
            set(resultados_flecha,'Visible','off');
            set(resultados_girox,'Visible','off');
            set(resultados_giroy,'Visible','off');
            set(resultados_Mx,'Visible','off');
            set(resultados_My,'Visible','off');
            set(resultados_Mxy,'Visible','off');
            if get(botonumnodos,'Value')==1
                set(resultados_flecha,'Visible','on');
            elseif get(botoflecha,'Value')==1
                set(resultados_flecha,'Visible','on');
            elseif get(botogirox,'Value')==1
                set(resultados_girox,'Visible','on');
            elseif get(botogiroy,'Value')==1
                set(resultados_giroy,'Visible','on');
            elseif get(botoMx,'Value')==1
                set(resultados_Mx,'Visible','on');
            elseif get(botoMy,'Value')==1
                set(resultados_My,'Visible','on');
            elseif get(botoMxy,'Value')==1
                set(resultados_Mxy,'Visible','on');
            else
                set(resultados_flecha,'Visible','on');
            end
        end
        
        % Se activa la rotación en 3 dimensiones con el ratón para el
        % gráfico 3D activo
        rotate3d on
    end

    function [resultados]=panel_resultados
        % Creación del panel resultados, que es el padre de todos los
        % paneles que incluyen los gráficos 3d. Invisible por defecto
        % inicialmente
        
        resultados=uipanel(figcme2,'Units','pixels','Position',[5,5,tm-[bwidth+25,10]],'BorderType','none'); % Creacio del panell.
        set(resultados,'Visible','off');      
    end

    function [resultados_flecha,grafico_flecha]=panel_resultados_flecha
        % Creación del panel que incluye el gráfico 3d de flecha. Invisible
        % por defecto inicialmente
       
        resultados_flecha=uipanel(resultados,'Units','pixels','Position',[5,5,tm-[bwidth+25,10]],'BorderType','etchedin','BorderWidth',1); % Creacio del panell.
        grafico_flecha=axes('Parent',resultados_flecha,'Units','pixels','Position',[36,50,tm-[190,70]],'color','none','MinorGridLineStyle',':','NextPlot','add','Box','on'); 
        set(resultados_flecha,'Visible','off');
        
          xlabel(grafico_flecha,'X (m)');ylabel(grafico_flecha,'Y (m)');zlabel(grafico_flecha,'Flecha (m)');
          title(grafico_flecha,'Resultados: Flecha','FontWeight','bold','FontSize',14);
          colorbar_flecha=colorbar('peer',grafico_flecha);
          ylabel(colorbar_flecha,'Flecha (m)');
          view(grafico_flecha,20,70);          
    end

    function [resultados_girox,grafico_girox]=panel_resultados_girox
        % Creación del panel que incluye el gráfico 3d de giro X. Invisible
        % por defecto inicialmente
        
        resultados_girox=uipanel(resultados,'Units','pixels','Position',[5,5,tm-[bwidth+25,10]],'BorderType','etchedin','BorderWidth',1); % Creacio del panell.
        grafico_girox=axes('Parent',resultados_girox,'Units','pixels','Position',[36,50,tm-[190,70]],'color','none','MinorGridLineStyle',':','NextPlot','add','Box','on');
        set(resultados_girox,'Visible','off');
          
          xlabel(grafico_girox,'X (m)');ylabel(grafico_girox,'Y (m)');zlabel(grafico_girox,'Giro X');
          title(grafico_girox,'Resultados: Giro X','FontWeight','bold','FontSize',14);
          colorbar_girox=colorbar('peer',grafico_girox);
          ylabel(colorbar_girox,'Giro X');
          view(grafico_girox,20,70); 
    end

    function [resultados_giroy,grafico_giroy]=panel_resultados_giroy
        % Creación del panel que incluye el gráfico 3d de giro Y. Invisible
        % por defecto inicialmente
        
        resultados_giroy=uipanel(resultados,'Units','pixels','Position',[5,5,tm-[bwidth+25,10]],'BorderType','etchedin','BorderWidth',1); % Creacio del panell.
        grafico_giroy=axes('Parent',resultados_giroy,'Units','pixels','Position',[36,50,tm-[190,70]],'color','none','MinorGridLineStyle',':','NextPlot','add','Box','on'); 
        set(resultados_giroy,'Visible','off');

          xlabel(grafico_giroy,'X (m)');ylabel(grafico_giroy,'Y (m)');zlabel(grafico_giroy,'Giro Y');
          title(grafico_giroy,'Resultados: Giro Y','FontWeight','bold','FontSize',14);
          colorbar_giroy=colorbar('peer',grafico_giroy);
          ylabel(colorbar_giroy,'Giro Y');
          view(grafico_giroy,20,70);      
    end   

    function [resultados_Mx,grafico_Mx]=panel_resultados_Mx
        % Creación del panel que incluye el gráfico 3d de Mx. Invisible
        % por defecto inicialmente
        
        resultados_Mx=uipanel(resultados,'Units','pixels','Position',[5,5,tm-[bwidth+25,10]],'BorderType','etchedin','BorderWidth',1); % Creacio del panell.
        grafico_Mx=axes('Parent',resultados_Mx,'Units','pixels','Position',[36,50,tm-[190,70]],'color','none','MinorGridLineStyle',':','NextPlot','add','Box','on'); 
        set(resultados_Mx,'Visible','off');

          xlabel(grafico_Mx,'X (m)');ylabel(grafico_Mx,'Y (m)');zlabel(grafico_Mx,'Momento X (Nm)');
          title(grafico_Mx,'Resultados: Momento X','FontWeight','bold','FontSize',14);
          colorbar_Mx=colorbar('peer',grafico_Mx);
          ylabel(colorbar_Mx,'Momento X (Nm)');
          view(grafico_Mx,20,70);  
    end

    function [resultados_My,grafico_My]=panel_resultados_My
        % Creación del panel que incluye el gráfico 3d de My. Invisible
        % por defecto inicialmente
        
        resultados_My=uipanel(resultados,'Units','pixels','Position',[5,5,tm-[bwidth+25,10]],'BorderType','etchedin','BorderWidth',1); % Creacio del panell.
        grafico_My=axes('Parent',resultados_My,'Units','pixels','Position',[36,50,tm-[190,70]],'color','none','MinorGridLineStyle',':','NextPlot','add','Box','on'); 
        set(resultados_My,'Visible','off');

          xlabel(grafico_My,'X (m)');ylabel(grafico_My,'Y (m)');zlabel(grafico_My,'Momento Y (Nm)');
          title(grafico_My,'Resultados: Momento Y','FontWeight','bold','FontSize',14);
          colorbar_My=colorbar('peer',grafico_My);
          ylabel(colorbar_My,'Momento Y (Nm)');
          view(grafico_My,20,70);             
    end

    function [resultados_Mxy,grafico_Mxy]=panel_resultados_Mxy
        % Creación del panel que incluye el gráfico 3d de Mxy. Invisible
        % por defecto inicialmente
        
        resultados_Mxy=uipanel(resultados,'Units','pixels','Position',[5,5,tm-[bwidth+25,10]],'BorderType','etchedin','BorderWidth',1); % Creacio del panell.
        grafico_Mxy=axes('Parent',resultados_Mxy,'Units','pixels','Position',[36,50,tm-[190,70]],'color','none','MinorGridLineStyle',':','NextPlot','add','Box','on');
        set(resultados_Mxy,'Visible','off');
 
          xlabel(grafico_Mxy,'X (m)');ylabel(grafico_Mxy,'Y (m)');zlabel(grafico_Mxy,'Momento XY (Nm)');
          title(grafico_Mxy,'Resultados: Momento XY','FontWeight','bold','FontSize',14);
          colorbar_Mxy=colorbar('peer',grafico_Mxy);
          ylabel(colorbar_Mxy,'Momento XY (Nm)');
          view(grafico_Mxy,20,70);                
    end

%% PANEL 2: VISTA. CREACIÓN Y ACCIONES
% El panel vista controla la edición y el modo de vista del programa
% (gráficos 3d en la presentación de resultados, o el plano XY donde se
% editan los datos)

    function [panel2,botoedicio,botoxy,boto3d]=panell_botons_vista
        % Creació del panell amb els botons.
        panel2=uipanel(figcme2,'Units','pixels','Position',[tm-[bwidth+15,190],bwidth+15,(bheight+5)*5+20],'BorderType','etchedin','BorderWidth',1,'FontName','default','FontUnits','pixels','FontSize',14,'Title','Vista:'); % Creacio del panell.
        botoedicio=uicontrol(panel2,'Units','pixels','Position',bpos(5),'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Edición','Value',1,'Callback',@edicio,'KeyPressFcn',@tecla); % Creació botó edició.
        botoreixeta=uicontrol(panel2,'Units','pixels','Position',bpos(4),'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Rejilla','Callback',@reixeta,'KeyPressFcn',@tecla); % Creació boto reixeta.
        botocentrar=uicontrol(panel2,'Units','pixels','Position',bpos(3),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Centrar','Callback',@centrar,'KeyPressFcn',@tecla); % Creació botó centrar.
        botoxy=uicontrol(panel2,'Units','pixels','Position',bpos(1)+[0,0,-(bwidth-(bwidth)/2),0],'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Plano XY','Callback',@vistaxy,'Value',1,'KeyPressFcn',@tecla); % Creació botó vista XY.
        boto3d=uicontrol(panel2,'Units','pixels','Position',bpos(1)+[(bwidth)/2,0,-(bwidth-(bwidth)/2),0],'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','3D Color','Callback',@vista3d,'KeyPressFcn',@tecla); % Creació vista 3D.
        uicontrol(panel2,'Units','pixels','Position',bpos(2),'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','center','String','Representación:'); % Etiqueta.
    end

    function edicio(hObject,eventdata,handles)
        % Activa/Desactiva la edición
        
        updatebotons(); % Determina el estado de los botones según el desarrollo del programa
        clicable % Determina sobre qué objetos se puede hacer clic
        colors
    end

    function updatebotons()
        % Esta función determina qué botones están activos o inactivos
        % dependiendo de en que punto se encuentra el programa. De esta
        % forma se impide que el usuario pueda cometer errores por acceder
        % a funcionalidades a las que no debería en ciertos momentos.
        
        % La flag de cada botón determina si ya se ha usado o no. Por
        % ejemplo, una vez introducido el contorno, ya no puede volver a
        % introducirse en los cálculos
        
        if (flagbMalla==0) 
            %Antes que se haya calculado la malla. Los botones de la barra
            %de herramientas están activos, menos las condiciones de
            %contorno. Los botones de Introducción de cálculos previos a la
            %malla también están activos
                if (flagbCon==1) 
                    set(botoContorn,'Enable','off');
                    set(botobarrabarra,'Enable','off');
                else
                    set(botoContorn,'Enable','on'); 
                    set(botobarrabarra,'Enable','on');
                end

                if (flagbMat==1) 
                    set(botoMaterial,'Enable','off');
                else
                    set(botoMaterial,'Enable','on'); 
                end

                if (flagbCp==1) 
                    set(botoCargaPunt,'Enable','off');
                    set(botobarracarreganus,'Enable','off');
                else
                    set(botoCargaPunt,'Enable','on'); 
                    set(botobarracarreganus,'Enable','on');
                end

                if (flagbCu==1) 
                    set(botoCargaUnif,'Enable','off');
                    set(botobarracarregabarra,'Enable','off');
                    set(botobarracarregacarga,'Enable','off');
                else
                    set(botoCargaUnif,'Enable','on');
                    set(botobarracarregabarra,'Enable','on');
                    set(botobarracarregacarga,'Enable','on');
                end
                
                if (flagbMat==1) && (flagbCon==1)
                    set(botoMalla,'Enable','on');
                else
                    set(botoMalla,'Enable','off');
                end
                    set(botobarranus,'Enable','on')
                    set(botobarraapoyo,'Enable','off')
                    set(botoCondCont,'Enable','off');
                    set(botoCalcDesp,'Enable','off');
                    set(botoObtDesp,'Enable','off');
                    set(get(panel3,'Children'),'Enable','off');
        else
            %Después de la malla se cancela la introducción de datos y se
            %desactivan los botones de la barra de herramientas. solo se
            %permite determinar las condiciones de contorno
            set(botoMalla,'Enable','off')
            set(botoCargaUnif,'Enable','off')
            set(botoCargaPunt,'Enable','off')
            set(botoMaterial,'Enable','off')
            set(botoContorn,'Enable','off')
            set(botobarranus,'Enable','off')
            set(botobarrabarra,'Enable','off')
            set(botobarracarreganus,'Enable','off')
            set(botobarracarregabarra,'Enable','off')
            set(botobarracarregacarga,'Enable','off')
            
            %Una vez introducidas las condiciones de contorno. Se activa el
            %botón de obtener desplazamientos y se desactiva toda la
            %edición
            if (flagbCc==1)
                set(botoCalcDesp,'Enable','on');
                set(botoCondCont,'Enable','off');
                set(botobarraapoyo,'Enable','off','State','off');
            else
                set(botoCondCont,'Enable','on');
                set(botoCalcDesp,'Enable','off');
                set(botobarraapoyo,'Enable','on');
            end
            
            %Una vez calculados los desplazamientos, se activan los botones
            %del panel lateral mostrar, para activar la presentación de
            %resultados
            if flagbCalcDesp==1
                set(botoCalcDesp,'Enable','off');
                set(botoObtDesp,'Enable','on');
                set(get(panel3,'Children'),'Enable','on');
                set(botoedicio,'Value',0);
                set(botoedicio,'Enable','off');
            end
                
        end
        
        %Cuando el botón edición está inactivo, se desactivan los botones
        %de la barra de herramientas
        if  get(botoedicio,'Value')==0
            
            set(botobarranus,'Enable','off')
            set(botobarrabarra,'Enable','off')
            set(botobarracarreganus,'Enable','off')
            set(botobarracarregabarra,'Enable','off')
            set(botobarracarregacarga,'Enable','off')
            set(botobarraapoyo,'Enable','off');
            set(botobarracrear,'Enable','off');
            set(botobarramodificar,'Enable','off');
            set(botobarraesborrar,'Enable','off');
        else
            set(botobarracrear,'Enable','on');
            set(botobarramodificar,'Enable','on');
            set(botobarraesborrar,'Enable','on');
        end
    end

    function reixeta(hObject,eventdata,handles)
        % Activa/desactiva la rejilla
        
        if get(hObject,'Value')
            grid on
        else
            grid off
        end
    end

    function centrar(hObject,eventdata,handles)
        % Centra la estructura en el gráfico y calcula los límites
        
        if grafica==grafica_est
            calcul_cord_extrems % Càlculo de las coordenadas extremas
            tam=get(grafica_est,'Position'); % Posició i tamany de la grafica. Valors de tamany horitzontal en tam(3), i en Vertical en tam(4).            
            switch vista
                case 'xy'
                    if (xmax-xmin)*tam(4)/tam(3)<(ymax-ymin) % Si la relación altura/anchura de la estructura es mayor que la de la gráfica
                        ampx=(ymax-ymin)*tam(3)/tam(4); % Anchura en función de la altura
                        ampy=(ymax-ymin);
                        XL=[xmed-ampx/1.5,xmed+ampx/1.5];
                        YL=[ymed-ampy/1.5,ymed+ampy/1.5];
                    elseif xmax==xmin && ymax==ymin
                        XL=XLimini+[xmed,xmed];
                        YL=XLimini*tam(4)/tam(3)+[ymed,ymed];
                    else % Si la relación altura/anchura de la estructura es menor que la de la gráfica
                        ampx=(xmax-xmin);
                        ampy=(xmax-xmin)*tam(4)/tam(3); % Altura en función de la anchura
                        XL=[xmed-ampx/1.5,xmed+ampx/1.5];
                        YL=[ymed-ampy/1.5,ymed+ampy/1.5];
                    end
                    set(grafica_est,'XLim',XL,'YLim',YL,'ZLim',ZLimini); % Asigna los valores a los ejes de la gráfica
            end
            escala % Calcula el factor de escala s
            escalar_nusos % Reescala los nodos y sus cargas
            clicable % Establece sobre qué objetos se puede hacer clic
        end
    end

    function calcul_cord_extrems
        % Calcula las coordenadas extremas y medias de la estructura
        
        if contnus % Si hi hay nodos
            xmin=nusos(1).posicio(1);
            xmax=nusos(1).posicio(1);
            ymin=nusos(1).posicio(2);
            ymax=nusos(1).posicio(2);
            zmin=nusos(1).posicio(3);
            zmax=nusos(1).posicio(3);
            xm=nusos(1).posicio(1);
            ym=nusos(1).posicio(2);
            zm=nusos(1).posicio(3);
            for i=2:contnus % si hay más de 1 nodo
                xmin=min(xmin,nusos(i).posicio(1)); % x mínima
                xmax=max(xmax,nusos(i).posicio(1)); % x màxima
                xm=xm+nusos(i).posicio(1); % sumatorio de x
                ymin=min(ymin,nusos(i).posicio(2));
                ymax=max(ymax,nusos(i).posicio(2));
                ym=ym+nusos(i).posicio(2);
                zmin=min(zmin,nusos(i).posicio(3));
                zmax=max(zmax,nusos(i).posicio(3));
                zm=zm+nusos(i).posicio(3);
            end
            xm=xm/contnus; % media de x
            ym=ym/contnus;
            zm=zm/contnus;
        else % si no hay nodos
            xmin=XLimini(1)*0.75;
            xmax=XLimini(2)*0.75;
            ymin=YLimini(1)*0.75;
            ymax=YLimini(2)*0.75;
            zmin=ZLimini(1)*0.75;
            zmax=ZLimini(2)*0.75;
            xm=(XLimini(1)+XLimini(2))*0.75/2;
            ym=(YLimini(1)+YLimini(2))*0.75/2;
            zm=(ZLimini(1)+ZLimini(2))*0.75/2;
        end
        xmed=(xmin+xmax)/2; % media de los extremos x
        ymed=(ymin+ymax)/2;
        zmed=(zmin+zmax)/2;
    end

    function vistaxy(hObject,eventdata,handles)
        % Se ejecuta cuando se selecciona la vista XY
        
        if get(hObject,'Value') && grafica==grafica_est
            %Se activa la edición, se desactiva el botón 3D, se quita la
            %visibilidad de los gráficos 3D
            
            vista='xy'; % Variable que controla la vista
            set(boto3d,'Value',0);
            set(grafica_est,'View',[0,90],'Box','on'); % Vista del plànol XY.
            set(editx,'Enable','off');
            set(edity,'Enable','off');
            set(botoedicio,'Value',1);
            updatebotons();
            set(panel1,'Visible','on');
            set(resultados,'Visible','off');
            rotate3d off;
            
        else
            set(hObject,'Value',abs(get(hObject,'Value')-1)); % Evita que se deseleccione la vista
        end
    end

    function vista3d(hObject,eventdata,handles)
%         % Se ejecuta cuando se selecciona la el botón 3D COLOR   

        if get(hObject,'Value') && grafica==grafica_est
            %Se desactiva la edición, se desactiva el botón Plano XY, se
            %muestran los gráficos 3D, se desactiva la visibilidad del
            %gráfico de edición principal
            
            vista='3d'; % Variable que controla la vista
            set(botoxy,'Value',0); 
            set(editx,'Enable','off');
            set(edity,'Enable','off');
            visibilidad_resultados;
            set(botoedicio,'Value',0);
            set(botoedicio,'Enable','off');
            updatebotons();
            set(panel1,'Visible','off');
        else
            set(hObject,'Value',abs(get(hObject,'Value')-1)); % Evita que se deseleccione la vista
        end
    end

%% PANEL 3: MOSTRAR. CREACIÓN Y ACCIONES
% El panel mostrar contiene los botones que controlan qué resultados se
% muestran en cada momento

    function [panel3,botonumnodos,botoflecha,botogirox,botogiroy,botoMx,botoMy,botoMxy,botoObtDesp]=panell_botons_grafica
        % Creación del panel y los botones

        panel3=uipanel(figcme2,'Units','pixels','Position',[tm-[bwidth+15,500],bwidth+15,(bheight+5)*3+20],'BorderType','etchedin','BorderWidth',1,'FontName','default','FontUnits','pixels','FontSize',14,'Title','Mostrar:'); % Creacio del panell.
        botonumnodos=uicontrol(panel3,'Units','pixels','Position',bpos(5),'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Núm. Nodo','Enable','on','Callback',@numnodos,'Value',1,'KeyPressFcn',@tecla); % Creacio botó vista de càrregues.
        botoflecha=uicontrol(panel3,'Units','pixels','Position',bpos(4),'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Desplazamiento','Enable','on','Callback',@flecha,'Value',0,'KeyPressFcn',@tecla); % Creacio botó vista de reaccions.
        botogirox=uicontrol(panel3,'Units','pixels','Position',bpos(3)+[0,0,-(bwidth-(bwidth-5)/2),0],'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Giro X','Enable','on','Callback',@girox,'Value',0,'KeyPressFcn',@tecla); % Creacio botó vista de diagrama d'axils.
        botogiroy=uicontrol(panel3,'Units','pixels','Position',bpos(3)+[(bwidth-5)/2+5,0,-(bwidth-(bwidth-5)/2),0],'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Giro Y','Enable','on','Callback',@giroy,'Value',0,'KeyPressFcn',@tecla); % Creacio botó vista de diagrama de moments en x.
        botoMx=uicontrol(panel3,'Units','pixels','Position',bpos(2)+[0,0,-(bwidth-(bwidth-5)/3),0],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Mx','Callback',@Mx,'KeyPressFcn',@tecla);
        botoMy=uicontrol(panel3,'Units','pixels','Position',bpos(2)+[(bwidth-10)/3+5,0,-(bwidth-(bwidth-5)/3),0],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','My','Callback',@My,'KeyPressFcn',@tecla);
        botoMxy=uicontrol(panel3,'Units','pixels','Position',bpos(2)+[(bwidth-10)/3*2+10,0,-(bwidth-(bwidth-5)/3),0],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Mxy','Callback',@Mxy,'KeyPressFcn',@tecla);
        botoObtDesp=uicontrol(panel3,'Units','pixels','Position',bpos(1),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Desp. Punto','Callback',@obtDesp,'KeyPressFcn',@tecla);
        end

    function numnodos(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Numero de Nodo
        botons_mostrar(1,0,0,0,0,0,0);
    end

    function flecha(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Flecha
        botons_mostrar(0,1,0,0,0,0,0);
    end

    function girox(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Giro X
        botons_mostrar(0,0,1,0,0,0,0);
    end

    function giroy(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Giro Y
        botons_mostrar(0,0,0,1,0,0,0);
    end

    function Mx(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Mx
        botons_mostrar(0,0,0,0,1,0,0);
    end

    function My(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón My
        botons_mostrar(0,0,0,0,0,1,0);
    end

    function Mxy(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el botón Mxy
        botons_mostrar(0,0,0,0,0,0,1);
    end
   
    function botons_mostrar(numnodos,flecha,girox,giroy,Mx,My,Mxy)
        %Determina el estado de los botones del panel lateral Mostrar.
        %Cuando se activa uno se desactivan los demás
        set(botonumnodos,'Value',numnodos);
        set(botoflecha,'Value',flecha);
        set(botogirox,'Value',girox);
        set(botogiroy,'Value',giroy);
        set(botoMx,'Value',Mx);
        set(botoMy,'Value',My);
        set(botoMxy,'Value',Mxy);
        
        %Actualiza la visualización de resultados, sea en el plano XY o en
        %los gráficos 3D, para que se muestren los correspondientes al
        %botón seleccionado
        redibuixar_textnusos;
        visibilidad_resultados;
    end

    function obtDesp(hObject,eventdata,handles)
    %El botón obtener desplazamientos del panel Mostrar muestra una caja de
    %diálogo y pide al usuario que entre las coordenadas. Si las
    %coordenadas pertenecen a la placa, solicita los desplazamientos y
    %momentos del punto al programa de cálculo. Si no pertenece a la placa,
    %se muestra un error por pantalla y se pide al usuario que lo intente
    %otra vez
    
        %la variable err comprueba si los datos entrados son válidos
        [punto,err]=dlgobtdesp();
        if(err==0)
            %la variable err determina si el punto pertenece a la placa
            [desp,momentos, err]=calculo.obtenerDespMomentos(punto);
            
            if err==0
                str= sprintf('Desplazamientos del punto (%.2f,%.2f):\nflecha= %5.2e m\ngiro X=%5.2e\ngiro Y=%5.2e\n\nMx=%5.2e Nm\nMy=%5.2e Nm\nMxy=%5.2e Nm\n',punto(1),punto(2),desp(1),desp(2),desp(3),momentos(1),momentos(2),momentos(3));
                h = msgbox(str,'Obtener desplazamiento');  
            else
                h=errordlg('El punto no pertenece a la placa. Reintentar', 'Obtener desplazamiento');
            end    
        elseif(err==1)
            h=errordlg('Coordenadas no válidas. Reintentar', 'Obtener desplazamiento');

        elseif(err==-1)
        end
            
    end

%% PANEL 4: INTRODUCIR CÁLCULOS. CREACIÓN Y ACCIONES DEL PANEL
% El panel lateral introducir cálculos actúa de interfaz entre la interfaz
% gráfica y el programa de cálculo. Sus botones introducen información en
% el programa de cálculo y obtienen los resultados

    function [panel4,botoCargaPunt,botoContorn,botoMaterial,botoMalla,botoReset,botoCargaUnif,botoCondCont,botoCalcDesp,flagbCon,flagbMat,flagbMalla,flagbCp,flagbCu,distnumnusmalla,flagbCc,flagbCalcDesp]=panel_calculo
        % Creación del panel y los botones
        panel4=uipanel(figcme2,'Units','pixels','Position',[tm-[bwidth+15,400],bwidth+10,(bheight+5)*6+20],'BorderType','etchedin','BorderWidth',1,'FontName','default','FontUnits','pixels','FontSize',14,'Title','Introducir Cálculos:'); % Creacio del panell.
        botoReset=uicontrol(panel4,'Units','pixels','Position',bpos(8),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','RESET','Callback',@reset,'KeyPressFcn',@tecla);        
        botoMaterial=uicontrol(panel4,'Units','pixels','Position',bpos(7),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','1. MATERIAL','Callback',@material,'KeyPressFcn',@tecla);
        botoContorn=uicontrol(panel4,'Units','pixels','Position',bpos(6),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','2. CONTORNO','Callback',@contorn,'KeyPressFcn',@tecla);
        botoCargaPunt=uicontrol(panel4,'Units','pixels','Position',bpos(5),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','3. CARGAS PUNT','Callback',@cargaPunt,'KeyPressFcn',@tecla);
        botoCargaUnif=uicontrol(panel4,'Units','pixels','Position',bpos(4),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','4. CARGAS UNIF','Callback',@cargaUnif,'KeyPressFcn',@tecla);
        botoMalla=uicontrol(panel4,'Units','pixels','Position',bpos(3),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','5. MALLAR','Callback',@malla,'KeyPressFcn',@tecla);
        botoCondCont=uicontrol(panel4,'Units','pixels','Position',bpos(2),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','6. COND. CONTORNO','Callback',@condCont,'KeyPressFcn',@tecla);
        botoCalcDesp=uicontrol(panel4,'Units','pixels','Position',bpos(1),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','7. CALCULAR DESPL.','Callback',@calcDesp,'KeyPressFcn',@tecla);
        
        %Las flags de cada botón determinan si se han usado o no, ya que
        %cada botón de éste panel se usa una sola vez y luego se desactiva
        distnumnusmalla=0.1;      
        flagbCon=0;
        flagbMat=0;
        flagbMalla=0;
        flagbCp=0;
        flagbCu=0;
        flagbCc=0;
        flagbCalcDesp=0;       
    end

    function resetflags()
        %Reinicia las flags de los botones al estado inicial
        flagbCon=0;
        flagbCp=0;
        flagbCu=0;
        flagbMalla=0;
        flagbMat=0;
        flagbCc=0;
        flagbCalcDesp=0;
    end

    function pos=bpos(n)
        %Calcula más fácilmente la posición en píxeles x,y de cada botón
        %según su numeración
        
        pos=[5,5+(n-1)*(bheight+5),bwidth,bheight];
    end

    %BOTÓN RESET
    function reset(hObject,eventdata,handles)
        % Se pregunta al usuario si está Seguro. Luego se eliminan todos
        % los objetos, nodos, líneas y objetos gráficos y se reinicia el
        % programa de cálculo, para empezar de nuevo. Se reinician también
        % los gráficos
        
        resp=questdlg('Seguro que quieres reiniciar la placa?','Reiniciar placa','Si','No','Cancelar','Si');
        switch resp
            case 'Si'
                h=waitbar(0,'Reiniciando la placa...');
                steps=contnus;
                step=0;
                
                for i=1:contnus
                    delete(nusos(i).hg);
                    delete(nusos(i).hgc);
                end
                for i=1:contbarra
                    delete(barres(i).hg);
                end
                contnus=0;
                nusos=nus.empty(1,0);
                contbarra=0;
                barres=barra.empty(1,0);
                calcul_cord_extrems 
                escala 
                redibuixar_nusos 
                escalar_nusos
                clicable 
                cargasunif=cargaunif.empty(1,0);
                contcargaunif=0;                    
                calculo.reset();
                numnodos();
                set(botoedicio,'Enable','on');
                set(botoedicio,'Value',1);
                resetflags();
                
                [resultados_flecha,grafico_flecha]=panel_resultados_flecha; %Crea el panel con el gráfico 3d de resultados de flecha
                [resultados_girox,grafico_girox]=panel_resultados_girox;    %Crea el panel con el gráfico 3d de resultados de giro X
                [resultados_giroy,grafico_giroy]=panel_resultados_giroy;    %Crea el panel con el gráfico 3d de resultados de giro Y
                [resultados_Mx,grafico_Mx]=panel_resultados_Mx;             %Crea el panel con el gráfico 3d de resultados de Momento X
                [resultados_My,grafico_My]=panel_resultados_My;             %Crea el panel con el gráfico 3d de resultados de Momento Y
                [resultados_Mxy,grafico_Mxy]=panel_resultados_Mxy;          %Crea el panel con el gráfico 3d de resultados de Momento XY
                
                figcme2_resize;

                updatebotons();
                thbarra=2;
                close(h); 
        end
    end

    %BOTÓN MATERIAL
    function material(hObject,eventdata,handles)
       % Se muestra una caja de diálogo donde el usuario introduce los
       % parámetros materiales de la placa: Espesor, Módulo de Elasticidad
       % y de Poisson y densidad. Se comprueba que los datos sean válidos
       % con la variable err y se introducen en el programa de cálculo. Si
       % hay algún error se muestra y se indica al usuario que lo vuelva a
       % intentar
        try 
            [poisson,E,thickness,density,err]=dlgmaterial();   
        catch
        end
            if (err==0) 
                calculo.setMaterial( poisson, E, thickness,density); 
                str=sprintf('Se ha actualizado el material de la placa:\n\nPoisson= %.2f\nMod. Elasticidad= %.2f Pa\nEspesor= %.2f m\nDensidad= %.2f kg/m^3',poisson,E,thickness,density);
                 h = msgbox(str,'Material actualizado');
                flagbMat=1;
                updatebotons();
            elseif (err==1)
                h = errordlg('Parámetros no válidos o incompletos. Reintroducir datos.','Parámetros no válidos');
            elseif (err==2)
                h = errordlg('El Coeficiente de Poisson debe estar entre -1 y 0.5','Coeficiente de Poisson no válido');
            elseif (err==3)
                h = errordlg('La densidad debe tener un valor positivo','Densidad no válida');
            elseif (err==4)
                h = errordlg('El espesor debe tener un valor positivo','Espesor no válido');    
            end
    end

    %BOTÓN CONTORNO
    function contorn(hObject,eventdata,handles)
     %Cuando se pulsa el botón lateral Contorno, se comprueba que las
     %líneas de contorno forman contornos cerrados y se introducen todos
     %(el contorno de la placa y sus agujeros) en el programa de cálculo.
     %finalmente se actualiza la flag y los botones
     
            index=1;
        barresList=repmat(barra,0,0);
       
        for i=1:contbarra
            if((barres(i).esCarga==0))
           barresList(index)=barres(i);
           index=index+1;
            end
        end
       contorno=cell(1,0);
       indexCont=0;
       
       while length(barresList)>0
       indexCont=indexCont+1;
       nusosCont=[];
       nusosCont=[barresList(1).nusinf;barresList(1).nussup];
       barresList(1)=[];
       i=1;
       err=0;
       finished=0;  
           while length(barresList)>0 && finished==0
               if nusosCont(length(nusosCont))==nusosCont(1)
                   finished=1;
               end
               if (nusosCont(length(nusosCont))==barresList(i).nusinf)
                   nusosCont=[nusosCont;barresList(i).nussup];
                   barresList(i)=[];
                   i=1;
               elseif (nusosCont(length(nusosCont))==barresList(i).nussup)
                   nusosCont=[nusosCont;barresList(i).nusinf];
                   barresList(i)=[];
                   i=1;
               elseif (i==length(barresList))
                       err=1;
                       finished=1;
               else
                       i=i+1;
               end
           end
           
           if nusosCont(1)~=nusosCont(length(nusosCont))
               err=1;
           end
           if (err==1) 
               break;
           else
               nodosList=[];
              for i=1:length(nusosCont)-1
                   nodosList=[nodosList;nusos(nusosCont(i)).getX() nusos(nusosCont(i)).getY()];
              end
              contorno(indexCont)={nodosList};
           end
       end
          
       if (err==0)
           for i=1:length(contorno)
           calculo.addContorno(cell2mat(contorno(i)));
           end
           str=sprintf('Se han añadido %d contornos a los cálculos',length(contorno));
           h = msgbox(str,'Contorno creado');
           flagbCon=1;
           updatebotons();
       else
          h = errordlg('El contorno no es cerrado. Revisar el contorno','Contorno no cerrado');
       end
    end

    %BOTÓN CARGA PUNTUAL
    function cargaPunt(hObject,eventdata,handles)
     % Cuando se pulsa el botón lateral Carga puntual, se añaden todas las
     % cargas puntuales dibujadas en el programa de cálculo. Si no hay
     % cargas, se pregunta al usuario si quiere continuar de todas formas.
     % finalmente se actualizan los botones y la flag del botón
     
       added=0;
       tol=1e-8;
       for i=1:contnus
           if abs(nusos(i).puntual(1))>tol || abs(nusos(i).puntual(2))>tol ||abs(nusos(i).puntual(3))>tol
               calculo.addCargaPunt([nusos(i).getX() nusos(i).getY()],nusos(i).puntual);
               added=added+1;
           end
       end
       
       continuar=0;
       if (added==0)
              resp=questdlg('No hay cargas puntuales que añadir. Continuar de todas formas?','Cargas Puntuales','Si','No','Cancelar','Si');
              switch resp
                  case 'Si'
                  continuar=1;
              end
       else
              continuar=1;
       end
       
       if continuar==1
           string=sprintf('Se han añadido %d cargas repartidas a los cálculos',added);
       h = msgbox(string,'Cargas Puntuales añadidas');
       
       flagbCp=1;
       updatebotons();
       end
    end

    %BOTÓN CARGA UNIFORME
    function cargaUnif(hObject,eventdata,handles)
     % Cuando se pulsa el botón lateral Carga Uniforme, se añaden todas las
     % cargas puntuales dibujadas en el programa de cálculo. Si no hay
     % cargas, se pregunta al usuario si quiere continuar de todas formas.
     % finalmente se actualizan los botones y la flag del botón
     
       added=0;
       for i=1:contcargaunif
           nodos=[];
           for j=1:length(cargasunif(i).nusos)-1
               nodos=[nodos;nusos(cargasunif(i).nusos(j)).getX() nusos(cargasunif(i).nusos(j)).getY()];
           end  
               calculo.addAreaCargada(nodos,cargasunif(i).carga);
               added=added+1;
       end
       continuar=0;
       if (added==0)
              resp=questdlg('No hay cargas repartidas que añadir. Continuar de todas formas?','Cargas Repartidas','Si','No','Cancelar','Si');
              switch resp
                  case 'Si'
                  continuar=1;
              end
       else
              continuar=1;
       end
       
       if continuar==1
           string=sprintf('Se han añadido %d cargas repartidas a los cálculos',added);
       h = msgbox(string,'Cargas Repartidas añadidas');
       flagbCu=1;
       updatebotons();
       end
    end

    %BOTÓN MALLA
    function malla(hObject,eventdata,handles)
     % Cuando se pulsa el botón lateral Mallar, se comprueba si se han
     % introducido cargas y en caso negativo se advierte al usuario. Luego
     % se llama al método mallador del programa de cálculo y se obtiene la
     % lista de nodos y elementos. Se redibuja la placa con la nueva
     % configuración de nodos y líneas
     
          continuar=0;
          if (flagbCp==0 && flagbCu==0)
              %Si no se han introducido cargas, se advierte al usuario
              resp=questdlg('No se han añadido cargas. Continuar de todas formas?','Mallar','Si','No','Cancelar','Si');
              switch resp
                  case 'Si'
                  continuar=1;
              end
          else
              continuar=1;
          end
          if continuar==1
              %La caja de diálogo permite determinar el tamaño máximo de
              %elemento y si se considerará o no el peso propio
              
              [pesopropio,meshsize,err]=dlgmalla();
              if (err==0)
                  flagbMalla=1;
                  h= waitbar(0.05,sprintf('Calculando Malla...'));
                  %Se calcula la malla con el programa de cálculo y se
                  %obtiene la lista de nodos y elementos
                  [pp, tt]=calculo.calcularMalla(pesopropio,meshsize);
                  waitbar(0.20);
                  elementos=tt;                   
                  %Se elimina el dibujo actual
                  for i=1:contcargaunif
                     esborrarcargaunif(1)
                  end
                  while(contnus>0)
                      esborrarnusNoDraw(nusos(1).num);
                  end
                  close(h);
                  fprintf('número de nodos: %d\n',size(pp,1));
                  h= waitbar(0.25,sprintf('Dibujando %d Nodos...',size(pp,1)));
                  
                  %Se crea el nuevo dibujo con la malla
                  for i=1:size(pp,1)
                          crearnusNoDraw([pp(i,1),pp(i,2)]);
                          waitbar(0.25+0.35*i/(size(pp,1)));
                  end
                  redibuixar_nusos % Redibuja los nodos
                  escala % Calcula el factor de escala
                  escalar_nusos % Reescala nodos y cargas
                  thbarra=1;
                  close(h);
                  fprintf('número de elementos: %d\n',size(tt,1));
                  h= waitbar(0.60,sprintf('Dibujando %d elementos...',size(tt,1)));
                  for i=1:size(tt,1)
                      novabarraNoDraw(tt(i,1),tt(i,2),0);
                      novabarraNoDraw(tt(i,2),tt(i,3),0);
                      novabarraNoDraw(tt(i,3),tt(i,1),0);
                      waitbar(0.60+0.40*i/(size(tt,1)));
                  end
                  redibuixar_barres % Dibuixa la barra.
%                   colorbarres
                  clicable % Estableix quins objectes gràfics responen als clics segons l'estat dels botons de la barra d'eines.
                  close(h)
                  botons_elements('off','off','off','off','off','on');
                  updatebotons();

                  elseif(err==1)
                  h=errordlg('El tamaño máximo de elemento introducido no és válido. Reintentar','Tamaño de elemento no válido');
                  elseif(err==2)
                  h=errordlg('El tamaño máximo de elemento debe ser positivo. Reintentar','Tamaño de elemento no válido');    
                  elseif(err==-1)
              end
          end
    end 

    %BOTÓN CONDICIONES DE CONTORNO
    function condCont(hObject,eventdata,handles)
       %Se introducen todas las condiciones de contorno en el programa de
       %cálculo. Si no hay condiciones de contorno que añadir, se pide al
       %usuario que añada alguna y pruebe de nuevo. finalmente se
       %actualizan los botones y se actualiza la flag del botón
       
       added=0;
       for i=1:contnus
           if (~strcmp(nusos(i).contorn,'libre'))
               calculo.addCondCont(i,nusos(i).contorn);
               added=added+1;
           end
       end
       if (added==0)
           h=errordlg('No hay condiciones de contorno que añadir. Revisar dibujo', 'Condiciones de Contorno');
       else
           string=sprintf('Se han añadido %d condiciones de contorno a los cálculos',added);
       h = msgbox(string,'Condiciones de Contorno añadidas');
       flagbCc=1;
       updatebotons();
       end
    end

    %BOTÓN CALCULAR DESPLAZAMIENTOS
    function calcDesp(hObject,eventdata,handles)
        %Se calculan los desplazamientos con el programa de calculo, se
        %actualiza la flag del botón y se asignan los desplazamientos y
        %momentos a todos los nodos.
        
        flagbCalcDesp=1;
        calculo.calcularDesplazamientos();
        for i=1:length(nusos)
           nusos(i).desp=calculo.getDesp(i);
           nusos(i).moment=calculo.getMomentos(i);
        end
            
            % Se recorren todos los elementos de la placa. para cada uno,
            % se generan las coordenadas de sus nodos y sus variables
            % resultado (flecha,giros,momentos)
            for j=1:size(elementos,1)
                flecha=zeros(length(elementos(j,:))+1,1);
                girox=zeros(length(elementos(j,:))+1,1);
                giroy=zeros(length(elementos(j,:))+1,1);
                mx=zeros(length(elementos(j,:))+1,1);
                my=zeros(length(elementos(j,:))+1,1);
                mxy=zeros(length(elementos(j,:))+1,1);
                coordXnodos=zeros(length(elementos(j,:))+1,1);
                coordYnodos=zeros(length(elementos(j,:))+1,1);
                
                for i=1:length(elementos(j,:))
                    coordXnodos(i)=nusos(elementos(j,i)).getX();
                    coordYnodos(i)=nusos(elementos(j,i)).getY();
                    flecha(i)=nusos(elementos(j,i)).desp(1);
                    girox(i)=nusos(elementos(j,i)).desp(2);
                    giroy(i)=nusos(elementos(j,i)).desp(3);
                    mx(i)=nusos(elementos(j,i)).moment(1);
                    my(i)=nusos(elementos(j,i)).moment(2);
                    mxy(i)=nusos(elementos(j,i)).moment(3);
                end

                coordXnodos(length(coordXnodos))=coordXnodos(1);
                coordYnodos(length(coordYnodos))=coordYnodos(1);
                flecha(length(flecha))=flecha(1);
                girox(length(girox))=girox(1);
                giroy(length(giroy))=giroy(1);
                mx(length(mx))=mx(1);
                my(length(my))=my(1);
                mxy(length(mxy))=mxy(1);
                
                % Una vez obtenidos todos los vectores con las coordenadas,
                % para cada elemento y resultado se genera una superficie
                % para su representación en 3D
                fill3(coordXnodos,coordYnodos,flecha,flecha,'parent',grafico_flecha);
                fill3(coordXnodos,coordYnodos,girox,girox,'parent',grafico_girox);
                fill3(coordXnodos,coordYnodos,giroy,giroy,'parent',grafico_giroy);
                fill3(coordXnodos,coordYnodos,mx,mx,'parent',grafico_Mx);
                fill3(coordXnodos,coordYnodos,my,my,'parent',grafico_My);
                fill3(coordXnodos,coordYnodos,mxy,mxy,'parent',grafico_Mxy);   
            end
            
    botons_elements('off','off','off','off','off','off');
    botons_mostrar(0,1,0,0,0,0,0);
    updatebotons();
    end

%% CREACIÓN Y MODIFICACIÓN DINÁMICA DE NODOS
% Funciones relacionadas con la creación, modificación, eliminación y
% dibujo de nodos

    function crearnus(pos)
        % Crea y dibuja un nuevo nodo
        
        if nargin>0
            %Si se determina una posición se añade en esta posición, si no
            %se lee el estado actual del ratón
            posicio=[pos(1),pos(2),0];
        else
        posicio=[str2double(get(editx,'String')),str2double(get(edity,'String')),0]; % Coordenadas de las cajas de texto
        end
        contnus=contnus+1; % Aumenta el total de nodos
        nusos(contnus)=nus; % Nuevo objetos nus
        nusos(contnus).num=contnus; % Se añade el objeto a la última posición del vector de nodos
        nusos(contnus).posicio=posicio; %posición actual
        nusos(contnus).contorn='libre'; %condición de contorno libre por defecto
        nusos(contnus).desp=[0;0;0]; %Se inicializan los desplazamientos
        nusos(contnus).moment=[0;0;0]; %Se inicializan los momentos
        calcul_cord_extrems % Recalcula las coordenadas máximas
        redibuixar_nusos % Redibuja los nodos
        escala % Calcula el factor de escala
        escalar_nusos % Reescala nodos y cargas
    end

    function crearnusNoDraw(pos)
        % Crea un nuevo nodo sin redibujar los nodos (aumenta en gran
        % medida el rendimiento cuando hay que crear muchos nodos
        
        if nargin>0
            %Si se determina una posición se añade en esta posición, sinó
            %se lee el estado actual del ratón
            posicio=[pos(1),pos(2),0];
        else
        posicio=[str2double(get(editx,'String')),str2double(get(edity,'String')),0]; % Coordenadas de las cajas de texto
        end
        contnus=contnus+1; % Aumenta el total de nodos
        nusos(contnus)=nus; % Nuevo objetos nus
        nusos(contnus).num=contnus; % Se añade el objeto a la última posición del vector de nodos
        nusos(contnus).posicio=posicio; %posición actual
        nusos(contnus).contorn='libre'; %condición de contorno libre por defecto
        nusos(contnus).desp=[0;0;0]; %Se inicializan los desplazamientos
        nusos(contnus).moment=[0;0;0]; %Se inicializan los momentos
        calcul_cord_extrems % Recalcula las coordenadas máximas        
    end

    function esborrarnus(n)
        % Elimina un nodo y su representación, así como las líneas que
        % estén conectadas a él

        esborrarcarreganus(n) % elimina la carga en el nodo
        if contbarra>0 % Si hay barras definidas
            for i=contbarra:-1:1
                if barres(i).nusinf==n || barres(i).nussup==n % Si un extremo está conectado al nodo
                    esborrarbarra(i)
                end
            end
        end
        delete(nusos(n).hg) %Destruye el objeto gráfico
        nusos2=nus; % Nueva lista de nodos, donde se quita el nodo borrado
        if n>1 
            nusos2(1:n-1)=nusos(1:n-1); 
        end
        if n<contnus
            nusos2(n:contnus-1)=nusos(n+1:contnus);
            for i=n:contnus-1
                %Actualiza la numeración
                nusos2(i).num=i; 
                set(nusos2(i).hg,'UserData',i);
                set(findobj(nusos2(i).hg,'Type','text'),'String',num2str(i));
            end
        end
        nusos=nusos2; % La nueva lista se convierte en la definitiva
        contnus=contnus-1; % actualiza el contador de nodos

        if contbarra>0 % Si hay líneas definidas, se actualiza la numeración de los nodos de las líneas
            for i=1:contbarra
                if barres(i).nusinf>n 
                    barres(i).nusinf=barres(i).nusinf-1; 
                end
                if barres(i).nussup>n 
                    barres(i).nussup=barres(i).nussup-1;
                end
            end
        end
        
        if contcargaunif>0 % Si hay cargas repartidas definidas, actualiza el número de los nodos
            for i=1:contcargaunif
                for j=1:length(cargasunif(contcargaunif).nusos)
                    if cargasunif(i).nusos(j)>n 
                        cargasunif(i).nusos(j)=cargasunif(i).nusos(j)-1;
                    end
                end
            end
        end
        
        
        calcul_cord_extrems % Recalcula los extremos de las coordenadas
        escala % Calcula el factor de escala s
        redibuixar_nusos % Redibuja los nodos
        escalar_nusos % Adecua la escala
        clicable % Actualiza los objetos clicables
    end
    
    function esborrarnusNoDraw(n)
        % Elimina un nodo y su representación, así como las líneas que
        % estén conectadas a él, sin redibujarlo todo (aumenta en gran
        % medida el rendimiento cuando hay que eliminar grandes cantidades
        % de nodos
        
        esborrarcarreganus(n)  % elimina la carga en el nodo
        if contbarra>0 % Si hay barras definidas..
            for i=contbarra:-1:1 
                if barres(i).nusinf==n || barres(i).nussup==n % Si un extremo está conectado al nodo
                    esborrarbarraNoDraw(i)
                end
            end
        end
        delete(nusos(n).hg) %Destruye el objeto gráfico
        nusos2=nus; % Nueva lista de nodos, donde se quita el nodo borrado
        if n>1 
            nusos2(1:n-1)=nusos(1:n-1); % Copia els nusos anterios a la nova llista.
        end
        if n<contnus
            nusos2(n:contnus-1)=nusos(n+1:contnus);
            for i=n:contnus-1
                %Actualiza la numeración
                nusos2(i).num=i; 
                set(nusos2(i).hg,'UserData',i); 
                set(findobj(nusos2(i).hg,'Type','text'),'String',num2str(i));
            end
        end
        nusos=nusos2; % La nueva lista se convierte en la definitiva
        contnus=contnus-1; % actualiza el contador de nodos

        if contbarra>0 % Si hay cargas repartidas definidas, actualiza el número de los nodos
            for i=1:contbarra
                if barres(i).nusinf>n 
                    barres(i).nusinf=barres(i).nusinf-1;
                end
                if barres(i).nussup>n 
                    barres(i).nussup=barres(i).nussup-1;
                end
            end
        end
    end

    function modificarnus(n)
        % Modifica un nodo
        
        [nus,err]=dlgnus(nusos(n)); % Caja de diálogo de edición del nodo
        if (err==0)
            nusos(n)=nus;
        elseif(err==1)
            h=errordlg('Valores introducidos no válidos. Reintentar.','Valores no válidos'); 
        end
        calcul_cord_extrems % Recalcula los extremos de las coordenadas
        escala % Calcula el factor de escala s
        redibuixar_nusos % Redibuja los nodos
        redibuixar_barres % Redibuja las líneas
        escalar_nusos % Adecua l'escala.
        clicable % Actualiza los objetos clicables
    end

    function redibuixar_nus(n)
        % Dibuja el nodo y elimina el dibujo anterior. Determina también la
        % posición relativa y la orientación
        
        con=[]; % Lista con los ángulos de las líneas conectadas al nodo
        for i=1:contbarra
            if barres(i).nusinf==n % Si el nodo está conectado al extremo inferior
                vec=nusos(barres(i).nussup).posicio-nusos(n).posicio; % Vector de dirección de la línea
                con(length(con)+1)=atan2(vec(2),vec(1));
            elseif barres(i).nussup==n % Si el nodo está conectado al extremo inferior
                vec=nusos(barres(i).nusinf).posicio-nusos(n).posicio;
                con(length(con)+1)=atan2(vec(2),vec(1));
            end
        end
        ang=0;
        switch nusos(n).contorn % Discrimina según el tipo de condición de contorno
            case 'libre' % Nodo libre
                ang=0; % No se gira
            case 'apoyoPuntual' % Apoyo Simple
                %Se mantiene en vertical, hacia abajo si pasa de la mitad
                %de altura
                if  nusos(n).posicio(2)<=ymed
                    ang=0;
                else
                    ang=pi;
                end
                
            case 'apoyoX' % Apoyo X
                %Se mantiene en vertical, hacia abajo si pasa de la mitad
                %de altura
                if  nusos(n).posicio(2)<=ymed
                    ang=0;
                else
                    ang=pi;
                end
            case 'apoyoY' % Apoyo Y
                %Se mantiene en horizontal, hacia la derecha si la
                %coordenada x es inferior a la media
                if  nusos(n).posicio(1)>=xmed 
                    ang=pi*1/2;
                else
                    ang=3/2*pi;
                end
            case 'empotramiento' % Empotramiento
                if numel(con)==1 % Si Solo está conectado a una línea
                    ang=con-pi/2; %Sigue la dirección de la linea
                else % Si está conectado a más de una línea
                    ang=atan2(sum(sin(con)),sum(cos(con)))-pi/2; % Gira el ángulo medio
                    ang=round(ang*12/pi)*pi/12; % Redondea el ángulo
                end
            otherwise
                ang=0;
                error=('contorno no válido');
        end
        
        nusos(n).gir=ang; % Apunta el ángulo de giro
            hg=dibuix_contorn(nusos(n).contorn,distnumnus,fontnusos,tamanyfontnusos,flagbMalla); % Dibuja el nodo
            set(hg,'ButtonDownFcn',@clic_nus,'UserData',n,'Parent',hg_nusos); % Asigna la función que se ejectua cuando se hace clic
            ht=findobj(hg,'Type','text'); % Objeto que contiene el texto
            pos=get(ht,'Position'); % Obtiene la posición
            angt=atan2(nusos(n).posicio(2)-ym,nusos(n).posicio(1)-xm); % Ángulo de situación del texto según la posición relativa del nodo
            angt=round((angt-pi/4)*2/pi)*pi/2+pi/4; % Redondea el angulo
            angt=angt-ang; % Resta el ángulo de giro respecto el nodo para que el texto vaya en la posición calculada
            pos(1:2)=[cos(angt),sin(angt)]*distnumnus; % Calcula en coordenadas la posición del texto
            set(ht,'String',num2str(n),'Position',pos,'HorizontalAlignment','center','VerticalAlignment','middle'); % Asigna la posición al texto
            
        delete(nusos(n).hg) % Borra el dibujo antiguo
        nusos(n).hg=hg; % Guarda el handle del nuevo objeto en el nodo
    end

    function redibuixar_textnusos
        % Redibuja los textos de los nodos, según el botón de Mostrar que
        % esté activo (numeración, flecha, giros o momentos)
        
        for n=1:contnus
            data=num2str(nusos(n).num);
            if(flagbCalcDesp==0 || get(botonumnodos,'Value')==1)
                data=num2str(nusos(n).num);
            elseif get(botoflecha,'Value')==1
                data=num2str(nusos(n).desp(1));
            elseif get(botogirox,'Value')==1
                data=num2str(nusos(n).desp(2));
            elseif get(botogiroy,'Value')==1
                data=num2str(nusos(n).desp(3));
            elseif get(botoMx,'Value')==1
                data=num2str(nusos(n).moment(1));
            elseif get(botoMy,'Value')==1
                data=num2str(nusos(n).moment(2));
            elseif get(botoMxy,'Value')==1
                data=num2str(nusos(n).moment(3));
            end
            hg=nusos(n).hg;
            ht=findobj(hg,'Type','text'); % Objeto que contiene el texto del nodo
            set(ht,'String',data,'HorizontalAlignment','center','VerticalAlignment','middle'); % Asigna el nuevo texto
        end
    end

    function redibuixar_nusos
        % Redibuja todos los nodos
        for i=1:contnus
            redibuixar_nus(i) % Redibuja cada nodo
        end
        colornusos % Colorea los nodos
    end

    function escala
        % Relaciona el tamaño de representación de los objetos gráficos con
        % el tamaño de la gráfica, para que sea siempre constante y se
        % muestren siempre del mismo tamaño
        
        % Se coge como referencia el eje horizontal
        xl=get(grafica_est,'XLim'); % A la resta de vistes es pren l'eix x.

        tam=get(grafica_est,'Position'); % tam(3) es el tamaño horizontal de la gráfica en píxeles
        s=(xl(2)-xl(1))*tamanynus/tam(3); % Calcula el factor de escala s
    end

    function escalar_nusos
        % Escala nodos y cargas según la variable de escala s calculada
        
        for i=1:contnus
            t=makehgtform('translate',nusos(i).posicio,'zrotate',nusos(i).gir,'scale',s); % Matriz de giro, desplazamiento y escala
            set(nusos(i).hg,'Matrix',t); % Asigna la matriz al objeto
            if any(nusos(i).puntual) % Si hay cargas aplicadas sobre el nodo
                t=makehgtform('translate',nusos(i).posicio,'scale',s); % Martiz de desplazamiento y escala
                set(nusos(i).hgc,'Matrix',t); % Asigna la matriz al objeto
            end
        end
    end

    function escalar_nus(n)
        % Escala un nodo y su carga
            i=n;
            t=makehgtform('translate',nusos(i).posicio,'zrotate',nusos(i).gir,'scale',s); % Matriz de giro, desplazamiento y escala
            set(nusos(i).hg,'Matrix',t); % Asigna la matriz al objeto
            if any(nusos(i).puntual) || any(nusos(i).moment) % Si hay cargas aplicadas sobre el nodo
                t=makehgtform('translate',nusos(i).posicio,'scale',s); % Martiz de desplazamiento y escala
                set(nusos(i).hgc,'Matrix',t); % Asigna la matriz al objeto
            end
    end

    function modificarcondcont(n,condCont)
        if nargin>1
            nusos(n).contorn=condCont;
        else
            nusos(n)=dlgcondcont(nusos(n)); % Caja de diálogo de edición de la posición de contorno
        end
        calcul_cord_extrems % Recalcula los extremos de las coordenadas
        escala % Calcula el factor de escala s
        redibuixar_nus(n) %Redibujar el nodo
        escalar_nus(n) % Adecua l'escala.
        clicable % Actualiza los objetos clicables
    end

    function seleccionarCondCont()
        % Permite al usuario seleccionar una zona rectangular del gráfico
        % con el cursor y aplicar la misma condición de contorno sobre
        % todos los nodos que estén en el interior de la zona seleccionada
        
        if flagcondcont 
            % Si ya se ha hecho clic sobre el primer punto, se completa la
            % creación de la seleccion y se aplican las condiciones de
            % contorno
            
            flagcondcont=0; % Reestablece el flag
            
            %Se obtienen las coordenadas x e y máximas y mínimas para
            %hallar los 4 puntos que forman el polígono seleccionado.
            x=get(rectanguloSeleccion(1),'XData');
            y=get(rectanguloSeleccion(1),'YData');
            xMax=x(1); xMin=x(1);
            yMax=y(1); yMin=y(1);
            
            for i=1:4
                x=get(rectanguloSeleccion(1),'XData');
                y=get(rectanguloSeleccion(1),'YData');
                if (x(1)>xMax) xMax=x(1); end
                if (x(1)<xMin) xMin=x(1); end
                if (y(1)>yMax) yMax=y(1); end
                if (y(1)<yMin) yMin=x(1); end

                delete(rectanguloSeleccion(1)); % Elimina el rectángulo de selección que sigue al cursor
                rectanguloSeleccion(1)=[]; 
            end
            
            [contorno,err]=dlgcondcontSeleccion(); % Caja de diálogo donde el usuario introduce la condición de contorno
            if err==0 % Si el usuario ha entrato los datos correctamente
             for i=1:contnus
                 % para todos los nodos de la placa, se comprueba si están
                 % dentro o en el límite del polígono. Si es así, se
                 % aplican las condiciones de contorno
                  if inpolygon(nusos(i).getX(),nusos(i).getY(),[xMin, xMin, xMax, xMax],[yMin, yMax, yMax, yMin])
                    modificarcondcont(i,contorno)
                  end
             end
            end
            
        else
         % Si se ha hecho clic sobre el primer punto, se crea el rectángulo
         % discontínuo temporal que muestra el área de selección y sigue al
         % cursor hasta que se vuelva a hacer clic
         
        posicio=[str2double(get(editx,'String')),str2double(get(edity,'String')),0];
        pos=posicio;
        
        % Se crean cuatro líneas discontínuas que forman el rectángulo
        rectanguloSeleccion(1)=line([posicio(1) posicio(1)],[pos(2) posicio(2)],[0 0],'color','k','LineWidth',1,'Clipping','off','HitTest','off','LineStyle','--'); % Crea una linia des del nus clicat fins a la posició del ratolí.
        rectanguloSeleccion(2)=line([pos(1) posicio(1)],[posicio(2) posicio(2)],[0 0],'color','k','LineWidth',1,'Clipping','off','HitTest','off','LineStyle','--'); % Crea una linia des del nus clicat fins a la posició del ratolí.
        rectanguloSeleccion(3)=line([pos(1) pos(1)],[pos(2) posicio(2)],[0 0],'color','k','LineWidth',1,'Clipping','off','HitTest','off','LineStyle','--'); % Crea una linia des del nus clicat fins a la posició del ratolí.
        rectanguloSeleccion(4)=line([pos(1) posicio(1)],[pos(2) pos(2)],[0 0],'color','k','LineWidth',1,'Clipping','off','HitTest','off','LineStyle','--'); % Crea una linia des del nus clicat fins a la posició del ratolí.
        flagcondcont=1;
        end
    end

    function esborrarapoyo(n)
        % "Borra" la condición de contorno de un nodo, es decir, se asigna
        % la condición "libre"
         modificarcondcont(n,'libre');
    end

%% CREACIÓN I MODIFICACIÓN DINÀMICA DE LÍNEAS
% Funciones relacionadas con la creación, modificación, eliminación,
% dibujo, de las líneas

    function crearbarra(n,esCarga)
        % Crea una línea en la placa. La variable de entrada esCarga
        % determinara si se trata de una Línea de Contorno o de una Línea
        % de Área de Carga. Cuando se hace el primer clic sobre un nodo se
        % crea una línea temporal que va siguiendo al cursor hasta que se
        % hace clic sobre el segundo nodo.
        
        if flagbarra && primernusbarra == n  %Evita que se cree una barra con los mismos nodos superior e inferior
        
        elseif flagbarra % Si ya se había hecho clic sobre un nodo, éste es el segundo nodo y por lo tanto se crea la línea
            novabarra(primernusbarra,n,esCarga) % Crea la línea
            flagbarra=0; % Reestablece el flag
            delete(hbarra); % Elimina la línea temporal que sigue al cursor
            hbarra=[]; 
        else % Si se ha hecho clic sobre el primer nodo
            primernusbarra=n; % Apunta el número de nodo
            posicio=[str2double(get(editx,'String')),str2double(get(edity,'String')),0]; % Obtiene la posición del cursor
            if esCarga
            color='g';
            else
            color='k';
            end
            hbarra=line([nusos(n).posicio(1) posicio(1)],[nusos(n).posicio(2) posicio(2)],[nusos(n).posicio(3) posicio(3)],'color',color,'LineWidth',2,'Clipping','off','HitTest','off','Parent',hg_barres); % Crea una línea temporal desdel nodo clicado hasta el cursor
            flagbarra=1; % Activa el flag para indicar que ya se ha hecho clic sobre el primer nodo
        end
    end

    function novabarra(nusinf,nussup,esCarga)
        % Crea una línea des del nodo inferior al superior
        
        existeix=0;
        
        % No permite que haya dos líneas del mismo tipo superpuestas, es
        % decir con los mismos nodos
        
        for i=1:contbarra
            if barres(i).nusinf==nusinf && barres(i).nussup==nussup
                if (esCarga==barres(i).esCarga)
                existeix=1;
                end
            elseif barres(i).nussup==nusinf && barres(i).nusinf==nussup
                if (esCarga==barres(i).esCarga)
                existeix=1;
                end
            end
        end
        if (existeix==0)
        contbarra=contbarra+1; % Incrementa el contador de líneas
        barres(contbarra)=barra; % Nuevo objeto en el vector
        barres(contbarra).nusinf=nusinf; % Nodo inferior
        barres(contbarra).nussup=nussup; % Nodo superior
        barres(contbarra).num=contbarra; % Asigna el número de línea
        redibuixar_barra(contbarra) % Dibuja la línea
        colorbarres
        clicable % Establece qué objetos gráficos tienen el clic activado
        end
    end

    function novabarraNoDraw(nusinf,nussup,esCarga)
        % Crea una línea des del nodo inferior al superior, pero no la
        % redibuja. Aumenta mucho el rendimiento cuando hay que añadir
        % muchas líneas a la vez
        
        existeix=0;
        
        % No permite que haya dos líneas del mismo tipo superpuestas, es
        % decir con los mismos nodos
        
        for i=1:contbarra
            if barres(i).nusinf==nusinf && barres(i).nussup==nussup
                existeix=1;
                break;
            elseif barres(i).nussup==nusinf && barres(i).nusinf==nussup
                existeix=1;
                break;
            end
        end
        if (existeix==0)
        contbarra=contbarra+1; % Incrementa el contador de líneas
        barres(contbarra)=barra; % Nuevo objeto en el vector
        barres(contbarra).nusinf=nusinf; % Nodo inferior
        barres(contbarra).nussup=nussup; % Nodo superior
        barres(contbarra).num=contbarra; % Asigna el número de línea
        end
    end

    function redibuixar_barra(n)
        % Elimina el dibujo existente y lo crea de nuevo
        
        delete(barres(n).hg); % Borra el objeto gráfico
        posinf=nusos(barres(n).nusinf).posicio; % Posición nodo inferior
        possup=nusos(barres(n).nussup).posicio; % Posición nodo superior
        barres(n).hg=line([posinf(1) possup(1)],[posinf(2) possup(2)],[posinf(3) possup(3)],'LineWidth',thbarra,'UserData',n,'ButtonDownFcn',@clic_barra,'Parent',hg_barres); % Crea la línea
        set(barres(n).hg,'Clippin','on') % NO permet que en 3d sobresurti de la gràfica.
    end

    function redibuixar_barres
        % Elimina los objetos gráficos de las líneas y los redibuja de nuevo
        for i=1:contbarra % Para todas las líneas, redibuja la línea
            redibuixar_barra(i);
        end
        colorbarres
    end

    function esborrarbarra(n)
        % Borra la línea indicada. Elimina de la lista la línea y elimina
        % los objetos gráficos asociados
        
        nusinf=barres(n).nusinf; % Nodo inferior
        nussup=barres(n).nussup; % Nodo superior
        for i=1:contcargaunif
            % Si la línea forma parte de alguna área con carga repartida,
            % se elimina también la carga repartida
            for j=1:length(cargasunif(i).barres)
                if barres(n).num==cargasunif(i).barres(j)
                    esborrarcargaunif(i);
                    break;
                end
            end
        end
        delete(barres(n).hg) % Elimina el objeto gráfico que representa la línea
        barres2=barra; % Crea una nueva lista de líneas
        if n>1
            barres2(1:n-1)=barres(1:n-1);
        end
        if n<contbarra
            barres2(n:contbarra-1)=barres(n+1:contbarra);
            for i=n:contbarra-1
                barres2(i).num=i;
                set(barres2(i).hg,'UserData',i);
            end
        end
        barres=barres2; % Elimina la lista antigua y la sustituye por la nueva
        contbarra=contbarra-1; % Actualitza el contador
        redibuixar_nus(nusinf) % Redibuja el nodo inferior
        redibuixar_nus(nussup) % Redibuja el nodo superior
    end

    function esborrarbarraNoDraw(n)
        % Borra la línea indicada. Elimina de la lista la línea y elimina
        % los objetos gráficos asociados. No se redibujan los elementos
        % gráficos para aumentar en gran medida el rendimiento cuando se
        % eliminan muchas a la vez
        
        delete(barres(n).hg) % Elimina el objeto gráfico que representa la línea
        barres2=barra; % Crea una nueva lista de líneas
        if n>1
            barres2(1:n-1)=barres(1:n-1); 
        end
        if n<contbarra
            barres2(n:contbarra-1)=barres(n+1:contbarra); 
            for i=n:contbarra-1
                barres2(i).num=i; % Actualitza els números de barra.
                set(barres2(i).hg,'UserData',i); % Actualitza els números de barra al camp 'UserData' dels objectes grafics.
            end
        end
        barres=barres2; % Elimina la lista antigua y la sustituye por la nueva
        contbarra=contbarra-1; % Actualitza el contador
    end

%% CREACIÓN I MODIFICACIÓN DINÀMICA DE CARGAS PUNTUALES
% Funciones relacionadas con la creación, modificación, eliminación,
% dibujo, de las cargas puntuales

    function crearmodificarcarreganus(n)
        % Crea o modifica la carga de un nodo
        
        [nus,err]=dlgcarreganus(nusos(n)); %Caja de diálogo donde se asigna la carga al nodo
        if err==0
        nusos(n)=nus;
        else
         h=errordlg('Valor de la carga no válido. Reintentar.', 'Carga no válida');    
        end
        redibuixa_carreganus(n); % Dibuja la carga
        escalar_nusos % Escala nodos y cargas
        colorcarreganusos
    end

    function redibuixa_carreganus(n)
         % Crea los objetos gráficos que determinan la carga puntual

        delete(nusos(n).hgc); % Elimina el objeto gráfico que representa la carga
        nusos(n).hgc=dibuix_carreganus(n,nusos(n).posicio,nusos(n).puntual,fontcarregues,tamanyfontcarregues); % Crea el objeto gráfico
        set(nusos(n).hgc,'ButtonDownFcn',@clic_carreganus,'UserData',n,'Parent',hg_carreganusos); % Asigna al objeto la función que se ejecutará cuando se haga clic encima
        set(get(nusos(n).hgc,'Children'),'Clipping','on')
    end

    function redibuixa_carreganusos
        % Redibuja todas las cargas puntuales
        
        for i=1:contnus
            redibuixa_carreganus(i) % Redibuja las cargas
        end
        colorcarreganusos
        escalar_nusos
    end

    function esborrarcarreganus(n)
        % Esborra la carrega d'un nus.
        nusos(n).puntual=[0;0;0]; % Reestablece a 0 los valores de la carga
        redibuixa_carreganusos
    end

%% CREACIÓN I MODIFICACIÓN DINÀMICA DE CARGAS REPARTIDAS
% Funciones relacionadas con la creación, modificación, eliminación,
% dibujo, de las cargas repartidas

    function crearmodificarcargaunif(n)
        % Crea o modifica una carga repartida
        
        index=1;
        barresList=repmat(barra,0,0);
        
        % Se parte de la línea que ha seleccionado el usuario y se mira si
        % forma una área cerrada con otras barras. Si lo hace se asigna una
        % carga repartida a ese área, sinó se muestra error
        for i=1:contbarra
            if((barres(i).esCarga==1) && i~=n)
           barresList(index)=barres(i);
           index=index+1;
            end
        end
        
       nusosArea=[barres(n).nusinf;barres(n).nussup];
       barresArea=[n];
       i=1;
       err=0;
       
       % Se comprueba si se forma una área cerrada
       while length(barresList)>0
           if nusosArea(length(nusosArea))==nusosArea(1)
               break;
           end
           if (nusosArea(length(nusosArea))==barresList(i).nusinf)
               nusosArea=[nusosArea;barresList(i).nussup];
               barresArea=[barresArea;barresList(i).num];
               barresList(i)=[];
               i=1;
           elseif (nusosArea(length(nusosArea))==barresList(i).nussup)
               nusosArea=[nusosArea;barresList(i).nusinf];
               barresArea=[barresArea;barresList(i).num];
               barresList(i)=[];
               i=1;
           elseif (i==length(barresList))
                   err=1;
                   break;
           else
                   i=i+1;
           end
       end
       
       if nusosArea(1)~=nusosArea(length(nusosArea))
           err=1;
       end
       if (err==0)
  
       % Se muestra una caja de diálogo para que el usuario entre el valor
       % de la carga. Se comprueba si es un valor válido
        [carga,err2]=dlgcargaunif([0;0;0]);
            if (err2==1)
                h = errordlg('Valor de carga no válido. Reintroducir datos.','Carga no válida');
                err=1;
            end
       else
          h = errordlg('El area de carga no es cerrada','Area no cerrada');
       end
           
           
       if (err==0)
           %si ya existía una carga repartida, se elimina y se añade la
           %nueva carga
           for i=1:contcargaunif
               a= ismember(nusosArea,cargasunif(i).nusos);
               b= ones(length(nusosArea),1);
               if (length(nusosArea)==length(cargasunif(i).nusos)) & (a==b)
                   esborrarcargaunif(i)
               end
           end
           
           % Se cambia el color de las líneas por el azul
           for i=1:length(barresArea)
           barres(barresArea(i)).color='b';
           barres(barresArea(i)).cargada=1;
           end
           
               contcargaunif=contcargaunif+1;
               cargasunif(contcargaunif).nusos=nusosArea;
               cargasunif(contcargaunif).carga=carga;
               cargasunif(contcargaunif).barres=barresArea;
               
                redibuixa_cargaunif(contcargaunif); % Dibuja la carga repartida
                escalar_nusos % Escala nodos y cargas
                colorbarres;
       end
    end

    function modificarCargaRepartida(n)
        % Se muestra una caja de diálogo para que el usuario entre el valor
       % de la carga. Se comprueba si es un valor válido
       err=0;
        [carga,err]=dlgcargaunif(cargasunif(n).carga);
            if (err==1)
                h = errordlg('Valor de carga no válido. Reintroducir datos.','Carga no válida');
                err=1;
            end
       if err==0
           cargasunif(n).carga=carga;
           redibuixa_cargaunif(n);           
       end
    end
    
    function redibuixa_cargaunif(n)
        % Crea los objetos gráficos que determinan la carga repartida
        
        delete(cargasunif(n).hg); % Elimina el objeto gráfico actual
        
        xSum=0;
        ySum=0;
        for i=1:length(cargasunif(n).nusos)
            xSum=xSum+nusos(cargasunif(n).nusos(i)).getX();
            ySum=ySum+nusos(cargasunif(n).nusos(i)).getY();
        end
        xMed=xSum/i;
        yMed=ySum/i;
        
        cargasunif(n).hg=dibuix_cargaunif(n,[xMed, yMed,0],cargasunif(n).carga,fontcarregues,tamanyfontcarregues); % Crea el objeto gráfico
        set(cargasunif(n).hg,'ButtonDownFcn',@clic_cargaunif,'UserData',n,'Parent',hg_cargasunif); % Asigna al objeto la función que se ejecutará cuando se haga clic encima
        set(get(cargasunif(n).hg,'Children'),'Clipping','on') 
        colorcargasunif
    end

    function esborrarcargaunif(n)
        try
        delete(cargasunif(n).hg) % Destruye el objeto gráfico de la carga uniforme
        catch
        end
        % Cambia el color y el estado de las líneas de área de carga para
        % indicar que ya no existe carga sobre el área
        for i=1:length(cargasunif(n).barres)
           barres(cargasunif(n).barres(i)).color='g';
           barres(cargasunif(n).barres(i)).cargada=0;
        end
        cargasunif(n)=[]; %borra el objeto del vector
        contcargaunif=contcargaunif-1; % Reduce el contador
        clicable % Determina qué objetos son clicables
        
    end

%% ACCIONES SOBRE LA VENTANA PRINCIPAL, REDIMENSIONAMIENTO, CONTROL DEL RATÓN Y TELCADO, ETC.

    function [nusos,contnus,barres,contbarra,vista,flagbarra,primernusbarra,hbarra,flagclic,flagmourenus,posini,s,xmin,xmax,ymin,ymax,zmin,zmax,xm,ym,zm,xmed,ymed,zmed,angle3d,grafica,nom,thbarra,contbarracarga,cargasunif,contcargaunif,bwidth,bheight,colorcarregues,flagcondcont,rectanguloSeleccion,elementos]=inicialitza_variables
        % Función que define las variables globales del programa con los
        % valores iniciales.Estas variables son accesibles dentro del
        % espacio de trabajo de la función principal del programa y sus
        % subfunciones. aparecen de color azul en el editor de Matlab
        % (variables globales).
    
        nusos=nus.empty(1,0); % Lista de nodos.
        contnus=0; % Contador de nodos.
        barres=barra.empty(1,0); % Lista de barras.
        contbarra=0; % Contador de barras.
        vista='xy'; % Modo de vista actual.
        flagbarra=0; % Flag que controla el proceso de crear barras. Se activa cuando se hace clic en el primer nodo, a la espera del segundo.
        primernusbarra=0; % Primer nodo clicado en el proceso de crear barras.
        hbarra=0; % Linea temporal que representa la barra en construcción.
        flagclic=0; % Flag que indica que se ha hecho clic en un botón del ratón y cuál ha sido.
        flagmourenus=0; % Flag que indica la función que detecta el movimiento del nodo que se ha clicado con el botón derecho y que hay que desplazar.
        posini=zeros(2,6); % Posición inicial del ratón al mover la pantalla.
        s=0; % Factor de escala para los objetos gráficos que se muestran por pantalla: nodos, cargas,etc.
        xmin=[]; % Coordenada x minima de la placa
        xmax=[]; % Coordenada x maxima de la placa.
        ymin=[]; % Coordenada y minima de la placa
        ymax=[]; % Coordenada y maxima de la placa
        zmin=[]; % Coordenada z minima de la placa
        zmax=[]; % Coordenada z maxima de la placa
        xmed=[]; % Media de las coordenadas x mínima i màxima de la placa.
        ymed=[]; % Media de las coordenadas y mínima i màxima de la placa.
        zmed=[]; % Media de las coordenadas z mínima i màxima de la placa.
        angle3d=0; % Angulo de rotación en la vista 3d.
        xm=0; % Media de las coordenadas x de la placa.
        ym=0; % Media de las coordenadas y de la placa.
        zm=0; % Media de las coordenadas z de la placa.
        grafica=0; % Grafica que se está mostrando, grafica de la estructura o graficas de resultados.
        nom=''; % Nombre de la placa actual.
        thbarra=2; %anchura de dibujo de linea.
        contbarracarga=0; %contador de barras de area de carga.
        cargasunif=cargaunif.empty(1,0); %cargas repartidas.
        contcargaunif=0; % contador de cargas repartidas.
        bwidth=150; %anchura de los botones laterales.
        bheight=25; %altura de los botones laterales.
        colorcarregues='b'; %color de las cargas puntuales y repartidas.
        flagcondcont=0;
        rectanguloSeleccion=[];
        elementos=[];
    end

    function [figcme2,tm,bg]=creacio_finestra
        % Creación de la ventana
        set(0,'Units','pixels') % Para obtener el tamano de la pantalla en pixeles.
        sc=get(0,'ScreenSize'); % Obtiene el tamano de la pantalla.
        tm=[1272 618]; % Tamano de la ventana en pantalla.
        ps=(sc(3:4)-tm)/2-[0,18];% Posición de la ventana, centrada en pantalla.
        bg=get(0,'defaultUicontrolBackgroundColor'); % Obtiene el color de fondo por defecto.
        figcme2=figure('Units','pixels','Position',[ps,tm],'NumberTitle','off','Name','Cálculo de Placas MEF','Resize','on','color',bg,'Toolbar','figure','MenuBar','none','ResizeFcn',@figcme2_resize,'WindowButtonMotionFcn',@moviment_ratoli,'WindowButtonDownFcn',@clic_figure,'WindowButtonUpFcn',@unclic_figure,'WindowScrollWheelFcn',@roda_ratoli,'CloseRequestFcn',@sortir,'KeyPressFcn',@tecla); % Crea la ventana principal del programa
    end

    function figcme2_resize(hObject,eventdata,handles)
    % Recoloca los paneles cuando se redimensiona la ventana
        sc=get(figcme2,'Position'); % Posición y tamaño de la pantalla
        tm=sc(3:4); % Tamaño de la ventana en la pantalla
        if tm(1)<700 % Limita el mínimo horizontal
            tm(1)=700;
            set(figcme2,'Position',[sc(1:2),tm]);
        end
        if tm(2)<630 % Limita el mínimo vertical
            sc(2)=sc(2)+tm(2)-630;
            tm(2)=630;
            set(figcme2,'Position',[sc(1:2),tm]);
        end
        % Cambia la posición y tamaño de los elementos
        set(panel1,'Position',[9,9,tm-[bwidth+30,15]]);                                             % Panell de la gráfica de edicion
        set(panel2,'Position',[tm-[bwidth+15,172],bwidth+10,(bheight+5)*5+20]);                     % Panel Lateral Vista
        set(panel3,'Position',[tm-[bwidth+15,172+(bheight+5)*13+30*2],bwidth+10,(bheight+5)*5+20]); % Panel lateral Mostrar
        set(panel4,'Position',[tm-[bwidth+15,172+(bheight+5)*8+30],bwidth+10,(bheight+5)*8+20]);    % Panel lateral Introducir Calculos
        set(grafica_est,'Position',[36,50,tm-[230,70]]);            %gráfica de edición
        set(logo,'Position',[36,50,tm-[230,70]]);                   %logo de fondo
        
        resultadosPos= [5,5,tm-[bwidth+30,15]]; 
        set(resultados,'Position',resultadosPos+[0,0,5,5]);         %Panel padre de los gráficos de resultados 3D
        set(resultados_flecha,'Position',resultadosPos);            %Panel del gráfico3D flecha
        set(resultados_girox,'Position',resultadosPos);             %Panel del gráfico3D giro X
        set(resultados_giroy,'Position',resultadosPos);             %Panel del gráfico3D giro Y
        set(resultados_Mx,'Position',resultadosPos);                %Panel del gráfico3D Mx
        set(resultados_My,'Position',resultadosPos);                %Panel del gráfico3D My
        set(resultados_Mxy,'Position',resultadosPos);               %Panel del gráfico3D Mxy
        
        graficosPos=[100,120,tm-[bwidth+250,200]];
        set(grafico_flecha,'Position',graficosPos);                 %gráfico3D flecha
        set(grafico_girox,'Position',graficosPos);                  %gráfico3D giro X
        set(grafico_giroy,'Position',graficosPos);                  %gráfico3D giro Y
        set(grafico_Mx,'Position',graficosPos);                     %gráfico3D Mx
        set(grafico_My,'Position',graficosPos);                     %gráfico3D My
        set(grafico_Mxy,'Position',graficosPos);                    %gráfico3D Mxy    
 
        centrar
    end

%% ACCIONES DE CONTROL DE CLICS DE RATÓN, MOVIMIENTO DE RATÓN Y PULSADO DE TECLAS
%Se determina el comportamiento del programa cuando se pulsan botones en el
%ratón o este se desplaza por la ventana del programa. también se
%determinan las accciones correspondientes cuando se pulsan ciertas teclas

    function clic_figure(hObject,eventdata,handles)
        % Se ejecuta cuando se pulsa el ratón. Se ejecuta siempre antes que
        % las otras funciones de control de pulsación. és más genérica y
        % complementa las otras funciones. Discrimina según el que botón se
        % pulsa y la almacena en la variable flagclic
        
        switch get(figcme2,'SelectionType')
            case 'normal' % Botón iziquierdo
                flagclic=1;
                if strcmp(get(botobarramoure,'State'),'on')
                    posini=get(grafica_est,'currentpoint');
                end
            case 'open' % Doble clic
                flagclic=2;
            case 'alt'
                flagclic=3; %  botón derecho o Ctrl+botón izquierdo
            case 'extend'
                flagclic=4; % botón central, Shift+botón izquierdo o ambos botones
                posini=get(grafica_est,'currentpoint');
                set(figcme2,'Pointer','hand');
        end
    end

    function unclic_figure(hObject,eventdata,handles)
        % Se ejecuta cuando se libera el ratón
        
        flagclic=0; % Resetea la variable de pulsación
        flagmourenus=0; % Si se estaba moviendo un nodo, resetea el flag para que no pueda moverse más con el ratón
        
        % si se estaba moviendo el gráfico o haciendo zoom, se da al cursor
        % el dibujo correspondiente
        if strcmp(get(botobarramoure,'State'),'on')
            set(figcme2,'Pointer','hand');
        elseif strcmp(get(botobarraapropar,'State'),'on') || strcmp(get(botobarraallunyar,'State'),'on')
            set(figcme2,'Pointer','circle');
        else
            set(figcme2,'Pointer','arrow');
        end
    end

    function roda_ratoli(hObject,eventdata)
        % Amplía o reduce el gráfico de edición con la rueda del ratón.

        zom(eventdata.VerticalScrollCount/factorzoom)
    end

    function [] = zom(factor)
        % Amplía y reduce la gráfica de edición según un factor

        if grafica==grafica_est
            posbruta=get(grafica_est,'currentpoint'); % Posición del cursor
            lim=[get(grafica_est,'XLim');get(grafica_est,'YLim');get(grafica_est,'ZLim')]; % Escala de los ejes
            
            frac = (posbruta(1,:)'-lim(:,1))./(lim(:,2)-lim(:,1));
            an=(lim(:,2)-lim(:,1))*2^factor; % Anchura x 2^factor
            lim(:,1) = posbruta(1,:)' - an.*frac;
            lim(:,2) = posbruta(1,:)' + an.*(1-frac);
            
            set(grafica_est,'XLim',lim(1,:),'YLim',lim(2,:),'ZLim',lim(3,:)); % Fija la nueva escala
            escala % Calcula el factor de escala s
            escalar_nusos % Reescala los nodos y las cargas
            clicable % Establece qué objetos responden al ratón (según los botones activos en la barra de herramientas
        end
    end

    function moviment_ratoli(hObject,eventdata,handles)
        % Se ejecuta cuando se mueve el ratón sobre la ventana del
        % programa. Actualiza los valores de los cajones de coordenadas
        % inferiores según las posición. Cuando se crea una línea la línea
        % temporal sigue al ratón. Si se mantiene la rueda clicada se mueve
        % el gráfico. Con el botón derecho se mueven los nodos.
        
        posbruta=get(grafica_est,'currentpoint'); % Posición del cursor
        precisio=str2double(get(editprec,'String')); % Precisión definida en la caja de texto
        posicio=round(posbruta(1,1:3)/precisio)*precisio; % Redondea la posición
        
        % Actualitza la posición en las cajas de texto inferiores
        switch vista
            case 'xy'
                set(editx,'String',num2str(posicio(1))); % en vista de edición muestra X e Y
                set(edity,'String',num2str(posicio(2)));
            case '3d'
                set(editx,'String',''); % Desactiva los cajas de posición en los gráficos 3D
                set(edity,'String','');
        end
        
        % Si se está creando una línea, actualiza la posición para que la
        % línea "siga" al cursor
        if flagbarra
            x=get(hbarra,'XData');
            y=get(hbarra,'YData');
            set(hbarra,'XData',[x(1) posbruta(1,1)],'YData',[y(1) posbruta(1,2)]);
        end
        
        % Si se está seleccionando para determinar las condiciones de
        % contorno, actualiza la posición para las 4 líneas discontinuas
        % que forman el área de selección para que "sigan" al cursor
        if flagcondcont    
            x=get(rectanguloSeleccion(1),'XData');
            y=get(rectanguloSeleccion(1),'YData');
            set(rectanguloSeleccion(1),'XData',[x(2) x(2)],'YData',[posbruta(1,2) y(2)]);
            
            x=get(rectanguloSeleccion(2),'XData');
            y=get(rectanguloSeleccion(2),'YData');
            set(rectanguloSeleccion(2),'XData',[posbruta(1,1) x(2)],'YData',[y(2) y(2)]);
            
            x=get(rectanguloSeleccion(3),'XData');
            y=get(rectanguloSeleccion(3),'YData');
            set(rectanguloSeleccion(3),'XData',[posbruta(1,1) posbruta(1,1)],'YData',[posbruta(1,2) y(2)]);
            
            x=get(rectanguloSeleccion(4),'XData');
            y=get(rectanguloSeleccion(4),'YData');
            set(rectanguloSeleccion(4),'XData',[posbruta(1,1) x(2)],'YData',[posbruta(1,2) posbruta(1,2)]);
        end
        
        % Si se ha clicado la rueda del ratón o se mueve el gráfico,
        % modifica los límites del gráfico para adaptarse al movimiento
        if flagclic ==4 || (flagclic ==1 && strcmp(get(botobarramoure,'State'),'on'))
            mov=posbruta-posini; % posini es la posició anterior.
            mov=mov(1,:);
            if ~strcmp(vista,'3d')
                xl=get(grafica_est,'XLim');
                xl=xl-[mov(1),mov(1)];
                yl=get(grafica_est,'YLim')-[mov(2),mov(2)];
                zl=get(grafica_est,'ZLim')-[mov(3),mov(3)];
                set(grafica_est,'XLim',xl,'YLim',yl,'ZLim',zl);
            end
        end
        
        % Con el botón derecho pulsado sobre un nudo, se mueve éste con el
        % ratón
        if flagmourenus && ~get(boto3d,'Value')
            nusos(flagmourenus).posicio=posicio; % flagmourenus contiene el nudo afectado
            escala % Calcula el factor de escala s
            redibuixar_nusos % Redibuja los nodos para reorientarlos adecuadamente
            redibuixar_barres % Actualiza el dibujo de las líneas
            escalar_nusos % Reescala nodos y cargas
            clicable % Establece qué objetos responden al ratón (según los botones activos en la barra de herramientas
        end
    end

    function tecla(hObject,eventdata,handles)
        % Se ejecuta cuando se pulsa una tecla, realizando diferentes
        % acciones según el momento 
        
        % Si se está creando una línea se aborta con ESCS
        if flagbarra && strcmp(eventdata.Key,'escape')
            flagbarra=0; % Resetea el flag
            delete(hbarra) % Borra la línea temporal
            hbarra=[];
        elseif strcmp(eventdata.Key,'escape') && grafica~=grafica_est
            clic_grafica_res
        else  %Si estem a grafica_est, cas general, desactiva els botons d'accio
            botons_accions('off','off','off','off','off','off')
        end

        %C: botón Crear
        if strcmp(eventdata.Key,'c')
             botocrear
        end
        %M: botón Modificar
        if strcmp(eventdata.Key,'m')
             botomodificar
        end        
        %E: botón borrar
        if strcmp(eventdata.Key,'b')
             botoesborrar
        end 
        
    end
end

%% FUNCIÓN DE CARGA DE OPCIONES

function [fontnusos,tamanyfontnusos,fontcarregues,tamanyfontcarregues,factorzoom,tamanynus,distnumnus,precini,XLimini,YLimini,ZLimini,colormodificar,coloresborrar,colorcarregues]=loadopcions
% Carga las opciones del programa (tipo y tamaño de fuente y de los elementos gráficos, estado inicial, etc.) 

    XLimini= [-5 5];
    YLimini= [-2.5 2.5];
    ZLimini= [2.5 5];
    colorcarregues='b';
    coloresborrar=[1 0 0];
    colormodificar=[0 1 1];
    distnumnus=0.2;
    factorzoom=10;
    fontcarregues='SansSerif';
    fontnusos='Times New Roman';
    precini=0.1;
    tamanyfontcarregues=16;
    tamanyfontnusos=10;
    tamanynus=100;    
end