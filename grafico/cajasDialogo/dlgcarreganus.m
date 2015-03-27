% T�TULO: Funci�n dlgcarreganus para CalculoPlacasMEF
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
% Se muestra una peque�a caja de di�logo por pantalla donde el usuario
% entra el valor de la carga puntual.

function [n,err]= dlgcarreganus(n)       
         
%% CREACI�N DE LA CAJA DE DI�LOGO CON CAJAS DE TEXTO PARA ENTRAR LOS DATOS
            err=0;
            prompt = {'Fz (N):','Mx (Nm):','My (Nm):',};
            dlg_title = 'Carga Puntual';
            num_lines = 1;
            def={num2str(n.puntual(1)),num2str(n.puntual(2)),num2str(n.puntual(3))};
            
%% COMPRUEBA LA VALIDEZ DE LOS DATOS ENTRADOS
            try
            x = inputdlg(prompt,dlg_title,num_lines,def);
            
            fz=str2double(x(1));
            mx=str2double(x(2));
            my=str2double(x(3));

            if isnan(fz)|| isnan(mx) || isnan(my)
            err=1; end
            
            catch
               err=1;
            end
            
            if err==0
                n.puntual(1)=fz;
                n.puntual(2)=mx;
                n.puntual(3)=my;
            end
end
