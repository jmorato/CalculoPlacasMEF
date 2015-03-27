% TÍTULO: Clase DKTElem para CalculoPlacasMEF
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
% Clase del elemento triangular de placas combinado DKT, de 3 nodos con 3
% grados de libertad cada uno (flecha,giro X y giro Y) Se asume espesor
% constante en el elemento, y cargas repartidas uniformes sobre el
% elemento. Consultar memoria escrita para más detalle sobre el elemento.

% Esta clase se encarga de todo lo relacionado con el elemento finito DKT,
% es decir, de almacenar sus propiedades como nodos o numeración global y
% lleva a cabo los cálculos necesarios (matriz de rigidez del elemento,
% aproximación de desplazamientos y momentos en cualquier punto, etc.

classdef DKTElem < handle

%% Propiedades de clase
    
    properties(GetAccess = 'public', SetAccess = 'private')
        
        v, E, th;           %Propiedades materiales, módulo de poisson, de elasticidad y espesor
        D;                  %Matriz de elasticidad
        x, y;               %Vectores 1x3 con las coordenadas x e y de los nodos
        A;                  %Área del elemento
        K;                  %Matriz 9x9 de rigidez explícita
        KintNum;            %Matriz de rigidez por integración numérica
        
        cargaUnif           %Vector 3x1 de carga total repartida sobre el elemento
        vectorCarga         %Vector 9x1 con las cargas equivalentes de las cargas repartidas para los 3 nodos
        
        ID;                 %Numeración del elemento
        nodos;              %Vector Referencia a los objetos tipo Nodo que pertenecen al elemento
    end

    properties (Access=private) 
        % propiedades que no se pueden consultar desde Matlab ni desde el
        % exterior del método (código más limpio y encapsulado)
        
        centro              %centro del triángulo
        LMatriz             %Matriz de coordenadas de área
        alfa                %Matriz B descompuesta en 1/2A*[L]*[alfa]
        T                   %Matriz de cambio de base
        
        x12, x23, x31;      %Variables de diferencias entre coordenadas de los nodos xij=xi-xj
        y12, y23, y31;
        l12, l23, l31;      %longitud de los lados
        
        P4, P5, P6;         %Variables para el cálculo de las funciones de forma
        q4, q5, q6;
        r4, r5, r6;
        t4, t5, t6;       
    end
    
%% Método Constructor
    methods (Access=public)

        function e = DKTElem(vPoisson, EYoung, thickness, ID, nodo1, nodo2, nodo3)
            if nargin>0
            e.E=EYoung;
            e.v=vPoisson;
            e.x=[nodo1.x nodo2.x nodo3.x];
            e.y=[nodo1.y nodo2.y nodo3.y];
            e.ID=ID;
            e.nodos=[nodo1, nodo2, nodo3];
            e.addElementToNodes();
            e.th= thickness;
            e=e.DMat();
            e=e.CalcGeom();
            e.calcMatrizCoordenadasL();
            e=e.CalcVarsPQRT();
            e=e.calcKStiffnessMatrix();
            e=e.calcK2StiffnessMatrix();
            e.cargaUnif=[0;0;0];
            end
        end
    end
    
%% Métodos Gets y Sets: acceso público
methods (Access=public)

        function nodos=getNodos(e)
            nodos=e.nodos;
        end
        
        function ID= getID(e)
            ID=e.ID;
        end
        
        function x= getX(e,n)
            if nargin<2
                x=e.x;
            else
            x=e.x(n);
            end
        end
        
        function y= getY(e,n)
            if nargin<2
                y=e.y;
            else
                y=e.y(n);
            end
        end
        
        function K=getK(e)
            K=e.K;
        end
        
        function centro=getCentro(e)
            centro=e.centro;
        end
end

%% Métodos de Interacción externa: acceso público
methods (Access=public)
    
        function addElementToNodes(e)
            % Añade el elemento a la lista de elementos adyacentes de los 3
            % nodos 
            for i=1:length(e.nodos)
                e.nodos(i).addElement(e);
            end
        end
        
        function addCargaUnif(e,carga)
            % Suma una carga repartida al vector de carga repartida
            e.cargaUnif=e.cargaUnif+carga;
        end
        
        function calcVectorCargas(e)
            %Se calcula el vector de cargas equivalente en los nodos para el
            %total de cargas repartidas. Para ello simplemente cada nodo recibe
            %un tercio de la carga total sobre el elemento

            e.vectorCarga=e.A/3*[e.cargaUnif(1);e.cargaUnif(2);e.cargaUnif(3);e.cargaUnif(1);e.cargaUnif(2);e.cargaUnif(3);e.cargaUnif(1);e.cargaUnif(2);e.cargaUnif(3)];
            for i=1:1:3
                e.nodos(i).addCargaUnif(e.vectorCarga(1+(i-1)*3:3+(i-1)*3,1));
            end
        end
        
        function despPunto=obtenerDesplazamiento(e,punto)
            % Se obtiene la aproximación del desplazamiento de un punto
            % cualquiera del elemento con una interpolación lineal (usando
            % las coordenadas de Área)
            
            despPunto=zeros(3,1);
            
            L=e.L(punto(1),punto(2));
            
            desp1=e.nodos(1).getDesp();
            desp2=e.nodos(2).getDesp();
            desp3=e.nodos(3).getDesp();
            
            % Interpolación de los desplazamientos de los 3 nodos según las
            % coordenadas de área
            despPunto(1)=L(1)*desp1(1)+L(2)*desp2(1)+L(3)*desp3(1);
            despPunto(2)=L(1)*desp1(2)+L(2)*desp2(2)+L(3)*desp3(2);
            despPunto(3)=L(1)*desp1(3)+L(2)*desp2(3)+L(3)*desp3(3);
        end
        
        function momentos=obtenerMomentos(e,punto)
            % Se obtiene la aproximación de los momentos de un punto
            % cualquiera del elemento con una interpolación lineal (usando
            % las coordenadas de Área)
            
            x=punto(1);
            y=punto(2);
            L=e.L(x,y);
            
            xi=L(2);
            n=L(3);
            
            desp1=e.nodos(1).getDesp();
            desp2=e.nodos(2).getDesp();
            desp3=e.nodos(3).getDesp();
            vectDesp=[desp1;desp2;desp3];
            
            Bmod=zeros(3,9);
            Bmod(1,1:3)=[1-xi-n xi n];
            Bmod(2,4:6)=[1-xi-n xi n];
            Bmod(3,7:9)=[1-xi-n xi n];
            Bmod;
%             aux=[1-xi-n 0 0;0 xi 0;0 0 n];
%             Bmod=[];
%             Bmod=[aux aux aux];
            x21=e.x(2)-e.x(1);
            y21=e.y(2)-e.y(1);
            xx=e.x(1)+xi*x21+n*e.x31;
            yy=e.y(1)+xi*y21+n*e.y31;
            momentos=e.D*e.B(xi,n)*vectDesp;
%             momentos=-1/(2*e.A)*e.D*Bmod*e.alfa*vectDesp;
            
%             momentos=e.T'*momentos
            tensiones=momentos*12/e.th^2/2;
            
      end
        
         function e= calcKStiffnessMatrix(e)
            % Calcula la matriz de rigidez del elemento por integración
            % numérica según la cuadratura de Gauss de tres puntos
            
            xi=[1/2 1/2 0]; %Coordenadas y pesos de Gauss
            n=[0 1/2 1/2];
            w=[1/3 1/3 1/3];
            mat=zeros(9,9);
            
            % DEBUGGING!!!!! mirar 40 practicas leccion H p.84
            for i=1:3
                for j=1:3
                    
                    mat=mat+ w(i)*w(j)*(e.B(xi(i),n(j)))'*e.D*e.B(xi(i),n(j));
                end
                
                %disp(e.B(xi(i), n(j)));
            end
            e.KintNum=mat.*2*e.A;
            
         end
         
         function e= calcK2StiffnessMatrix(e)
             % Se calcula la matriz de rigidez del elemento según la
             % formulación explícita propuesta por Batoz, en ejes locales.
             % Con la matriz de cambio de base se pasa a ejes globales
             
             %Cálculo del cambio de base
             vectCoord=[e.x(2)-e.x(1), e.y(2)-e.y(1)];
             ang=atan(vectCoord(2)/vectCoord(1));
             T=[1 0 0;0 -sin(ang) cos(ang);0 -cos(ang) -sin(ang)];
             e.T=T;
             
             %Coordenadas y parámetros de interés
             x1=0;
             y1=0;
             
             x2=(e.x(2)-e.x(1))*cos(ang)+(e.y(2)-e.y(1))*sin(ang);
             y2=-(e.x(2)-e.x(1))*sin(ang)+(e.y(2)-e.y(1))*cos(ang);
             
             x3=(e.x(3)-e.x(1))*cos(ang)+(e.y(3)-e.y(1))*sin(ang);
             y3=-(e.x(3)-e.x(1))*sin(ang)+(e.y(3)-e.y(1))*cos(ang);
             
             x12=x1-x2;
             x23=x2-x3;
             x31=x3-x1;
             
             y12=y1-y2;
             y23=y2-y3;
             y31=y3-y1;
             
             l122=x12^2+y12^2;
             l232=x23^2+y23^2;
             l312=x31^2+y31^2;
             
             p4=-6*x23/l232;
             t4=-6*y23/l232;
             q5=3*x31*y31/l312;
             
             p5=-6*x31/l312;
             t5=-6*y31/l312;
             r4=3*y23^2/l232;
             
             p6=-6*x12/l122;
             q4=3*x23*y23/l232;
             r5=3*y31^2/l312;
             
             %Matriz de elasticidad por bloques
             E1= e.E*e.th^3/(12*(1-e.v^2));
             E2= e.v*e.E*e.th^3/(12*(1-e.v^2));
             E3= e.E*e.th^3/(12*(1-e.v^2));
             E4= (1-e.v)/2*e.E*e.th^3/(12*(1-e.v^2));
             
             %Matriz alfa
             mat1=[y3*p6 0 -4*y3 -y3*p6 0 -2*y3 0 0 0];
             mat2=[-y3*p6 0 2*y3 y3*p6 0 4*y3 0 0 0];
             mat3=[y3*p5 -y3*q5 y3*(2-r5) y3*p4 y3*q4 y3*(r4-2) -y3*(p4+p5) y3*(q4-q5) y3*(r4-r5)];
             mat4=[-x2*t5 x23+x2*r5 -x2*q5 0 x3 0 x2*t5 x2*(r5-1) -x2*q5]; % El último valor cambia según la bibliografía
             mat5=[0 x23 0 x2*t4 x3+x2*r4 -x2*q4 -x2*t4 x2*(r4-1) -x2*q4]; % El valor 4,5 cambia según la bibliografía
             mat6=[x23*t5 x23*(1-r5) x23*q5 -x3*t4 x3*(1-r4) x3*q4 -x23*t5+x3*t4 -x23*r5-x3*r4-x2 x3*q4+x23*q5];
             mat7=[-x3*p6-x2*p5 x2*q5+y3 -4*x23+x2*r5 x3*p6 -y3 2*x3 x2*p5 x2*q5 (r5-2)*x2];
             mat8=[-x23*p6 y3 2*x23 x23*p6+x2*p4 -y3+x2*q4 -4*x3+x2*r4 -x2*p4 x2*q4 (r4-2)*x2]; % El valor 5 cambia según la bibliografía
             mat9=[x23*p5+y3*t5 -x23*q5+(1-r5)*y3 (2-r5)*x23+y3*q5 -x3*p4+y3*t4 (r4-1)*y3-x3*q4 (2-r4)*x3-y3*q4 -x23*p5+x3*p4-(t4+t5)*y3 -x23*q5-x3*q4+(r4-r5)*y3 -x23*r5-x3*r4+4*x2+(q5-q4)*y3];
             alfa=[mat1;mat2;mat3;mat4;mat5;mat6;mat7;mat8;mat9]; % El valor 2 cambia según la bibliografía
             e.alfa=alfa;
             
             %Submatrices alfa
             a11=alfa(1:3,1:3);
             a12=alfa(1:3,4:6);
             a13=alfa(1:3,7:9);
             a21=alfa(4:6,1:3);
             a22=alfa(4:6,4:6);
             a23=alfa(4:6,7:9);
             a31=alfa(7:9,1:3);
             a32=alfa(7:9,4:6);
             a33=alfa(7:9,7:9);
             
             %Matriz R
             R=[2 1 1;1 2 1;1 1 2];
             
             %Matriz Q
             Q1=[(E1*a11'+E2*a21')*R (E2*a11'+E3*a21')*R (E4*a31')*R];
             Q2=[(E1*a12'+E2*a22')*R (E2*a12'+E3*a22')*R (E4*a32')*R];
             Q3=[(E1*a13'+E2*a23')*R (E2*a13'+E3*a23')*R (E4*a33')*R];             
             Q=[Q1;Q2;Q3]/24;
             
             %Cálculo de la matriz de rigidez local
             mat=[];
             mat=Q*alfa*(1/(2*e.A));
             e.K=zeros(9,9);
             
             %Cálculo de la matriz de rigidez global. Se aplica el cambio de base a
             %las diferentes submatrices de K.
                for i=1:3
                    for j=1:3
                        e.K((i-1)*3+1:(i)*3,(j-1)*3+1:(j)*3)=T'*mat((i-1)*3+1:(i)*3,(j-1)*3+1:(j)*3)*T;
                    end
                end
         end                            
end
         
%% Metodos internos: Matrices de funciones de forma
         methods(Access = private)
             
         function mat= HxDerXi(e, xi, n)
             %Evalúa la matriz de funciones de forma respecto a la coordenada X
             %derivada por Xi
         
             mat= zeros(9,1);
             mat(1)=e.P6*(1-2*xi)+(e.P5-e.P6)*n;
             mat(2)=e.q6*(1-2*xi)-(e.q5+e.q6)*n;
             mat(3)=-4+6*(xi+n)+e.r6*(1-2*xi)-n*(e.r5+e.r6);
             mat(4)= -e.P6*(1-2*xi)+n*(e.P4+e.P6);
             mat(5)= e.q6*(1-2*xi)-n*(e.q6-e.q4);
             mat(6)= -2+6*xi+e.r6*(1-2*xi)+n*(e.r4-e.r6);
             mat(7)= -n*(e.P5+e.P4);
             mat(8)= n*(e.q4-e.q5);
             mat(9)= -n*(e.r5-e.r4);
         end
         
         function mat= HyDerXi(e, xi, n)
             %Evalúa la matriz de funciones de forma respecto a la coordenada Y
             %derivada por Xi
         
             mat= zeros(9,1);
             mat(1)=e.t6*(1-2*xi)+(e.t5-e.t6)*n;
             mat(2)= 1 + e.r6*(1-2*xi)-(e.r5+e.r6)*n;
             mat(3)= -e.q6*(1-2*xi)+n*(e.q5+e.q6);
             mat(4)= -e.t6*(1-2*xi)+n*(e.t4+e.t6);
             mat(5)=-1+e.r6*(1-2*xi)+n*(e.r4-e.r6);
             mat(6)= +e.q6*(1-2*xi)+n*(e.q4-e.q6); %El valor cambia segúna la bibiografía
             mat(7)= -n*(e.t4+e.t5);
             mat(8)= n*(e.r4-e.r5);
             mat(9)= -n*(e.q4-e.q5);
         end
         
         function mat= HxDerN(e, xi, n)
             %Evalua la matriz de funciones de forma respecto a la coordenada X
             %derivada por n  
             
             mat= zeros(9,1);
             mat(1)= -e.P5*(1-2*n)-xi*(e.P6-e.P5);
             mat(2)= e.q5*(1-2*n)-xi*(e.q5+e.q6);
             mat(3)= -4+6*(xi+n)+e.r5*(1-2*n)-xi*(e.r5+e.r6);
             mat(4)= xi*(e.P4+e.P6);
             mat(5)= xi*(e.q4-e.q6);
             mat(6)= -xi*(e.r6-e.r4);
             mat(7)= e.P5*(1-2*n)-xi*(e.P4+e.P5);
             mat(8)= e.q5*(1-2*n)+xi*(e.q4-e.q5);
             mat(9)= -2+6*n+e.r5*(1-2*n)+xi*(e.r4-e.r5);
         end
         
         function mat= HyDerN(e, xi, n)
             %Evalúa la matriz de funciones de forma respecto a la coordenada Y
             %derivada por n
             
             mat= zeros(9,1);
             mat(1)= -e.t5*(1-2*n)-xi*(e.t6-e.t5);
             mat(2)= 1+e.r5*(1-2*n)-xi*(e.r5+e.r6);
             mat(3)=-e.q5*(1-2*n)+xi*(e.q5+e.q6);
             mat(4)=xi*(e.t4+e.t6);
             mat(5)=xi*(e.r4-e.r6);
             mat(6)=-xi*(e.q4-e.q6);
             mat(7)= e.t5*(1-2*n)-xi*(e.t4+e.t5);
             mat(8)= -1+e.r5*(1-2*n)+xi*(e.r4-e.r5);
             mat(9)= -e.q5*(1-2*n)+xi*(e.q4-e.q5); %El valor cambia segúna la bibiografía
         end
         
         function [Hx,Hy]=HxHy(e,xi,n)
             % Calcula las matrices de funciones de forma en un punto dado
             
             %Coordenadas y parámetros de interés
             x23=e.x23; x31=e.x31; x12=e.x12;
             y23=e.y23; y31=e.y31; y12=e.y12;
             l232=e.l12^2; l312=e.l31^2; l122=e.l12^2;
             
             a4=-x23/l232; 
             a5=-x31/l312; 
             a6=-x12/l122;    
             
             b4=3/4*x23*y23/l232;
             b5=3/4*x31*y31/l312;
             b6=3/4*x12*y12/l122;
             
             c4=(1/4*x23^2-1/2*y23^2)/l232;
             c5=(1/4*x31^2-1/2*y31^2)/l312;
             c6=(1/4*x12^2-1/2*y12^2)/l122;
             
             d4=-y23^2/l232;
             d5=-y31^2/l312;
             d6=-y12^2/l122;
             
             e4=(1/4*y23^2-1/2*x23^2)/l232;
             e5=(1/4*y31^2-1/2*x31^2)/l312;
             e6=(1/4*y12^2-1/2*x12^2)/l122;
             
             %Funciones de forma originales del elemento triangular de 6
             %nodos
             N=e.N(xi,n);
             N1=N(1); N2=N(2); N3=N(3); N4=N(4); N5=N(5); N6=N(6);  
             
             %Matriz de forma Hx
             Hx= zeros(9,1);
             Hx(1)=1.5*(a6*N6-a5*N5);
             Hx(2)=b5*N5+b6*N6;
             Hx(3)=N1-c5*N5-c6*N6;
             Hx(4)=1.5*(a4*N4-a6*N6);
             Hx(5)=b6*N6+b4*N4;
             Hx(6)=N2-c6*N6-c4*N4;
             Hx(7)=1.5*(a5*N5-a4*N4);
             Hx(8)=b4*N4+b5*N5;
             Hx(9)=N3-c4*N4-c5*N5;
             
             %Matriz de forma Hy
             Hy= zeros(9,1);
             Hy(1)=1.5*(d6*N6-d5*N5);
             Hy(2)=-N1+e5*N5+e6*N6;
             Hy(3)=-b5*N5-b6*N6;
             Hy(4)=1.5*(d4*N4-d6*N6);
             Hy(5)=-N2+e6*N6+e4*N4;
             Hy(6)=-b6*N6-b4*N4;
             Hy(7)=1.5*(d5*N5-d4*N4);
             Hy(8)=-N3+e4*N4+e5*N5;
             Hy(9)=-b4*N4-b5*N5;
                                  
         end
         
         function N=N(e,xi,n)
            %Funciones de forma originales del elemento triangular de 6 nodos   
            
            N(1)=2*(1-xi-n)*(1/2-xi-n);
            N(2)=xi*(2*xi-1);
            N(3)=n*(2*n-1);
            N(4)=4*xi*n;
            N(5)=4*n*(1-xi-n);
            N(6)=4*xi*(1-xi-n);
         end
         
         function mat= B(e, xi, n)
             % Evalúa la matriz B del elemento, en función de xi y n
             
             B1= e.y31*(e.HxDerXi(xi, n))'+e.y12*(e.HxDerN(xi, n))';
             B2= -e.x31*(e.HyDerXi(xi, n))'-e.x12*(e.HyDerN(xi, n))';
             B3= -e.x31*(e.HxDerXi(xi, n))'-e.x12*(e.HxDerN(xi, n))'+...
                 e.y31*(e.HyDerXi(xi, n))'+e.y12*(e.HyDerN(xi, n))';
             
             mat= [B1; B2; B3].*1/(2*e.A);
         end
    end
    
%% Métodos internos: Propiedades del elemento y cálculos geométricos
    methods(Access = private)
        
         function e = DMat(e)
            % Cálculo de la matriz de elasticidad
            
            e.D=zeros(3,3);
            e.D(1,1)=1;
            e.D(1,2)=e.v;
            e.D(2,1)=e.v;
            e.D(2,2)=1;
            e.D(3,3)=(1-e.v)/2;
            e.D=(e.D).*(e.E*e.th^3/(12*(1-e.v^2)));            
         end
        
         function e=Area(e)
             % Cálculo del área del elemento
             
             vec1= [e.x(2)-e.x(1) e.y(2)-e.y(1)];
             vec2= [e.x(3)-e.x(1) e.y(3)-e.y(1)];
             Nvec1=[-vec1(2) vec1(1)];
             e.A=abs(1/2*Nvec1*transpose(vec2));
         end
         
         function calcMatrizCoordenadasL(e)
             % Cálculo de la matriz de coordenadas de Área L
             
             x1=e.x(1); x2=e.x(2); x3=e.x(3);
             y1=e.y(1); y2=e.y(2); y3=e.y(3);
             
             M1=[x2*y3-x3*y2 y2-y3 x3-x2];
             M2=[x3*y1-x1*y3 y3-y1 x1-x3];
             M3=[x1*y2-x2*y1 y1-y2 x2-x1];
             
             e.LMatriz=1/(2*e.A)*[M1;M2;M3];
             
         end
         
         function e = CalcGeom(e)
             %Calcula la geometría del elemento. Es decir, las longitudes de
             %los lados y la diferencia de coordenadas de los lados. También
             %calcula el área y el centro
             
             e=e.Area(); 
             
             e.x12= e.x(1)-e.x(2);
             e.y12=e.y(1)-e.y(2);
             e.l12=sqrt(e.x12^2+e.y12^2);             
             
             e.x23= e.x(2)-e.x(3);
             e.y23=e.y(2)-e.y(3);
             e.l23=sqrt(e.x23^2+e.y23^2);
             
             e.x31= e.x(3)-e.x(1);
             e.y31=e.y(3)-e.y(1);
             e.l31=sqrt(e.x31^2+e.y31^2);
             
             centroX=(e.x(1)+e.x(2)+e.x(3))/3;
             centroY=(e.y(1)+e.y(2)+e.y(3))/3;
             e.centro=[centroX centroY];
         end  
         
         function e=CalcVarsPQRT(e)
            % Calcula las variables P, q, r, t que figuran como parámetros del
            % cálculo de las matrices H de funciones de forma   
            
            e.P4=-6*e.x23/e.l23^2;
            e.q4=3*e.x23*e.y23/e.l23^2;
            e.r4=3*e.y23^2/e.l23^2;
            e.t4=-6*e.y23/e.l23^2;
            
            e.P5=-6*e.x31/e.l31^2;
            e.q5=3*e.x31*e.y31/e.l31^2;
            e.r5=3*e.y31^2/e.l31^2;
            e.t5=-6*e.y31/e.l31^2;
            
            e.P6=-6*e.x12/e.l12^2;
            e.q6=3*e.x12*e.y12/e.l12^2;
            e.r6=3*e.y12^2/e.l12^2;
            e.t6=-6*e.y12/e.l12^2;
         end
         
        function [L]=L(e,x,y)
            %Calcula las coordenadas de area para un punto del elemento. Da
            %como resultado la matriz L (L1;L2;L3)
 
            [L]=e.LMatriz*[1;x;y];
        end
end
end

