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
% Caja de di�logo donde se entran las caracter�sticas del material: m�dulo
% de elasticidad, Poisson, Espesor y Densidad.

function [poisson,E,thickness,density,err] = dlgmaterial()

%% CREACI�N DE LA CAJA DE DI�LOGO CON CAJAS DE TEXTO PARA ENTRAR LOS DATOS
            err=0;
            prompt = {'Coeficiente de Poisson:','M�dulo de elasticidad o Young (Pa):','Espesor de la placa (m):', 'Densidad del material (kg/m^3):'};
            dlg_title = 'Material';
            num_lines = 1;
            def = {'0.3','210000000','0.05','7850'};
            
%% COMPRUEBA LA VALIDEZ DE LOS DATOS ENTRADOS
            try
            x = inputdlg(prompt,dlg_title,num_lines,def);
            
            poisson =str2double(x(1));
            E=str2double(x(2));
            thickness=str2double(x(3));
            density=str2double(x(4));


            if isnan(poisson)|| isnan(E) || isnan(thickness) || isnan(density)
            err=1; end
            
            catch
               err=1;
            end
            
            if(err==0 && (poisson<-1 || poisson>0.5))
                err=2;
            end
            
            if err==0 && (density<0)
                err=3;
            end
            
            if err==0 && (thickness<0)
                err=4;
            end
            
end


