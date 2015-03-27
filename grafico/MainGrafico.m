% T�TULO: Funci�n MainGrafico para CalculoPlacasMEF
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
% Esta funci�n es la funci�n principal de la interfaz gr�fica de usuario
% del programa. en ella se crea toda la interfaz y se responde a las
% acciones del usuario, y se llaman las funciones auxiliares de dibujo o
% cajas de di�logo seg�n es conveniente. Asimismo, esta funci�n recibe como
% par�metro un objeto de tipo MainCalculo, que es el n�cleo del m�dulo de
% c�lculo. a trav�s de este objeto la interfaz se comunica con el m�dulo de
% c�lculo, enviando datos y obteniendo resultados seg�n convenga

function MainGrafico(calculo)

%% INICIACI�N DE LAS VARIABLES DEL PROGRAMA. CARGA DE OPCIONES
% Se crean todas las variables globales que se usan en la funci�n y se
% cargan las distintas opciones de la interfaz

[nusos,contnus,barres,contbarra,vista,flagbarra,primernusbarra,hbarra,flagclic,flagmourenus,posini,s,xmin,xmax,ymin,ymax,zmin,zmax,xm,ym,zm,xmed,ymed,zmed,angle3d,grafica,nom,thbarra,contbarracarga,cargasunif,contcargaunif,bwidth,bheight,colorcarregues,flagcondcont,rectanguloSeleccion,elementos]=inicialitza_variables;
[fontnusos,tamanyfontnusos,fontcarregues,tamanyfontcarregues,factorzoom,tamanynus,distnumnus,precini,XLimini,YLimini,ZLimini,colormodificar,coloresborrar,colorcarregues]=loadopcions; % Carga las opciones.
[figcme2,tm,bg]=creacio_finestra; % Crea la ventana principal del programa.

%% CREACI�N DE LOS ELEMENTOS DE LA INTERFAZ GR�FICA: PANELES, TEXTOS, ICONOS, BOTONES
% Se crean todos los elementos interactivos de la interfaz. Se estructuran
% por grupos para facilitar su manejo des del programa

[barraeines,botobarracrear,botobarramodificar,botobarraesborrar,botobarranus,botobarrabarra,botobarracarreganus,botobarracarregabarra,botobarracarregacarga,botobarraapoyo,botobarramoure,botobarraapropar,botobarraallunyar]=creacio_barra_eines; % Carga la barra de herramientas.
creacio_menus % Crea la barra de men�s.
[panel1,logo,grafica_est,editx,edity,editprec]=creacio_panell_grafica; % Crea el panel con la gr�fica de edici�n del programa y las cajas de coordenadas y precision

[resultados]=panel_resultados;                              %Crea el panel de resultados: es el panel 'Padre' de todos los paneles con los gr�ficos 3d de representacion de resultados
[resultados_flecha,grafico_flecha]=panel_resultados_flecha; %Crea el panel con el gr�fico 3d de resultados de flecha
[resultados_girox,grafico_girox]=panel_resultados_girox;    %Crea el panel con el gr�fico 3d de resultados de giro X
[resultados_giroy,grafico_giroy]=panel_resultados_giroy;    %Crea el panel con el gr�fico 3d de resultados de giro Y
[resultados_Mx,grafico_Mx]=panel_resultados_Mx;             %Crea el panel con el gr�fico 3d de resultados de Momento X
[resultados_My,grafico_My]=panel_resultados_My;             %Crea el panel con el gr�fico 3d de resultados de Momento Y
[resultados_Mxy,grafico_Mxy]=panel_resultados_Mxy;          %Crea el panel con el gr�fico 3d de resultados de Momento XY

[panel2,botoedicio,botoxy,boto3d]=panell_botons_vista; % Crea el panel con los botones que controlan las vistas y edici�n.
[panel3,botonumnodos,botoflecha,botogirox,botogiroy,botoMx,botoMy,botoMxy,botoObtDesp]=panell_botons_grafica; % Panel con los botones para seleccionar los elementos que se muestren en la presentaci�n de resultados.
[panel4,botoCargaPunt,botoContorn,botoMaterial,botoMalla,botoReset,botoCargaUnif,botoCondCont,botoCalcDesp,flagbCon,flagbMat,flagbMalla,flagbCp,flagbCu,distnumnusmalla,flagbCc,flagbCalcDesp]=panel_calculo; %Panel lateral con los botones que env�an los datos al programa de c�lculo
[hg_nusos,hg_barres,hg_carreguesbarres,hg_carreganusos,hg_cargasunif]=inicialitza_hg(grafica_est);
resetflags();
updatebotons();

% Una vez creados los objetos, el programa espera la interacci�n con el
% usuario y ejectua las acciones programadas.

%% BARRA DE MEN�: CREACI�N Y ACCIONES
% Es la barra de men� superior del programa

    function creacio_menus
        % Crea la barra de men�s.
        
        menuarxiu=uimenu(figcme2,'Label','Archivo'); % Men� Archivo
        menuayuda=uimenu(figcme2,'Label','Ayuda'); % Men� Ayuda
        uimenu(menuayuda,'Label','Tutorial (PDF)','Callback',@menututorial); % Submen� tutorial
        uimenu(menuayuda,'Label','Gu�a R�pida','Callback',@menuguiarapida); % Submen� tutorial
        uimenu(menuayuda,'Label','Acerca de...','Callback',@menuacerca); % Submen� Acerca de...
        uimenu(menuarxiu,'Label','Nuevo','Callback',@menunou); % Submen� Nuevo
        uimenu(menuarxiu,'Label','Salir','Callback',@sortir); % Submen� Salir
    end

    function menunou(hObject,eventdata,handles)
        % S'executa amb el men� 'nou'
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
        % submen� Salir. Confirma que se quiere salir
        
        resp=questdlg('Seguro que quieres Salir? Se perder�n los datos','Salir de C�lculo de Placas MEF','Si','No','Cancelar','Si');
        switch resp
            case 'Si'
                delete(figcme2) % Esborra la finestra.
                close all;
        end
    end

%% BARRA DE HERRAMIENTAS. CREACI�N Y ACCIONES
% Barra superior de herramientas del programa. Iconos.

    function [barraeines,botobarracrear,botobarramodificar,botobarraesborrar,botobarranus,botobarrabarra,botobarracarreganus,botobarracarregabarra,botobarracarregacarga,botobarraapoyo,botobarramoure,botobarraapropar,botobarraallunyar]=creacio_barra_eines
        % Crea una nova barra d'eines i defineix els botons.
        % Per als botons de zoom i moviment en copia l'imatge de la barra
        % per defecte de Matlab, per� nom�s la imatge, les accions estan
        % reprogramades per tal de tenir el control i que Matlab no faci
        % accions extra�es.
        
        barraperdefecte=findall(figcme2,'Type','uitoolbar'); % Handle de la barra por defecto de Matlab
        barraeines=uitoolbar; % Creaci�n de barra de herramientas propia
        botobarracrear=uitoggletool('TooltipString','Crear (C)','CData',imread('lapiz.png','BackgroundColor',bg),'State','on','ClickedCallback',@botocrear); % Bot�n Crear
        botobarramodificar=uitoggletool('TooltipString','Modificar (M)','Cdata',imread('editar.png','BackgroundColor',bg),'ClickedCallback',@botomodificar); % Bot�n modificar
        botobarraesborrar=uitoggletool('TooltipString','Borrar (B)','CData',imread('goma.png','BackgroundColor',bg),'ClickedCallback',@botoesborrar); % Bot�n Borrar
        botobarranus=uitoggletool('Separator','on','TooltipString','Nodo','CData',imread('nudo.png','BackgroundColor',bg),'State','on','ClickedCallback',@botonus); % Boton Nodo
        botobarrabarra=uitoggletool('Separator','on','TooltipString','L�nea de contorno de placa','CData',imread('contorno.png','BackgroundColor',bg),'ClickedCallback',@botobarra); % Bot�n L�nea de Contorno
        botobarracarreganus=uitoggletool('Separator','on','TooltipString','Carga Puntual en nodo','CData',imread('carganudo.png','BackgroundColor',bg),'ClickedCallback',@botocarreganus); % Bot�n Carga Puntual
        botobarracarregabarra=uitoggletool('Separator','on','TooltipString','Linea de �rea de carga','CData',imread('cargabarra.png','BackgroundColor',bg),'ClickedCallback',@botocarregabarra); % Boton L�nea de �rea de Carga
        botobarracarregacarga=uitoggletool('TooltipString','Cargar �rea','CData',imread('cargacarga.png','BackgroundColor',bg),'ClickedCallback',@botocarregacarga); % Bot�n Aplicar Carga Repartida
        botobarraapoyo=uitoggletool('Separator','on','TooltipString','Condici�n de contorno del nodo','CData',imread('apoyo.png','BackgroundColor',bg),'ClickedCallback',@botoapoyo); % Bot�n Condiciones de Contorno
        botobarramoure=uitoggletool('Separator','on','TooltipString','Mover','CData',get(findall(barraperdefecte,'TooltipString','Pan'),'CData'),'ClickedCallback',@botomoure); % Bot�n mover (se usa el mismo por defecto de Matlab)
        botobarraapropar=uitoggletool('TooltipString','Acercar','CData',get(findall(barraperdefecte,'TooltipString','Zoom In'),'CData'),'ClickedCallback',@botoapropar); %  Bot�n acercar (se usa el mismo por defecto de Matlab)
        botobarraallunyar=uitoggletool('TooltipString','Alejar','CData',get(findall(barraperdefecte,'TooltipString','Zoom Out'),'CData'),'ClickedCallback',@botoallunyar);%  Bot�n alejar (se usa el mismo por defecto de Matlab)
        set(figcme2,'Toolbar','none'); % Se desactiva la barra de herramientas original
    end

    function botocrear(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Crear
 
        botons_accions('on','off','off','off','off','off')
    end
    function botomodificar(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Modificar
        botons_accions('off','on','off','off','off','off')
    end
    function botoesborrar(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Borrar
        botons_accions('off','off','on','off','off','off')
    end
    function botomoure(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Mover
        botons_accions('off','off','off','on','off','off')
    end
    function botoapropar(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Acercar
        botons_accions('off','off','off','off','on','off')
    end
    function botoallunyar(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Alejar
        botons_accions('off','off','off','off','off','on')
    end
    function botonus(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Nodo
        botons_elements('on','off','off','off','off','off')
    end
    function botobarra(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n L�nea de Contorno
        botons_elements('off','on','off','off','off','off')
    end
    function botocarreganus(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Carga Puntual
        botons_elements('off','off','on','off','off','off')
    end
    function botocarregabarra(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n L�nea de �rea de Carga
        botons_elements('off','off','off','on','off','off')
    end
    function botocarregacarga(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Aplicar Carga Repartida
        botons_elements('off','off','off','off','on','off')
    end
    function botoapoyo(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Condiciones de Contorno
        botons_elements('off','off','off','off','off','on')
    end

    function botons_accions(bcrear,bmodificar,besborrar,bmoure,bapropar,ballunyar)
        % Esta funci�n determina la ejecuci�n de los botones de acci�n, que
        % son Crear, Modificar, Borrar, Alejar, Acercar, Mover. Cuando se
        % activa uno se desactivan los dem�s
        
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
        clicable % Determina sobre qu� objetos se puede hacer clic seg�n el estado de los botones de acci�n
    end
    function botons_elements(bnus,bbarra,bcarreganus,bcarregabarra,bcarregacarga,bapoyo)
        % Esta funci�n determina el estado de los botones que hacen
        % referencia a los elementos del programa que son: Nodo, L�nea de
        % Contorno, L�nea de �rea de Carga, Carga Puntual, Aplicar Carga
        % Repartida, Condiciones de Contorno. Cuando uno se activa, se
        % desactivan los dem�s.
        
        set(botobarranus,'State',bnus);
        set(botobarrabarra,'State',bbarra);
        set(botobarracarreganus,'State',bcarreganus);
        set(botobarracarregabarra,'State',bcarregabarra);
        set(botobarracarregacarga,'State',bcarregacarga);
        set(botobarraapoyo,'State',bapoyo);
        colors
        clicable % Determina sobre qu� objetos se puede hacer clic seg�n el estado de los botones de elementos
    end
    function clicable(hObject,eventdata,handles)
        % Modifica el estado de los objetos gr�ficos seg�n los botones
        % activados (por ejemplo, se muestran en rojo los elementos
        % borrables cuando el bot�n borrar est� activo. La funcion
        % determina qu� elementos gr�ficos pueden ser clicados en cada
        % momento seg�n el estado de los botones.
        
        if get(botoedicio,'Value')
            if strcmp(get(botobarracrear,'State'),'on') % Si el bot�n Crear est� activo
                if strcmp(get(botobarranus,'State'),'on') % Nodos: se clica directamente sobre la gr�fica
                    canviestat('off','off','off','off')
                elseif strcmp(get(botobarrabarra,'State'),'on') % L�nea de Contorno: se clica sobre los nodos
                    canviestat('on','off','off','off')
                elseif strcmp(get(botobarracarreganus,'State'),'on') % Carga Puntual: se clica sobre los nodos
                    canviestat('on','off','off','off')
                elseif strcmp(get(botobarracarregabarra,'State'),'on')% L�nea de �rea de Carga: se clica sobre los nodos
                    canviestat('on','off','off','off')
                elseif strcmp(get(botobarracarregacarga,'State'),'on')% Aplicar Carga Repartida: se clica sobre las l�neas
                    canviestat('off','on','off','off')
                elseif strcmp(get(botobarraapoyo,'State'),'on') % Condiciones de Contorno: se clica directamente sobre la gr�fica para seleccionar un �rea
                    canviestat('off','off','off','off')
                end
            elseif strcmp(get(botobarramodificar,'State'),'on') || strcmp(get(botobarraesborrar,'State'),'on') % Si el bot�n Modificar o Borrar est�n activos
                if strcmp(get(botobarranus,'State'),'on') % Nodos: se clica sobre los nodos
                    canviestat('on','off','off','off')
                elseif strcmp(get(botobarrabarra,'State'),'on') % L�nea de Contorno: se clica sobre las l�neas
                    canviestat('off','on','off','off')
                elseif strcmp(get(botobarracarreganus,'State'),'on') % Carga Puntual: se clica sobre los nodos y el texto
                    canviestat('off','off','on','off')
                elseif strcmp(get(botobarracarregabarra,'State'),'on') % L�nea de �rea de Carga: se clica sobre las l�neas
                    canviestat('off','on','off','off')
                elseif strcmp(get(botobarracarregacarga,'State'),'on') % Aplicar Carga Repartida: se clica sobre las l�neas y el texto
                    canviestat('off','on','off','on')
                elseif strcmp(get(botobarraapoyo,'State'),'on') % Condiciones de Contorno: se clica sobre los nodos
                    canviestat('on','off','off','off')
                end
            else
                canviestat('on','off','off','off') % Por defecto, que se pueda hacer clic sobre los nodos para moverlos
            end
        end
        if strcmp(get(botobarramoure,'State'),'on') % Cambia el cursor por una Mano si el bot�n Mover est� activo
            set(figcme2,'Pointer','hand')
        elseif strcmp(get(botobarraapropar,'State'),'on') || strcmp(get(botobarraallunyar,'State'),'on') % Cambia el cursor por un c�rculo si Acercar o Alejar est�n activos
            set(figcme2,'Pointer','circle')
        else
            set(figcme2,'Pointer','arrow')
        end
    end

    function canviestat(clicnus,clicbarra,cliccarreganus,cliccarregabarra)
        % Cambia el estado de los elementos gr�ficos y determina si se
        % puede o no hacer clic sobre ellos
        for j=1:contnus
            set(nusos(j).hg,'HitTest',clicnus) % Objetos de los nodos
            set(nusos(j).hgc,'HitTest',cliccarreganus) % Objetos de las cargas puntuales
        end
        for j=1:contbarra
            set(barres(j).hg,'HitTest',clicbarra) % Objetos de las l�neas
        end
        
        for j=1:contcargaunif
            set(cargasunif(j).hg,'HitTest',cliccarregabarra);
        end
    end

    function colornusos(hObject,eventdata,handles)
        % Actualiza el color de los nodos seg�n la situaci�n (negro normal,
        % azul modificar y rojo borrar
        
        % Si est� activado el bot�n nodo o condiciones de Contorno, y la Edici�n est� activa
        if (strcmp(get(botobarranus,'State'),'on') || strcmp(get(botobarraapoyo,'State'),'on')) && get(botoedicio,'Value') 
            if strcmp(get(botobarramodificar,'State'),'on') % Si Modificar est� activado
                color=colormodificar;
            elseif strcmp(get(botobarraesborrar,'State'),'on') % Si Borrar est� activado
                color=coloresborrar;
            else
                color='k'; % Color por defecto
            end
        else
            color='k'; % Color por defecto
        end
        for i=1:contnus
            chgcolor(nusos(i).hg,color); % Cambia el color del objeto gr�fico
        end
    end

    function colorbarres(hObject,eventdata,handles)
       % Actualiza el color de las l�neas seg�n la situaci�n y seg�n su
       % tipo (lineas de �rea de carga o de contorno. Negro: normal, rojo:
       % borrar, azul: modificar
        
            color1='k'; % Color por defecto de las l�neas de contorno
            color2='k'; % Color por defecto de las l�neas de area de carga
        
        % Si est� activado el bot�n L�nea de Contorno la Edici�n est� activa
        if strcmp(get(botobarrabarra,'State'),'on') && get(botoedicio,'Value') % bot�n L�nea de Contorno activo y boton Edici�n Activo
            
            if strcmp(get(botobarramodificar,'State'),'on') % si Modificar est� activo
                color1=colormodificar; 
            elseif strcmp(get(botobarraesborrar,'State'),'on') % si Borrar est� activo
                color1=coloresborrar; 
            else
                color1='k'; % Color por defecto
            end
        
        % Si est� activado el bot�n L�nea de �rea de carga y la Edici�n
        % est� activa
        elseif (strcmp(get(botobarracarregabarra,'State'),'on') || strcmp(get(botobarracarregacarga,'State'),'on')) && get(botoedicio,'Value')
            
            if strcmp(get(botobarramodificar,'State'),'on') % si Modificar est� activo
                color2=colormodificar; 
            elseif strcmp(get(botobarraesborrar,'State'),'on') % si Borrar est� activo
                color2=coloresborrar; 
            else
                color2='k'; % Color por defecto
            end       
        else
            color1='k'; % Color por defecto
            color2='k'; % Color por defecto
        end
            for i=1:contbarra
                if(barres(i).esCarga==0) %Asigna el color a las l�neas de contorno
                            if strcmp(color1,'k')
                        set(barres(i).hg,'color',barres(i).color);
                            else
                        set(barres(i).hg,'color',color1);
                            end
                else %Asigna el color a las l�neas de �rea de carga
                             if strcmp(color2,'k')
                        set(barres(i).hg,'color',barres(i).color);
                            else
                        set(barres(i).hg,'color',color2);
                            end
                end
            end
    end

    function colorcarreganusos(hObject,eventdata,handles)
        % Actualiza el color de las cargas sobre los nodos seg�n la
        % situaci�n

        if strcmp(get(botobarracarreganus,'State'),'on') && get(botoedicio,'Value') % Si el bot�n Nodo est� activo y est� en Modo Edicion.
            if strcmp(get(botobarramodificar,'State'),'on') % si Modificar est� activo.
                color=colormodificar; 
            elseif strcmp(get(botobarraesborrar,'State'),'on') % si Borrar est� activo
                color=coloresborrar;
            else
                color=colorcarregues;
            end
        else
            color='b'; %Color por defecto
        end
        
        %Cambia el color de los objetos gr�ficos de los nodos
        for i=1:contnus
            chgcolor(nusos(i).hgc,color)
        end
    end

    function colorcargasunif(hObject,eventdata,handles)
        % Actualiza el color de las cargas sobre los nodos seg�n la
        % situaci�n

        if strcmp(get(botobarracarregacarga,'State'),'on') && get(botoedicio,'Value') % Si el bot�n Nodo est� activo y est� en Modo Edicion.
            if strcmp(get(botobarramodificar,'State'),'on') % si Modificar est� activo.
                color=colormodificar; 
            elseif strcmp(get(botobarraesborrar,'State'),'on') % si Borrar est� activo
                color=coloresborrar;
            else
                color=colorcarregues;
            end
        else
            color='b'; %Color por defecto
        end
        
        %Cambia el color de los objetos gr�ficos de los nodos
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
        % Funci� que cambia el color de los objetos dentro del objeto
        % hgtransform
        
        set(findobj(h,'Type','line'),'color',color) % Color de las l�neas
        set(findobj(h,'Type','text'),'color',color) % Color de los textos
        set(findobj(h,'Type','patch'),'FaceColor',color,'EdgeColor',color) % Color de los patch
    end

%% PANEL 1: GR�FICO PRINCIPAL. CREACI�N Y ACCIONES
%El panel 1 es el panel principal del programa, que contiene el gr�fico en
%2D del plano XY donde se visualiza la placa y los cajetines inferiores que
%indican las coordenadas y la precisi�n

    function [panel1,logo,grafica_est,editx,edity,editprec]=creacio_panell_grafica
        % Creaci�n del panel y sus elementos
        panel1=uipanel(figcme2,'Units','pixels','Position',[5,5,tm-[bwidth+25,10]],'BorderType','etchedin','BorderWidth',1); % Creacio del panell.
        logo=axes('Parent',panel1,'Units','pixels','Position',[36,50,tm-[176,70]]); % Objecte axes on es carreguen els logos.
        imagesc(imread('logo.jpg'),'ButtonDownFcn',@clic_grafica_res); % Carrega dels logos.
        set(logo,'handlevisibility','off','Visible','off'); % S'oculten els marges i es fa inaccessible. Queda com a imatge de fons sense alterar al treballar amb l'estructura, ampliar, redu�r, moure, etc.
        grafica_est=axes('Parent',panel1,'Units','pixels','Position',[36,50,tm-[176,70]],'color','none','MinorGridLineStyle',':','ButtonDownFcn',@clic_ratoli,'NextPlot','add','XLim',XLimini,'YLim',YLimini,'Box','on'); % Pantalla de treball amb la gr�fica de l'estructura.
        uicontrol(panel1,'Units','pixels','Position',[36,5,15,20],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String','X:'); % Etiqueta.
        editx=uicontrol(panel1,'Units','pixels','Position',[51,5,50,20],'Style','edit','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','right','BackgroundColor','white','Enable','off'); % Caixa on s'indica o introueix la coordenada x.
        uicontrol(panel1,'Units','pixels','Position',[111,5,15,20],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String','Y:'); % Etiqueta.
        edity=uicontrol(panel1,'Units','pixels','Position',[126,5,50,20],'Style','edit','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','right','BackgroundColor','white','Enable','off'); % Caixa on s'indica o introdueix la coordenada y.
        uicontrol(panel1,'Units','pixels','Position',[200,5,65,20],'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','left','String','Precisi�n:'); % Etiqueta.
        editprec=uicontrol(panel1,'Units','pixels','Position',[270,5,50,20],'Style','edit','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','right','BackgroundColor','white','String',num2str(precini));  % Caixa on s'introdueix la precisi� a l'introdu�r punts amb el ratol�.
        grafica=grafica_est;
    end

   function clic_ratoli(hObject,eventdata,handles)
        % Se ejecuta cuando se hace clic sobre el gr�fico. Anteriormente se
        % ejecuta clic_figure, que determina mediante flagclic qu� bot�n
        % del rat�n se pulsa

        % Si se pulsa el bot�n izquierdo, con el boton Nodo activo, y la
        % edici�n Activa, se crea un nodo
        if flagclic==1 &&get(botoedicio,'Value') && strcmp(get(botobarracrear,'State'),'on') && strcmp(get(botobarranus,'State'),'on') && ~strcmp(vista,'3d')
            crearnus
            
        % Si Acercar o Alejar est�n activos, se aplica el factor de zoom
        elseif (flagclic==1 && strcmp(get(botobarraapropar,'State'),'on')) || (flagclic==3 && strcmp(get(botobarraallunyar,'State'),'on'))
            zom(-3/factorzoom);
        elseif (flagclic==1 && strcmp(get(botobarraallunyar,'State'),'on')) || (flagclic==3 && strcmp(get(botobarraapropar,'State'),'on'))
            zom(3/factorzoom);
        
        % Si se pulsa el bot�n izquierdo, con el boton Condiciones de Contorno activo, y la
        % edici�n Activa, se selecciona un rect�ngulo (l�neas discont�nuas,
        % al que se le aplicar�n las condiciones de contorno que determine
        % el usuario
        elseif (flagclic==1 && strcmp(get(botobarracrear,'State'),'on')) && strcmp(get(botobarraapoyo,'State'),'on')
            seleccionarCondCont();
        end
   end

    function clic_nus(gcbo,eventdata,handles)
        % Se ejecuta cuando se hace clic sobre un nodo. en el campo
        % 'UserData' del objeto gr�fico hay el n�mero del nodo, que permite
        % identificarlo. Dependiendo de qu� bot�n est� activo en la barra
        % de herramientas, se ejecuta una acci�n u otra

        n=get(gcbo,'UserData'); % N�mero de nodo
        if flagclic==1 && get(botoedicio,'Value') % Si se ha pulsado el bot�n izquierdo y la Edici�n est� activa
            if strcmp(get(botobarraesborrar,'State'),'on') && strcmp(get(botobarranus,'State'),'on')
                esborrarnus(n) 
            elseif strcmp(get(botobarramodificar,'State'),'on') && strcmp(get(botobarranus,'State'),'on')
                modificarnus(n)
            elseif strcmp(get(botobarracrear,'State'),'on') && strcmp(get(botobarrabarra,'State'),'on')
                crearbarra(n,0)
            elseif strcmp(get(botobarracrear,'State'),'on') && strcmp(get(botobarracarregabarra,'State'),'on')
                aux=contbarra;
                crearbarra(n,1)
                % Si se ha creado una nueva l�nea, se le asigna el color
                % verde y esCarga=1 para determinar que es una l�nea de
                % �rea de carga
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
        elseif flagclic==3 && ~flagbarra && get(botoedicio,'Value') % Si se ha pulsado el bot�n derecho se mueve el nodo
            flagmourenus=n; % Activa el flag que indica que se modifique la posici�n del nodo con el movimiento del rat�n
        end
    end
    
    function clic_cargaunif(gcbo,eventdata,handles)
        % Se ejecuta cuando se hace clic sobre una carga repartida. en el campo
        % 'UserData' del objeto gr�fico hay el n�mero de la carga repartida, que permite
        % identificarla. Dependiendo de qu� bot�n est� activo en la barra
        % de herramientas, se ejecuta una acci�n u otra
        
        fprintf('ejecutadooooo\n');
        n=get(gcbo,'UserData'); % N�mero de nodo
        if flagclic==1 && get(botoedicio,'Value') && strcmp(get(botobarracarregacarga,'State'),'on')% Si se ha pulsado el bot�n izquierdo y la Edici�n est� activa
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
        % 'UserData' del objeto gr�fico hay el n�mero del nodo, que permite
        % identificarlo. Dependiendo de qu� bot�n est� activo en la barra
        % de herramientas, se ejecuta una acci�n u otra
        
        n=get(gcbo,'UserData'); % N�mero de nodo
        if flagclic==1 && get(botoedicio,'Value') && strcmp(get(botobarracarreganus,'State'),'on')% Si se ha pulsado el bot�n izquierdo y la Edici�n est� activa
            fprintf('executat\n');
            if strcmp(get(botobarraesborrar,'State'),'on') 
                esborrarcarreganus(n)
            elseif strcmp(get(botobarramodificar,'State'),'on')
                crearmodificarcarreganus(n)
            end
        end
    end

    function clic_barra(gcbo,eventdata,handles)
        % Se ejecuta cuando se hace clic sobre una l�nea. en el campo
        % 'UserData' del objeto gr�fico hay el n�mero de la l�nea, que permite
        % identificarla. Dependiendo de qu� bot�n est� activo en la barra
        % de herramientas, se ejecuta una acci�n u otra
        
        n=get(gcbo,'UserData'); % N�mero de barra.
        
        if flagclic==1 && get(botoedicio,'Value') % Si se ha pulsado el bot�n izquierdo y la Edici�n est� activa
            % Si es una L�nea de Contorno
            if(barres(n).esCarga==0)
                if strcmp(get(botobarraesborrar,'State'),'on') && strcmp(get(botobarrabarra,'State'),'on')
                    esborrarbarra(n)
                    redibuixar_nusos
                    escalar_nusos               
                end
            % Si es una L�nea de �rea de Carga     
            elseif (barres(n).esCarga==1)
                % Si el bot�n Linea de �rea de Carga est� activo, se act�a
                % sobre la l�nea
                if strcmp(get(botobarraesborrar,'State'),'on') && strcmp(get(botobarracarregabarra,'State'),'on')
                    esborrarbarra(n)
                    redibuixar_nusos
                    escalar_nusos
                % Si el bot�n Aplicar Carga Repartida est� activo, se act�a
                % sobre la carga aplicada sobre las l�neas, si existe
                elseif strcmp(get(botobarramodificar,'State'),'on') && strcmp(get(botobarracarregacarga,'State'),'on')
                    crearmodificarcargaunif(n)
                elseif strcmp(get(botobarracrear,'State'),'on') && strcmp(get(botobarracarregacarga,'State'),'on')
                    crearmodificarcargaunif(n)
                elseif strcmp(get(botobarraesborrar,'State'),'on') && strcmp(get(botobarracarregacarga,'State'),'on')
                    %Se borran las cargas repartidas de las que la l�nea
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

%% PANEL 1.1 RESULTADOS: CREACI�N Y ACCIONES
% El panel resultados es el padre de todos los paneles que incluyen los
% gr�ficos 3D de representaci�n de resultados del programa

    function visibilidad_resultados()
        %Esta funci�n determina la visibilidad de los gr�ficos 3D. Los
        %gr�ficos se ven s�lo cuando el boton 3D color est� activo, y s�lo
        %se mostrar� en cada momento el gr�fico correspondiente al bot�n
        %que est� activo en el panel lateral Mostrar
        
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
        
        % Se activa la rotaci�n en 3 dimensiones con el rat�n para el
        % gr�fico 3D activo
        rotate3d on
    end

    function [resultados]=panel_resultados
        % Creaci�n del panel resultados, que es el padre de todos los
        % paneles que incluyen los gr�ficos 3d. Invisible por defecto
        % inicialmente
        
        resultados=uipanel(figcme2,'Units','pixels','Position',[5,5,tm-[bwidth+25,10]],'BorderType','none'); % Creacio del panell.
        set(resultados,'Visible','off');      
    end

    function [resultados_flecha,grafico_flecha]=panel_resultados_flecha
        % Creaci�n del panel que incluye el gr�fico 3d de flecha. Invisible
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
        % Creaci�n del panel que incluye el gr�fico 3d de giro X. Invisible
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
        % Creaci�n del panel que incluye el gr�fico 3d de giro Y. Invisible
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
        % Creaci�n del panel que incluye el gr�fico 3d de Mx. Invisible
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
        % Creaci�n del panel que incluye el gr�fico 3d de My. Invisible
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
        % Creaci�n del panel que incluye el gr�fico 3d de Mxy. Invisible
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

%% PANEL 2: VISTA. CREACI�N Y ACCIONES
% El panel vista controla la edici�n y el modo de vista del programa
% (gr�ficos 3d en la presentaci�n de resultados, o el plano XY donde se
% editan los datos)

    function [panel2,botoedicio,botoxy,boto3d]=panell_botons_vista
        % Creaci� del panell amb els botons.
        panel2=uipanel(figcme2,'Units','pixels','Position',[tm-[bwidth+15,190],bwidth+15,(bheight+5)*5+20],'BorderType','etchedin','BorderWidth',1,'FontName','default','FontUnits','pixels','FontSize',14,'Title','Vista:'); % Creacio del panell.
        botoedicio=uicontrol(panel2,'Units','pixels','Position',bpos(5),'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Edici�n','Value',1,'Callback',@edicio,'KeyPressFcn',@tecla); % Creaci� bot� edici�.
        botoreixeta=uicontrol(panel2,'Units','pixels','Position',bpos(4),'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Rejilla','Callback',@reixeta,'KeyPressFcn',@tecla); % Creaci� boto reixeta.
        botocentrar=uicontrol(panel2,'Units','pixels','Position',bpos(3),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Centrar','Callback',@centrar,'KeyPressFcn',@tecla); % Creaci� bot� centrar.
        botoxy=uicontrol(panel2,'Units','pixels','Position',bpos(1)+[0,0,-(bwidth-(bwidth)/2),0],'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Plano XY','Callback',@vistaxy,'Value',1,'KeyPressFcn',@tecla); % Creaci� bot� vista XY.
        boto3d=uicontrol(panel2,'Units','pixels','Position',bpos(1)+[(bwidth)/2,0,-(bwidth-(bwidth)/2),0],'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','3D Color','Callback',@vista3d,'KeyPressFcn',@tecla); % Creaci� vista 3D.
        uicontrol(panel2,'Units','pixels','Position',bpos(2),'Style','text','FontName','default','FontUnits','pixels','FontSize',14,'HorizontalAlignment','center','String','Representaci�n:'); % Etiqueta.
    end

    function edicio(hObject,eventdata,handles)
        % Activa/Desactiva la edici�n
        
        updatebotons(); % Determina el estado de los botones seg�n el desarrollo del programa
        clicable % Determina sobre qu� objetos se puede hacer clic
        colors
    end

    function updatebotons()
        % Esta funci�n determina qu� botones est�n activos o inactivos
        % dependiendo de en que punto se encuentra el programa. De esta
        % forma se impide que el usuario pueda cometer errores por acceder
        % a funcionalidades a las que no deber�a en ciertos momentos.
        
        % La flag de cada bot�n determina si ya se ha usado o no. Por
        % ejemplo, una vez introducido el contorno, ya no puede volver a
        % introducirse en los c�lculos
        
        if (flagbMalla==0) 
            %Antes que se haya calculado la malla. Los botones de la barra
            %de herramientas est�n activos, menos las condiciones de
            %contorno. Los botones de Introducci�n de c�lculos previos a la
            %malla tambi�n est�n activos
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
            %Despu�s de la malla se cancela la introducci�n de datos y se
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
            %bot�n de obtener desplazamientos y se desactiva toda la
            %edici�n
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
            %del panel lateral mostrar, para activar la presentaci�n de
            %resultados
            if flagbCalcDesp==1
                set(botoCalcDesp,'Enable','off');
                set(botoObtDesp,'Enable','on');
                set(get(panel3,'Children'),'Enable','on');
                set(botoedicio,'Value',0);
                set(botoedicio,'Enable','off');
            end
                
        end
        
        %Cuando el bot�n edici�n est� inactivo, se desactivan los botones
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
        % Centra la estructura en el gr�fico y calcula los l�mites
        
        if grafica==grafica_est
            calcul_cord_extrems % C�lculo de las coordenadas extremas
            tam=get(grafica_est,'Position'); % Posici� i tamany de la grafica. Valors de tamany horitzontal en tam(3), i en Vertical en tam(4).            
            switch vista
                case 'xy'
                    if (xmax-xmin)*tam(4)/tam(3)<(ymax-ymin) % Si la relaci�n altura/anchura de la estructura es mayor que la de la gr�fica
                        ampx=(ymax-ymin)*tam(3)/tam(4); % Anchura en funci�n de la altura
                        ampy=(ymax-ymin);
                        XL=[xmed-ampx/1.5,xmed+ampx/1.5];
                        YL=[ymed-ampy/1.5,ymed+ampy/1.5];
                    elseif xmax==xmin && ymax==ymin
                        XL=XLimini+[xmed,xmed];
                        YL=XLimini*tam(4)/tam(3)+[ymed,ymed];
                    else % Si la relaci�n altura/anchura de la estructura es menor que la de la gr�fica
                        ampx=(xmax-xmin);
                        ampy=(xmax-xmin)*tam(4)/tam(3); % Altura en funci�n de la anchura
                        XL=[xmed-ampx/1.5,xmed+ampx/1.5];
                        YL=[ymed-ampy/1.5,ymed+ampy/1.5];
                    end
                    set(grafica_est,'XLim',XL,'YLim',YL,'ZLim',ZLimini); % Asigna los valores a los ejes de la gr�fica
            end
            escala % Calcula el factor de escala s
            escalar_nusos % Reescala los nodos y sus cargas
            clicable % Establece sobre qu� objetos se puede hacer clic
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
            for i=2:contnus % si hay m�s de 1 nodo
                xmin=min(xmin,nusos(i).posicio(1)); % x m�nima
                xmax=max(xmax,nusos(i).posicio(1)); % x m�xima
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
            %Se activa la edici�n, se desactiva el bot�n 3D, se quita la
            %visibilidad de los gr�ficos 3D
            
            vista='xy'; % Variable que controla la vista
            set(boto3d,'Value',0);
            set(grafica_est,'View',[0,90],'Box','on'); % Vista del pl�nol XY.
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
%         % Se ejecuta cuando se selecciona la el bot�n 3D COLOR   

        if get(hObject,'Value') && grafica==grafica_est
            %Se desactiva la edici�n, se desactiva el bot�n Plano XY, se
            %muestran los gr�ficos 3D, se desactiva la visibilidad del
            %gr�fico de edici�n principal
            
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

%% PANEL 3: MOSTRAR. CREACI�N Y ACCIONES
% El panel mostrar contiene los botones que controlan qu� resultados se
% muestran en cada momento

    function [panel3,botonumnodos,botoflecha,botogirox,botogiroy,botoMx,botoMy,botoMxy,botoObtDesp]=panell_botons_grafica
        % Creaci�n del panel y los botones

        panel3=uipanel(figcme2,'Units','pixels','Position',[tm-[bwidth+15,500],bwidth+15,(bheight+5)*3+20],'BorderType','etchedin','BorderWidth',1,'FontName','default','FontUnits','pixels','FontSize',14,'Title','Mostrar:'); % Creacio del panell.
        botonumnodos=uicontrol(panel3,'Units','pixels','Position',bpos(5),'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','N�m. Nodo','Enable','on','Callback',@numnodos,'Value',1,'KeyPressFcn',@tecla); % Creacio bot� vista de c�rregues.
        botoflecha=uicontrol(panel3,'Units','pixels','Position',bpos(4),'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Desplazamiento','Enable','on','Callback',@flecha,'Value',0,'KeyPressFcn',@tecla); % Creacio bot� vista de reaccions.
        botogirox=uicontrol(panel3,'Units','pixels','Position',bpos(3)+[0,0,-(bwidth-(bwidth-5)/2),0],'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Giro X','Enable','on','Callback',@girox,'Value',0,'KeyPressFcn',@tecla); % Creacio bot� vista de diagrama d'axils.
        botogiroy=uicontrol(panel3,'Units','pixels','Position',bpos(3)+[(bwidth-5)/2+5,0,-(bwidth-(bwidth-5)/2),0],'Style','togglebutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Giro Y','Enable','on','Callback',@giroy,'Value',0,'KeyPressFcn',@tecla); % Creacio bot� vista de diagrama de moments en x.
        botoMx=uicontrol(panel3,'Units','pixels','Position',bpos(2)+[0,0,-(bwidth-(bwidth-5)/3),0],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Mx','Callback',@Mx,'KeyPressFcn',@tecla);
        botoMy=uicontrol(panel3,'Units','pixels','Position',bpos(2)+[(bwidth-10)/3+5,0,-(bwidth-(bwidth-5)/3),0],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','My','Callback',@My,'KeyPressFcn',@tecla);
        botoMxy=uicontrol(panel3,'Units','pixels','Position',bpos(2)+[(bwidth-10)/3*2+10,0,-(bwidth-(bwidth-5)/3),0],'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Mxy','Callback',@Mxy,'KeyPressFcn',@tecla);
        botoObtDesp=uicontrol(panel3,'Units','pixels','Position',bpos(1),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','Desp. Punto','Callback',@obtDesp,'KeyPressFcn',@tecla);
        end

    function numnodos(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Numero de Nodo
        botons_mostrar(1,0,0,0,0,0,0);
    end

    function flecha(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Flecha
        botons_mostrar(0,1,0,0,0,0,0);
    end

    function girox(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Giro X
        botons_mostrar(0,0,1,0,0,0,0);
    end

    function giroy(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Giro Y
        botons_mostrar(0,0,0,1,0,0,0);
    end

    function Mx(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Mx
        botons_mostrar(0,0,0,0,1,0,0);
    end

    function My(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n My
        botons_mostrar(0,0,0,0,0,1,0);
    end

    function Mxy(hObject,eventdata,handles)
        % Se ejecuta cuando se activa el bot�n Mxy
        botons_mostrar(0,0,0,0,0,0,1);
    end
   
    function botons_mostrar(numnodos,flecha,girox,giroy,Mx,My,Mxy)
        %Determina el estado de los botones del panel lateral Mostrar.
        %Cuando se activa uno se desactivan los dem�s
        set(botonumnodos,'Value',numnodos);
        set(botoflecha,'Value',flecha);
        set(botogirox,'Value',girox);
        set(botogiroy,'Value',giroy);
        set(botoMx,'Value',Mx);
        set(botoMy,'Value',My);
        set(botoMxy,'Value',Mxy);
        
        %Actualiza la visualizaci�n de resultados, sea en el plano XY o en
        %los gr�ficos 3D, para que se muestren los correspondientes al
        %bot�n seleccionado
        redibuixar_textnusos;
        visibilidad_resultados;
    end

    function obtDesp(hObject,eventdata,handles)
    %El bot�n obtener desplazamientos del panel Mostrar muestra una caja de
    %di�logo y pide al usuario que entre las coordenadas. Si las
    %coordenadas pertenecen a la placa, solicita los desplazamientos y
    %momentos del punto al programa de c�lculo. Si no pertenece a la placa,
    %se muestra un error por pantalla y se pide al usuario que lo intente
    %otra vez
    
        %la variable err comprueba si los datos entrados son v�lidos
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
            h=errordlg('Coordenadas no v�lidas. Reintentar', 'Obtener desplazamiento');

        elseif(err==-1)
        end
            
    end

%% PANEL 4: INTRODUCIR C�LCULOS. CREACI�N Y ACCIONES DEL PANEL
% El panel lateral introducir c�lculos act�a de interfaz entre la interfaz
% gr�fica y el programa de c�lculo. Sus botones introducen informaci�n en
% el programa de c�lculo y obtienen los resultados

    function [panel4,botoCargaPunt,botoContorn,botoMaterial,botoMalla,botoReset,botoCargaUnif,botoCondCont,botoCalcDesp,flagbCon,flagbMat,flagbMalla,flagbCp,flagbCu,distnumnusmalla,flagbCc,flagbCalcDesp]=panel_calculo
        % Creaci�n del panel y los botones
        panel4=uipanel(figcme2,'Units','pixels','Position',[tm-[bwidth+15,400],bwidth+10,(bheight+5)*6+20],'BorderType','etchedin','BorderWidth',1,'FontName','default','FontUnits','pixels','FontSize',14,'Title','Introducir C�lculos:'); % Creacio del panell.
        botoReset=uicontrol(panel4,'Units','pixels','Position',bpos(8),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','RESET','Callback',@reset,'KeyPressFcn',@tecla);        
        botoMaterial=uicontrol(panel4,'Units','pixels','Position',bpos(7),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','1. MATERIAL','Callback',@material,'KeyPressFcn',@tecla);
        botoContorn=uicontrol(panel4,'Units','pixels','Position',bpos(6),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','2. CONTORNO','Callback',@contorn,'KeyPressFcn',@tecla);
        botoCargaPunt=uicontrol(panel4,'Units','pixels','Position',bpos(5),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','3. CARGAS PUNT','Callback',@cargaPunt,'KeyPressFcn',@tecla);
        botoCargaUnif=uicontrol(panel4,'Units','pixels','Position',bpos(4),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','4. CARGAS UNIF','Callback',@cargaUnif,'KeyPressFcn',@tecla);
        botoMalla=uicontrol(panel4,'Units','pixels','Position',bpos(3),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','5. MALLAR','Callback',@malla,'KeyPressFcn',@tecla);
        botoCondCont=uicontrol(panel4,'Units','pixels','Position',bpos(2),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','6. COND. CONTORNO','Callback',@condCont,'KeyPressFcn',@tecla);
        botoCalcDesp=uicontrol(panel4,'Units','pixels','Position',bpos(1),'Style','pushbutton','FontName','default','FontUnits','pixels','FontSize',14,'String','7. CALCULAR DESPL.','Callback',@calcDesp,'KeyPressFcn',@tecla);
        
        %Las flags de cada bot�n determinan si se han usado o no, ya que
        %cada bot�n de �ste panel se usa una sola vez y luego se desactiva
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
        %Calcula m�s f�cilmente la posici�n en p�xeles x,y de cada bot�n
        %seg�n su numeraci�n
        
        pos=[5,5+(n-1)*(bheight+5),bwidth,bheight];
    end

    %BOT�N RESET
    function reset(hObject,eventdata,handles)
        % Se pregunta al usuario si est� Seguro. Luego se eliminan todos
        % los objetos, nodos, l�neas y objetos gr�ficos y se reinicia el
        % programa de c�lculo, para empezar de nuevo. Se reinician tambi�n
        % los gr�ficos
        
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
                
                [resultados_flecha,grafico_flecha]=panel_resultados_flecha; %Crea el panel con el gr�fico 3d de resultados de flecha
                [resultados_girox,grafico_girox]=panel_resultados_girox;    %Crea el panel con el gr�fico 3d de resultados de giro X
                [resultados_giroy,grafico_giroy]=panel_resultados_giroy;    %Crea el panel con el gr�fico 3d de resultados de giro Y
                [resultados_Mx,grafico_Mx]=panel_resultados_Mx;             %Crea el panel con el gr�fico 3d de resultados de Momento X
                [resultados_My,grafico_My]=panel_resultados_My;             %Crea el panel con el gr�fico 3d de resultados de Momento Y
                [resultados_Mxy,grafico_Mxy]=panel_resultados_Mxy;          %Crea el panel con el gr�fico 3d de resultados de Momento XY
                
                figcme2_resize;

                updatebotons();
                thbarra=2;
                close(h); 
        end
    end

    %BOT�N MATERIAL
    function material(hObject,eventdata,handles)
       % Se muestra una caja de di�logo donde el usuario introduce los
       % par�metros materiales de la placa: Espesor, M�dulo de Elasticidad
       % y de Poisson y densidad. Se comprueba que los datos sean v�lidos
       % con la variable err y se introducen en el programa de c�lculo. Si
       % hay alg�n error se muestra y se indica al usuario que lo vuelva a
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
                h = errordlg('Par�metros no v�lidos o incompletos. Reintroducir datos.','Par�metros no v�lidos');
            elseif (err==2)
                h = errordlg('El Coeficiente de Poisson debe estar entre -1 y 0.5','Coeficiente de Poisson no v�lido');
            elseif (err==3)
                h = errordlg('La densidad debe tener un valor positivo','Densidad no v�lida');
            elseif (err==4)
                h = errordlg('El espesor debe tener un valor positivo','Espesor no v�lido');    
            end
    end

    %BOT�N CONTORNO
    function contorn(hObject,eventdata,handles)
     %Cuando se pulsa el bot�n lateral Contorno, se comprueba que las
     %l�neas de contorno forman contornos cerrados y se introducen todos
     %(el contorno de la placa y sus agujeros) en el programa de c�lculo.
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
           str=sprintf('Se han a�adido %d contornos a los c�lculos',length(contorno));
           h = msgbox(str,'Contorno creado');
           flagbCon=1;
           updatebotons();
       else
          h = errordlg('El contorno no es cerrado. Revisar el contorno','Contorno no cerrado');
       end
    end

    %BOT�N CARGA PUNTUAL
    function cargaPunt(hObject,eventdata,handles)
     % Cuando se pulsa el bot�n lateral Carga puntual, se a�aden todas las
     % cargas puntuales dibujadas en el programa de c�lculo. Si no hay
     % cargas, se pregunta al usuario si quiere continuar de todas formas.
     % finalmente se actualizan los botones y la flag del bot�n
     
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
              resp=questdlg('No hay cargas puntuales que a�adir. Continuar de todas formas?','Cargas Puntuales','Si','No','Cancelar','Si');
              switch resp
                  case 'Si'
                  continuar=1;
              end
       else
              continuar=1;
       end
       
       if continuar==1
           string=sprintf('Se han a�adido %d cargas repartidas a los c�lculos',added);
       h = msgbox(string,'Cargas Puntuales a�adidas');
       
       flagbCp=1;
       updatebotons();
       end
    end

    %BOT�N CARGA UNIFORME
    function cargaUnif(hObject,eventdata,handles)
     % Cuando se pulsa el bot�n lateral Carga Uniforme, se a�aden todas las
     % cargas puntuales dibujadas en el programa de c�lculo. Si no hay
     % cargas, se pregunta al usuario si quiere continuar de todas formas.
     % finalmente se actualizan los botones y la flag del bot�n
     
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
              resp=questdlg('No hay cargas repartidas que a�adir. Continuar de todas formas?','Cargas Repartidas','Si','No','Cancelar','Si');
              switch resp
                  case 'Si'
                  continuar=1;
              end
       else
              continuar=1;
       end
       
       if continuar==1
           string=sprintf('Se han a�adido %d cargas repartidas a los c�lculos',added);
       h = msgbox(string,'Cargas Repartidas a�adidas');
       flagbCu=1;
       updatebotons();
       end
    end

    %BOT�N MALLA
    function malla(hObject,eventdata,handles)
     % Cuando se pulsa el bot�n lateral Mallar, se comprueba si se han
     % introducido cargas y en caso negativo se advierte al usuario. Luego
     % se llama al m�todo mallador del programa de c�lculo y se obtiene la
     % lista de nodos y elementos. Se redibuja la placa con la nueva
     % configuraci�n de nodos y l�neas
     
          continuar=0;
          if (flagbCp==0 && flagbCu==0)
              %Si no se han introducido cargas, se advierte al usuario
              resp=questdlg('No se han a�adido cargas. Continuar de todas formas?','Mallar','Si','No','Cancelar','Si');
              switch resp
                  case 'Si'
                  continuar=1;
              end
          else
              continuar=1;
          end
          if continuar==1
              %La caja de di�logo permite determinar el tama�o m�ximo de
              %elemento y si se considerar� o no el peso propio
              
              [pesopropio,meshsize,err]=dlgmalla();
              if (err==0)
                  flagbMalla=1;
                  h= waitbar(0.05,sprintf('Calculando Malla...'));
                  %Se calcula la malla con el programa de c�lculo y se
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
                  fprintf('n�mero de nodos: %d\n',size(pp,1));
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
                  fprintf('n�mero de elementos: %d\n',size(tt,1));
                  h= waitbar(0.60,sprintf('Dibujando %d elementos...',size(tt,1)));
                  for i=1:size(tt,1)
                      novabarraNoDraw(tt(i,1),tt(i,2),0);
                      novabarraNoDraw(tt(i,2),tt(i,3),0);
                      novabarraNoDraw(tt(i,3),tt(i,1),0);
                      waitbar(0.60+0.40*i/(size(tt,1)));
                  end
                  redibuixar_barres % Dibuixa la barra.
%                   colorbarres
                  clicable % Estableix quins objectes gr�fics responen als clics segons l'estat dels botons de la barra d'eines.
                  close(h)
                  botons_elements('off','off','off','off','off','on');
                  updatebotons();

                  elseif(err==1)
                  h=errordlg('El tama�o m�ximo de elemento introducido no �s v�lido. Reintentar','Tama�o de elemento no v�lido');
                  elseif(err==2)
                  h=errordlg('El tama�o m�ximo de elemento debe ser positivo. Reintentar','Tama�o de elemento no v�lido');    
                  elseif(err==-1)
              end
          end
    end 

    %BOT�N CONDICIONES DE CONTORNO
    function condCont(hObject,eventdata,handles)
       %Se introducen todas las condiciones de contorno en el programa de
       %c�lculo. Si no hay condiciones de contorno que a�adir, se pide al
       %usuario que a�ada alguna y pruebe de nuevo. finalmente se
       %actualizan los botones y se actualiza la flag del bot�n
       
       added=0;
       for i=1:contnus
           if (~strcmp(nusos(i).contorn,'libre'))
               calculo.addCondCont(i,nusos(i).contorn);
               added=added+1;
           end
       end
       if (added==0)
           h=errordlg('No hay condiciones de contorno que a�adir. Revisar dibujo', 'Condiciones de Contorno');
       else
           string=sprintf('Se han a�adido %d condiciones de contorno a los c�lculos',added);
       h = msgbox(string,'Condiciones de Contorno a�adidas');
       flagbCc=1;
       updatebotons();
       end
    end

    %BOT�N CALCULAR DESPLAZAMIENTOS
    function calcDesp(hObject,eventdata,handles)
        %Se calculan los desplazamientos con el programa de calculo, se
        %actualiza la flag del bot�n y se asignan los desplazamientos y
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
                % para su representaci�n en 3D
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

%% CREACI�N Y MODIFICACI�N DIN�MICA DE NODOS
% Funciones relacionadas con la creaci�n, modificaci�n, eliminaci�n y
% dibujo de nodos

    function crearnus(pos)
        % Crea y dibuja un nuevo nodo
        
        if nargin>0
            %Si se determina una posici�n se a�ade en esta posici�n, si no
            %se lee el estado actual del rat�n
            posicio=[pos(1),pos(2),0];
        else
        posicio=[str2double(get(editx,'String')),str2double(get(edity,'String')),0]; % Coordenadas de las cajas de texto
        end
        contnus=contnus+1; % Aumenta el total de nodos
        nusos(contnus)=nus; % Nuevo objetos nus
        nusos(contnus).num=contnus; % Se a�ade el objeto a la �ltima posici�n del vector de nodos
        nusos(contnus).posicio=posicio; %posici�n actual
        nusos(contnus).contorn='libre'; %condici�n de contorno libre por defecto
        nusos(contnus).desp=[0;0;0]; %Se inicializan los desplazamientos
        nusos(contnus).moment=[0;0;0]; %Se inicializan los momentos
        calcul_cord_extrems % Recalcula las coordenadas m�ximas
        redibuixar_nusos % Redibuja los nodos
        escala % Calcula el factor de escala
        escalar_nusos % Reescala nodos y cargas
    end

    function crearnusNoDraw(pos)
        % Crea un nuevo nodo sin redibujar los nodos (aumenta en gran
        % medida el rendimiento cuando hay que crear muchos nodos
        
        if nargin>0
            %Si se determina una posici�n se a�ade en esta posici�n, sin�
            %se lee el estado actual del rat�n
            posicio=[pos(1),pos(2),0];
        else
        posicio=[str2double(get(editx,'String')),str2double(get(edity,'String')),0]; % Coordenadas de las cajas de texto
        end
        contnus=contnus+1; % Aumenta el total de nodos
        nusos(contnus)=nus; % Nuevo objetos nus
        nusos(contnus).num=contnus; % Se a�ade el objeto a la �ltima posici�n del vector de nodos
        nusos(contnus).posicio=posicio; %posici�n actual
        nusos(contnus).contorn='libre'; %condici�n de contorno libre por defecto
        nusos(contnus).desp=[0;0;0]; %Se inicializan los desplazamientos
        nusos(contnus).moment=[0;0;0]; %Se inicializan los momentos
        calcul_cord_extrems % Recalcula las coordenadas m�ximas        
    end

    function esborrarnus(n)
        % Elimina un nodo y su representaci�n, as� como las l�neas que
        % est�n conectadas a �l

        esborrarcarreganus(n) % elimina la carga en el nodo
        if contbarra>0 % Si hay barras definidas
            for i=contbarra:-1:1
                if barres(i).nusinf==n || barres(i).nussup==n % Si un extremo est� conectado al nodo
                    esborrarbarra(i)
                end
            end
        end
        delete(nusos(n).hg) %Destruye el objeto gr�fico
        nusos2=nus; % Nueva lista de nodos, donde se quita el nodo borrado
        if n>1 
            nusos2(1:n-1)=nusos(1:n-1); 
        end
        if n<contnus
            nusos2(n:contnus-1)=nusos(n+1:contnus);
            for i=n:contnus-1
                %Actualiza la numeraci�n
                nusos2(i).num=i; 
                set(nusos2(i).hg,'UserData',i);
                set(findobj(nusos2(i).hg,'Type','text'),'String',num2str(i));
            end
        end
        nusos=nusos2; % La nueva lista se convierte en la definitiva
        contnus=contnus-1; % actualiza el contador de nodos

        if contbarra>0 % Si hay l�neas definidas, se actualiza la numeraci�n de los nodos de las l�neas
            for i=1:contbarra
                if barres(i).nusinf>n 
                    barres(i).nusinf=barres(i).nusinf-1; 
                end
                if barres(i).nussup>n 
                    barres(i).nussup=barres(i).nussup-1;
                end
            end
        end
        
        if contcargaunif>0 % Si hay cargas repartidas definidas, actualiza el n�mero de los nodos
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
        % Elimina un nodo y su representaci�n, as� como las l�neas que
        % est�n conectadas a �l, sin redibujarlo todo (aumenta en gran
        % medida el rendimiento cuando hay que eliminar grandes cantidades
        % de nodos
        
        esborrarcarreganus(n)  % elimina la carga en el nodo
        if contbarra>0 % Si hay barras definidas..
            for i=contbarra:-1:1 
                if barres(i).nusinf==n || barres(i).nussup==n % Si un extremo est� conectado al nodo
                    esborrarbarraNoDraw(i)
                end
            end
        end
        delete(nusos(n).hg) %Destruye el objeto gr�fico
        nusos2=nus; % Nueva lista de nodos, donde se quita el nodo borrado
        if n>1 
            nusos2(1:n-1)=nusos(1:n-1); % Copia els nusos anterios a la nova llista.
        end
        if n<contnus
            nusos2(n:contnus-1)=nusos(n+1:contnus);
            for i=n:contnus-1
                %Actualiza la numeraci�n
                nusos2(i).num=i; 
                set(nusos2(i).hg,'UserData',i); 
                set(findobj(nusos2(i).hg,'Type','text'),'String',num2str(i));
            end
        end
        nusos=nusos2; % La nueva lista se convierte en la definitiva
        contnus=contnus-1; % actualiza el contador de nodos

        if contbarra>0 % Si hay cargas repartidas definidas, actualiza el n�mero de los nodos
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
        
        [nus,err]=dlgnus(nusos(n)); % Caja de di�logo de edici�n del nodo
        if (err==0)
            nusos(n)=nus;
        elseif(err==1)
            h=errordlg('Valores introducidos no v�lidos. Reintentar.','Valores no v�lidos'); 
        end
        calcul_cord_extrems % Recalcula los extremos de las coordenadas
        escala % Calcula el factor de escala s
        redibuixar_nusos % Redibuja los nodos
        redibuixar_barres % Redibuja las l�neas
        escalar_nusos % Adecua l'escala.
        clicable % Actualiza los objetos clicables
    end

    function redibuixar_nus(n)
        % Dibuja el nodo y elimina el dibujo anterior. Determina tambi�n la
        % posici�n relativa y la orientaci�n
        
        con=[]; % Lista con los �ngulos de las l�neas conectadas al nodo
        for i=1:contbarra
            if barres(i).nusinf==n % Si el nodo est� conectado al extremo inferior
                vec=nusos(barres(i).nussup).posicio-nusos(n).posicio; % Vector de direcci�n de la l�nea
                con(length(con)+1)=atan2(vec(2),vec(1));
            elseif barres(i).nussup==n % Si el nodo est� conectado al extremo inferior
                vec=nusos(barres(i).nusinf).posicio-nusos(n).posicio;
                con(length(con)+1)=atan2(vec(2),vec(1));
            end
        end
        ang=0;
        switch nusos(n).contorn % Discrimina seg�n el tipo de condici�n de contorno
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
                if numel(con)==1 % Si Solo est� conectado a una l�nea
                    ang=con-pi/2; %Sigue la direcci�n de la linea
                else % Si est� conectado a m�s de una l�nea
                    ang=atan2(sum(sin(con)),sum(cos(con)))-pi/2; % Gira el �ngulo medio
                    ang=round(ang*12/pi)*pi/12; % Redondea el �ngulo
                end
            otherwise
                ang=0;
                error=('contorno no v�lido');
        end
        
        nusos(n).gir=ang; % Apunta el �ngulo de giro
            hg=dibuix_contorn(nusos(n).contorn,distnumnus,fontnusos,tamanyfontnusos,flagbMalla); % Dibuja el nodo
            set(hg,'ButtonDownFcn',@clic_nus,'UserData',n,'Parent',hg_nusos); % Asigna la funci�n que se ejectua cuando se hace clic
            ht=findobj(hg,'Type','text'); % Objeto que contiene el texto
            pos=get(ht,'Position'); % Obtiene la posici�n
            angt=atan2(nusos(n).posicio(2)-ym,nusos(n).posicio(1)-xm); % �ngulo de situaci�n del texto seg�n la posici�n relativa del nodo
            angt=round((angt-pi/4)*2/pi)*pi/2+pi/4; % Redondea el angulo
            angt=angt-ang; % Resta el �ngulo de giro respecto el nodo para que el texto vaya en la posici�n calculada
            pos(1:2)=[cos(angt),sin(angt)]*distnumnus; % Calcula en coordenadas la posici�n del texto
            set(ht,'String',num2str(n),'Position',pos,'HorizontalAlignment','center','VerticalAlignment','middle'); % Asigna la posici�n al texto
            
        delete(nusos(n).hg) % Borra el dibujo antiguo
        nusos(n).hg=hg; % Guarda el handle del nuevo objeto en el nodo
    end

    function redibuixar_textnusos
        % Redibuja los textos de los nodos, seg�n el bot�n de Mostrar que
        % est� activo (numeraci�n, flecha, giros o momentos)
        
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
        % Relaciona el tama�o de representaci�n de los objetos gr�ficos con
        % el tama�o de la gr�fica, para que sea siempre constante y se
        % muestren siempre del mismo tama�o
        
        % Se coge como referencia el eje horizontal
        xl=get(grafica_est,'XLim'); % A la resta de vistes es pren l'eix x.

        tam=get(grafica_est,'Position'); % tam(3) es el tama�o horizontal de la gr�fica en p�xeles
        s=(xl(2)-xl(1))*tamanynus/tam(3); % Calcula el factor de escala s
    end

    function escalar_nusos
        % Escala nodos y cargas seg�n la variable de escala s calculada
        
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
            nusos(n)=dlgcondcont(nusos(n)); % Caja de di�logo de edici�n de la posici�n de contorno
        end
        calcul_cord_extrems % Recalcula los extremos de las coordenadas
        escala % Calcula el factor de escala s
        redibuixar_nus(n) %Redibujar el nodo
        escalar_nus(n) % Adecua l'escala.
        clicable % Actualiza los objetos clicables
    end

    function seleccionarCondCont()
        % Permite al usuario seleccionar una zona rectangular del gr�fico
        % con el cursor y aplicar la misma condici�n de contorno sobre
        % todos los nodos que est�n en el interior de la zona seleccionada
        
        if flagcondcont 
            % Si ya se ha hecho clic sobre el primer punto, se completa la
            % creaci�n de la seleccion y se aplican las condiciones de
            % contorno
            
            flagcondcont=0; % Reestablece el flag
            
            %Se obtienen las coordenadas x e y m�ximas y m�nimas para
            %hallar los 4 puntos que forman el pol�gono seleccionado.
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

                delete(rectanguloSeleccion(1)); % Elimina el rect�ngulo de selecci�n que sigue al cursor
                rectanguloSeleccion(1)=[]; 
            end
            
            [contorno,err]=dlgcondcontSeleccion(); % Caja de di�logo donde el usuario introduce la condici�n de contorno
            if err==0 % Si el usuario ha entrato los datos correctamente
             for i=1:contnus
                 % para todos los nodos de la placa, se comprueba si est�n
                 % dentro o en el l�mite del pol�gono. Si es as�, se
                 % aplican las condiciones de contorno
                  if inpolygon(nusos(i).getX(),nusos(i).getY(),[xMin, xMin, xMax, xMax],[yMin, yMax, yMax, yMin])
                    modificarcondcont(i,contorno)
                  end
             end
            end
            
        else
         % Si se ha hecho clic sobre el primer punto, se crea el rect�ngulo
         % discont�nuo temporal que muestra el �rea de selecci�n y sigue al
         % cursor hasta que se vuelva a hacer clic
         
        posicio=[str2double(get(editx,'String')),str2double(get(edity,'String')),0];
        pos=posicio;
        
        % Se crean cuatro l�neas discont�nuas que forman el rect�ngulo
        rectanguloSeleccion(1)=line([posicio(1) posicio(1)],[pos(2) posicio(2)],[0 0],'color','k','LineWidth',1,'Clipping','off','HitTest','off','LineStyle','--'); % Crea una linia des del nus clicat fins a la posici� del ratol�.
        rectanguloSeleccion(2)=line([pos(1) posicio(1)],[posicio(2) posicio(2)],[0 0],'color','k','LineWidth',1,'Clipping','off','HitTest','off','LineStyle','--'); % Crea una linia des del nus clicat fins a la posici� del ratol�.
        rectanguloSeleccion(3)=line([pos(1) pos(1)],[pos(2) posicio(2)],[0 0],'color','k','LineWidth',1,'Clipping','off','HitTest','off','LineStyle','--'); % Crea una linia des del nus clicat fins a la posici� del ratol�.
        rectanguloSeleccion(4)=line([pos(1) posicio(1)],[pos(2) pos(2)],[0 0],'color','k','LineWidth',1,'Clipping','off','HitTest','off','LineStyle','--'); % Crea una linia des del nus clicat fins a la posici� del ratol�.
        flagcondcont=1;
        end
    end

    function esborrarapoyo(n)
        % "Borra" la condici�n de contorno de un nodo, es decir, se asigna
        % la condici�n "libre"
         modificarcondcont(n,'libre');
    end

%% CREACI�N I MODIFICACI�N DIN�MICA DE L�NEAS
% Funciones relacionadas con la creaci�n, modificaci�n, eliminaci�n,
% dibujo, de las l�neas

    function crearbarra(n,esCarga)
        % Crea una l�nea en la placa. La variable de entrada esCarga
        % determinara si se trata de una L�nea de Contorno o de una L�nea
        % de �rea de Carga. Cuando se hace el primer clic sobre un nodo se
        % crea una l�nea temporal que va siguiendo al cursor hasta que se
        % hace clic sobre el segundo nodo.
        
        if flagbarra && primernusbarra == n  %Evita que se cree una barra con los mismos nodos superior e inferior
        
        elseif flagbarra % Si ya se hab�a hecho clic sobre un nodo, �ste es el segundo nodo y por lo tanto se crea la l�nea
            novabarra(primernusbarra,n,esCarga) % Crea la l�nea
            flagbarra=0; % Reestablece el flag
            delete(hbarra); % Elimina la l�nea temporal que sigue al cursor
            hbarra=[]; 
        else % Si se ha hecho clic sobre el primer nodo
            primernusbarra=n; % Apunta el n�mero de nodo
            posicio=[str2double(get(editx,'String')),str2double(get(edity,'String')),0]; % Obtiene la posici�n del cursor
            if esCarga
            color='g';
            else
            color='k';
            end
            hbarra=line([nusos(n).posicio(1) posicio(1)],[nusos(n).posicio(2) posicio(2)],[nusos(n).posicio(3) posicio(3)],'color',color,'LineWidth',2,'Clipping','off','HitTest','off','Parent',hg_barres); % Crea una l�nea temporal desdel nodo clicado hasta el cursor
            flagbarra=1; % Activa el flag para indicar que ya se ha hecho clic sobre el primer nodo
        end
    end

    function novabarra(nusinf,nussup,esCarga)
        % Crea una l�nea des del nodo inferior al superior
        
        existeix=0;
        
        % No permite que haya dos l�neas del mismo tipo superpuestas, es
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
        contbarra=contbarra+1; % Incrementa el contador de l�neas
        barres(contbarra)=barra; % Nuevo objeto en el vector
        barres(contbarra).nusinf=nusinf; % Nodo inferior
        barres(contbarra).nussup=nussup; % Nodo superior
        barres(contbarra).num=contbarra; % Asigna el n�mero de l�nea
        redibuixar_barra(contbarra) % Dibuja la l�nea
        colorbarres
        clicable % Establece qu� objetos gr�ficos tienen el clic activado
        end
    end

    function novabarraNoDraw(nusinf,nussup,esCarga)
        % Crea una l�nea des del nodo inferior al superior, pero no la
        % redibuja. Aumenta mucho el rendimiento cuando hay que a�adir
        % muchas l�neas a la vez
        
        existeix=0;
        
        % No permite que haya dos l�neas del mismo tipo superpuestas, es
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
        contbarra=contbarra+1; % Incrementa el contador de l�neas
        barres(contbarra)=barra; % Nuevo objeto en el vector
        barres(contbarra).nusinf=nusinf; % Nodo inferior
        barres(contbarra).nussup=nussup; % Nodo superior
        barres(contbarra).num=contbarra; % Asigna el n�mero de l�nea
        end
    end

    function redibuixar_barra(n)
        % Elimina el dibujo existente y lo crea de nuevo
        
        delete(barres(n).hg); % Borra el objeto gr�fico
        posinf=nusos(barres(n).nusinf).posicio; % Posici�n nodo inferior
        possup=nusos(barres(n).nussup).posicio; % Posici�n nodo superior
        barres(n).hg=line([posinf(1) possup(1)],[posinf(2) possup(2)],[posinf(3) possup(3)],'LineWidth',thbarra,'UserData',n,'ButtonDownFcn',@clic_barra,'Parent',hg_barres); % Crea la l�nea
        set(barres(n).hg,'Clippin','on') % NO permet que en 3d sobresurti de la gr�fica.
    end

    function redibuixar_barres
        % Elimina los objetos gr�ficos de las l�neas y los redibuja de nuevo
        for i=1:contbarra % Para todas las l�neas, redibuja la l�nea
            redibuixar_barra(i);
        end
        colorbarres
    end

    function esborrarbarra(n)
        % Borra la l�nea indicada. Elimina de la lista la l�nea y elimina
        % los objetos gr�ficos asociados
        
        nusinf=barres(n).nusinf; % Nodo inferior
        nussup=barres(n).nussup; % Nodo superior
        for i=1:contcargaunif
            % Si la l�nea forma parte de alguna �rea con carga repartida,
            % se elimina tambi�n la carga repartida
            for j=1:length(cargasunif(i).barres)
                if barres(n).num==cargasunif(i).barres(j)
                    esborrarcargaunif(i);
                    break;
                end
            end
        end
        delete(barres(n).hg) % Elimina el objeto gr�fico que representa la l�nea
        barres2=barra; % Crea una nueva lista de l�neas
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
        % Borra la l�nea indicada. Elimina de la lista la l�nea y elimina
        % los objetos gr�ficos asociados. No se redibujan los elementos
        % gr�ficos para aumentar en gran medida el rendimiento cuando se
        % eliminan muchas a la vez
        
        delete(barres(n).hg) % Elimina el objeto gr�fico que representa la l�nea
        barres2=barra; % Crea una nueva lista de l�neas
        if n>1
            barres2(1:n-1)=barres(1:n-1); 
        end
        if n<contbarra
            barres2(n:contbarra-1)=barres(n+1:contbarra); 
            for i=n:contbarra-1
                barres2(i).num=i; % Actualitza els n�meros de barra.
                set(barres2(i).hg,'UserData',i); % Actualitza els n�meros de barra al camp 'UserData' dels objectes grafics.
            end
        end
        barres=barres2; % Elimina la lista antigua y la sustituye por la nueva
        contbarra=contbarra-1; % Actualitza el contador
    end

%% CREACI�N I MODIFICACI�N DIN�MICA DE CARGAS PUNTUALES
% Funciones relacionadas con la creaci�n, modificaci�n, eliminaci�n,
% dibujo, de las cargas puntuales

    function crearmodificarcarreganus(n)
        % Crea o modifica la carga de un nodo
        
        [nus,err]=dlgcarreganus(nusos(n)); %Caja de di�logo donde se asigna la carga al nodo
        if err==0
        nusos(n)=nus;
        else
         h=errordlg('Valor de la carga no v�lido. Reintentar.', 'Carga no v�lida');    
        end
        redibuixa_carreganus(n); % Dibuja la carga
        escalar_nusos % Escala nodos y cargas
        colorcarreganusos
    end

    function redibuixa_carreganus(n)
         % Crea los objetos gr�ficos que determinan la carga puntual

        delete(nusos(n).hgc); % Elimina el objeto gr�fico que representa la carga
        nusos(n).hgc=dibuix_carreganus(n,nusos(n).posicio,nusos(n).puntual,fontcarregues,tamanyfontcarregues); % Crea el objeto gr�fico
        set(nusos(n).hgc,'ButtonDownFcn',@clic_carreganus,'UserData',n,'Parent',hg_carreganusos); % Asigna al objeto la funci�n que se ejecutar� cuando se haga clic encima
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

%% CREACI�N I MODIFICACI�N DIN�MICA DE CARGAS REPARTIDAS
% Funciones relacionadas con la creaci�n, modificaci�n, eliminaci�n,
% dibujo, de las cargas repartidas

    function crearmodificarcargaunif(n)
        % Crea o modifica una carga repartida
        
        index=1;
        barresList=repmat(barra,0,0);
        
        % Se parte de la l�nea que ha seleccionado el usuario y se mira si
        % forma una �rea cerrada con otras barras. Si lo hace se asigna una
        % carga repartida a ese �rea, sin� se muestra error
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
       
       % Se comprueba si se forma una �rea cerrada
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
  
       % Se muestra una caja de di�logo para que el usuario entre el valor
       % de la carga. Se comprueba si es un valor v�lido
        [carga,err2]=dlgcargaunif([0;0;0]);
            if (err2==1)
                h = errordlg('Valor de carga no v�lido. Reintroducir datos.','Carga no v�lida');
                err=1;
            end
       else
          h = errordlg('El area de carga no es cerrada','Area no cerrada');
       end
           
           
       if (err==0)
           %si ya exist�a una carga repartida, se elimina y se a�ade la
           %nueva carga
           for i=1:contcargaunif
               a= ismember(nusosArea,cargasunif(i).nusos);
               b= ones(length(nusosArea),1);
               if (length(nusosArea)==length(cargasunif(i).nusos)) & (a==b)
                   esborrarcargaunif(i)
               end
           end
           
           % Se cambia el color de las l�neas por el azul
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
        % Se muestra una caja de di�logo para que el usuario entre el valor
       % de la carga. Se comprueba si es un valor v�lido
       err=0;
        [carga,err]=dlgcargaunif(cargasunif(n).carga);
            if (err==1)
                h = errordlg('Valor de carga no v�lido. Reintroducir datos.','Carga no v�lida');
                err=1;
            end
       if err==0
           cargasunif(n).carga=carga;
           redibuixa_cargaunif(n);           
       end
    end
    
    function redibuixa_cargaunif(n)
        % Crea los objetos gr�ficos que determinan la carga repartida
        
        delete(cargasunif(n).hg); % Elimina el objeto gr�fico actual
        
        xSum=0;
        ySum=0;
        for i=1:length(cargasunif(n).nusos)
            xSum=xSum+nusos(cargasunif(n).nusos(i)).getX();
            ySum=ySum+nusos(cargasunif(n).nusos(i)).getY();
        end
        xMed=xSum/i;
        yMed=ySum/i;
        
        cargasunif(n).hg=dibuix_cargaunif(n,[xMed, yMed,0],cargasunif(n).carga,fontcarregues,tamanyfontcarregues); % Crea el objeto gr�fico
        set(cargasunif(n).hg,'ButtonDownFcn',@clic_cargaunif,'UserData',n,'Parent',hg_cargasunif); % Asigna al objeto la funci�n que se ejecutar� cuando se haga clic encima
        set(get(cargasunif(n).hg,'Children'),'Clipping','on') 
        colorcargasunif
    end

    function esborrarcargaunif(n)
        try
        delete(cargasunif(n).hg) % Destruye el objeto gr�fico de la carga uniforme
        catch
        end
        % Cambia el color y el estado de las l�neas de �rea de carga para
        % indicar que ya no existe carga sobre el �rea
        for i=1:length(cargasunif(n).barres)
           barres(cargasunif(n).barres(i)).color='g';
           barres(cargasunif(n).barres(i)).cargada=0;
        end
        cargasunif(n)=[]; %borra el objeto del vector
        contcargaunif=contcargaunif-1; % Reduce el contador
        clicable % Determina qu� objetos son clicables
        
    end

%% ACCIONES SOBRE LA VENTANA PRINCIPAL, REDIMENSIONAMIENTO, CONTROL DEL RAT�N Y TELCADO, ETC.

    function [nusos,contnus,barres,contbarra,vista,flagbarra,primernusbarra,hbarra,flagclic,flagmourenus,posini,s,xmin,xmax,ymin,ymax,zmin,zmax,xm,ym,zm,xmed,ymed,zmed,angle3d,grafica,nom,thbarra,contbarracarga,cargasunif,contcargaunif,bwidth,bheight,colorcarregues,flagcondcont,rectanguloSeleccion,elementos]=inicialitza_variables
        % Funci�n que define las variables globales del programa con los
        % valores iniciales.Estas variables son accesibles dentro del
        % espacio de trabajo de la funci�n principal del programa y sus
        % subfunciones. aparecen de color azul en el editor de Matlab
        % (variables globales).
    
        nusos=nus.empty(1,0); % Lista de nodos.
        contnus=0; % Contador de nodos.
        barres=barra.empty(1,0); % Lista de barras.
        contbarra=0; % Contador de barras.
        vista='xy'; % Modo de vista actual.
        flagbarra=0; % Flag que controla el proceso de crear barras. Se activa cuando se hace clic en el primer nodo, a la espera del segundo.
        primernusbarra=0; % Primer nodo clicado en el proceso de crear barras.
        hbarra=0; % Linea temporal que representa la barra en construcci�n.
        flagclic=0; % Flag que indica que se ha hecho clic en un bot�n del rat�n y cu�l ha sido.
        flagmourenus=0; % Flag que indica la funci�n que detecta el movimiento del nodo que se ha clicado con el bot�n derecho y que hay que desplazar.
        posini=zeros(2,6); % Posici�n inicial del rat�n al mover la pantalla.
        s=0; % Factor de escala para los objetos gr�ficos que se muestran por pantalla: nodos, cargas,etc.
        xmin=[]; % Coordenada x minima de la placa
        xmax=[]; % Coordenada x maxima de la placa.
        ymin=[]; % Coordenada y minima de la placa
        ymax=[]; % Coordenada y maxima de la placa
        zmin=[]; % Coordenada z minima de la placa
        zmax=[]; % Coordenada z maxima de la placa
        xmed=[]; % Media de las coordenadas x m�nima i m�xima de la placa.
        ymed=[]; % Media de las coordenadas y m�nima i m�xima de la placa.
        zmed=[]; % Media de las coordenadas z m�nima i m�xima de la placa.
        angle3d=0; % Angulo de rotaci�n en la vista 3d.
        xm=0; % Media de las coordenadas x de la placa.
        ym=0; % Media de las coordenadas y de la placa.
        zm=0; % Media de las coordenadas z de la placa.
        grafica=0; % Grafica que se est� mostrando, grafica de la estructura o graficas de resultados.
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
        % Creaci�n de la ventana
        set(0,'Units','pixels') % Para obtener el tamano de la pantalla en pixeles.
        sc=get(0,'ScreenSize'); % Obtiene el tamano de la pantalla.
        tm=[1272 618]; % Tamano de la ventana en pantalla.
        ps=(sc(3:4)-tm)/2-[0,18];% Posici�n de la ventana, centrada en pantalla.
        bg=get(0,'defaultUicontrolBackgroundColor'); % Obtiene el color de fondo por defecto.
        figcme2=figure('Units','pixels','Position',[ps,tm],'NumberTitle','off','Name','C�lculo de Placas MEF','Resize','on','color',bg,'Toolbar','figure','MenuBar','none','ResizeFcn',@figcme2_resize,'WindowButtonMotionFcn',@moviment_ratoli,'WindowButtonDownFcn',@clic_figure,'WindowButtonUpFcn',@unclic_figure,'WindowScrollWheelFcn',@roda_ratoli,'CloseRequestFcn',@sortir,'KeyPressFcn',@tecla); % Crea la ventana principal del programa
    end

    function figcme2_resize(hObject,eventdata,handles)
    % Recoloca los paneles cuando se redimensiona la ventana
        sc=get(figcme2,'Position'); % Posici�n y tama�o de la pantalla
        tm=sc(3:4); % Tama�o de la ventana en la pantalla
        if tm(1)<700 % Limita el m�nimo horizontal
            tm(1)=700;
            set(figcme2,'Position',[sc(1:2),tm]);
        end
        if tm(2)<630 % Limita el m�nimo vertical
            sc(2)=sc(2)+tm(2)-630;
            tm(2)=630;
            set(figcme2,'Position',[sc(1:2),tm]);
        end
        % Cambia la posici�n y tama�o de los elementos
        set(panel1,'Position',[9,9,tm-[bwidth+30,15]]);                                             % Panell de la gr�fica de edicion
        set(panel2,'Position',[tm-[bwidth+15,172],bwidth+10,(bheight+5)*5+20]);                     % Panel Lateral Vista
        set(panel3,'Position',[tm-[bwidth+15,172+(bheight+5)*13+30*2],bwidth+10,(bheight+5)*5+20]); % Panel lateral Mostrar
        set(panel4,'Position',[tm-[bwidth+15,172+(bheight+5)*8+30],bwidth+10,(bheight+5)*8+20]);    % Panel lateral Introducir Calculos
        set(grafica_est,'Position',[36,50,tm-[230,70]]);            %gr�fica de edici�n
        set(logo,'Position',[36,50,tm-[230,70]]);                   %logo de fondo
        
        resultadosPos= [5,5,tm-[bwidth+30,15]]; 
        set(resultados,'Position',resultadosPos+[0,0,5,5]);         %Panel padre de los gr�ficos de resultados 3D
        set(resultados_flecha,'Position',resultadosPos);            %Panel del gr�fico3D flecha
        set(resultados_girox,'Position',resultadosPos);             %Panel del gr�fico3D giro X
        set(resultados_giroy,'Position',resultadosPos);             %Panel del gr�fico3D giro Y
        set(resultados_Mx,'Position',resultadosPos);                %Panel del gr�fico3D Mx
        set(resultados_My,'Position',resultadosPos);                %Panel del gr�fico3D My
        set(resultados_Mxy,'Position',resultadosPos);               %Panel del gr�fico3D Mxy
        
        graficosPos=[100,120,tm-[bwidth+250,200]];
        set(grafico_flecha,'Position',graficosPos);                 %gr�fico3D flecha
        set(grafico_girox,'Position',graficosPos);                  %gr�fico3D giro X
        set(grafico_giroy,'Position',graficosPos);                  %gr�fico3D giro Y
        set(grafico_Mx,'Position',graficosPos);                     %gr�fico3D Mx
        set(grafico_My,'Position',graficosPos);                     %gr�fico3D My
        set(grafico_Mxy,'Position',graficosPos);                    %gr�fico3D Mxy    
 
        centrar
    end

%% ACCIONES DE CONTROL DE CLICS DE RAT�N, MOVIMIENTO DE RAT�N Y PULSADO DE TECLAS
%Se determina el comportamiento del programa cuando se pulsan botones en el
%rat�n o este se desplaza por la ventana del programa. tambi�n se
%determinan las accciones correspondientes cuando se pulsan ciertas teclas

    function clic_figure(hObject,eventdata,handles)
        % Se ejecuta cuando se pulsa el rat�n. Se ejecuta siempre antes que
        % las otras funciones de control de pulsaci�n. �s m�s gen�rica y
        % complementa las otras funciones. Discrimina seg�n el que bot�n se
        % pulsa y la almacena en la variable flagclic
        
        switch get(figcme2,'SelectionType')
            case 'normal' % Bot�n iziquierdo
                flagclic=1;
                if strcmp(get(botobarramoure,'State'),'on')
                    posini=get(grafica_est,'currentpoint');
                end
            case 'open' % Doble clic
                flagclic=2;
            case 'alt'
                flagclic=3; %  bot�n derecho o Ctrl+bot�n izquierdo
            case 'extend'
                flagclic=4; % bot�n central, Shift+bot�n izquierdo o ambos botones
                posini=get(grafica_est,'currentpoint');
                set(figcme2,'Pointer','hand');
        end
    end

    function unclic_figure(hObject,eventdata,handles)
        % Se ejecuta cuando se libera el rat�n
        
        flagclic=0; % Resetea la variable de pulsaci�n
        flagmourenus=0; % Si se estaba moviendo un nodo, resetea el flag para que no pueda moverse m�s con el rat�n
        
        % si se estaba moviendo el gr�fico o haciendo zoom, se da al cursor
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
        % Ampl�a o reduce el gr�fico de edici�n con la rueda del rat�n.

        zom(eventdata.VerticalScrollCount/factorzoom)
    end

    function [] = zom(factor)
        % Ampl�a y reduce la gr�fica de edici�n seg�n un factor

        if grafica==grafica_est
            posbruta=get(grafica_est,'currentpoint'); % Posici�n del cursor
            lim=[get(grafica_est,'XLim');get(grafica_est,'YLim');get(grafica_est,'ZLim')]; % Escala de los ejes
            
            frac = (posbruta(1,:)'-lim(:,1))./(lim(:,2)-lim(:,1));
            an=(lim(:,2)-lim(:,1))*2^factor; % Anchura x 2^factor
            lim(:,1) = posbruta(1,:)' - an.*frac;
            lim(:,2) = posbruta(1,:)' + an.*(1-frac);
            
            set(grafica_est,'XLim',lim(1,:),'YLim',lim(2,:),'ZLim',lim(3,:)); % Fija la nueva escala
            escala % Calcula el factor de escala s
            escalar_nusos % Reescala los nodos y las cargas
            clicable % Establece qu� objetos responden al rat�n (seg�n los botones activos en la barra de herramientas
        end
    end

    function moviment_ratoli(hObject,eventdata,handles)
        % Se ejecuta cuando se mueve el rat�n sobre la ventana del
        % programa. Actualiza los valores de los cajones de coordenadas
        % inferiores seg�n las posici�n. Cuando se crea una l�nea la l�nea
        % temporal sigue al rat�n. Si se mantiene la rueda clicada se mueve
        % el gr�fico. Con el bot�n derecho se mueven los nodos.
        
        posbruta=get(grafica_est,'currentpoint'); % Posici�n del cursor
        precisio=str2double(get(editprec,'String')); % Precisi�n definida en la caja de texto
        posicio=round(posbruta(1,1:3)/precisio)*precisio; % Redondea la posici�n
        
        % Actualitza la posici�n en las cajas de texto inferiores
        switch vista
            case 'xy'
                set(editx,'String',num2str(posicio(1))); % en vista de edici�n muestra X e Y
                set(edity,'String',num2str(posicio(2)));
            case '3d'
                set(editx,'String',''); % Desactiva los cajas de posici�n en los gr�ficos 3D
                set(edity,'String','');
        end
        
        % Si se est� creando una l�nea, actualiza la posici�n para que la
        % l�nea "siga" al cursor
        if flagbarra
            x=get(hbarra,'XData');
            y=get(hbarra,'YData');
            set(hbarra,'XData',[x(1) posbruta(1,1)],'YData',[y(1) posbruta(1,2)]);
        end
        
        % Si se est� seleccionando para determinar las condiciones de
        % contorno, actualiza la posici�n para las 4 l�neas discontinuas
        % que forman el �rea de selecci�n para que "sigan" al cursor
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
        
        % Si se ha clicado la rueda del rat�n o se mueve el gr�fico,
        % modifica los l�mites del gr�fico para adaptarse al movimiento
        if flagclic ==4 || (flagclic ==1 && strcmp(get(botobarramoure,'State'),'on'))
            mov=posbruta-posini; % posini es la posici� anterior.
            mov=mov(1,:);
            if ~strcmp(vista,'3d')
                xl=get(grafica_est,'XLim');
                xl=xl-[mov(1),mov(1)];
                yl=get(grafica_est,'YLim')-[mov(2),mov(2)];
                zl=get(grafica_est,'ZLim')-[mov(3),mov(3)];
                set(grafica_est,'XLim',xl,'YLim',yl,'ZLim',zl);
            end
        end
        
        % Con el bot�n derecho pulsado sobre un nudo, se mueve �ste con el
        % rat�n
        if flagmourenus && ~get(boto3d,'Value')
            nusos(flagmourenus).posicio=posicio; % flagmourenus contiene el nudo afectado
            escala % Calcula el factor de escala s
            redibuixar_nusos % Redibuja los nodos para reorientarlos adecuadamente
            redibuixar_barres % Actualiza el dibujo de las l�neas
            escalar_nusos % Reescala nodos y cargas
            clicable % Establece qu� objetos responden al rat�n (seg�n los botones activos en la barra de herramientas
        end
    end

    function tecla(hObject,eventdata,handles)
        % Se ejecuta cuando se pulsa una tecla, realizando diferentes
        % acciones seg�n el momento 
        
        % Si se est� creando una l�nea se aborta con ESCS
        if flagbarra && strcmp(eventdata.Key,'escape')
            flagbarra=0; % Resetea el flag
            delete(hbarra) % Borra la l�nea temporal
            hbarra=[];
        elseif strcmp(eventdata.Key,'escape') && grafica~=grafica_est
            clic_grafica_res
        else  %Si estem a grafica_est, cas general, desactiva els botons d'accio
            botons_accions('off','off','off','off','off','off')
        end

        %C: bot�n Crear
        if strcmp(eventdata.Key,'c')
             botocrear
        end
        %M: bot�n Modificar
        if strcmp(eventdata.Key,'m')
             botomodificar
        end        
        %E: bot�n borrar
        if strcmp(eventdata.Key,'b')
             botoesborrar
        end 
        
    end
end

%% FUNCI�N DE CARGA DE OPCIONES

function [fontnusos,tamanyfontnusos,fontcarregues,tamanyfontcarregues,factorzoom,tamanynus,distnumnus,precini,XLimini,YLimini,ZLimini,colormodificar,coloresborrar,colorcarregues]=loadopcions
% Carga las opciones del programa (tipo y tama�o de fuente y de los elementos gr�ficos, estado inicial, etc.) 

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