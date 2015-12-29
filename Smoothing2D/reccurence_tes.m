clc
clear
fprintf('Enter a function for consideration')
fprintf (['    1-->y = 2*exp(-0.4*(x-2)^2) + 5/(x+10) + 0.1*x -0.2' ...
            '\n  2-->y= 3^i - 2^i + exp(-5*i) + exp (-20 * (i-.5)^2)' , ...
            ' \n 3-->y = 4.26 * (exp(-i)-4 * exp (-2*i) +3 * exp (-3 *i))'...
            '\n 4--> y = cos(x)'...
            '\n 5-->y = cos(x) * sin (x)'...
            '\n 6--> y = sqrt(1-(abs(x)-1)^2), acos((1-abs(x))-pi)'...
            '\n 7 --> y =x*x']);
%option = input ('\n>>');
option = 1;
%[Start_point, End_point ] = choose_location (option);
Start_point = -1;
End_point = 1;

knotsPerAxis = 7;
totalKnots = knotsPerAxis^2;
knotsX = linspace(Start_point, End_point, knotsPerAxis);
knotsY = linspace(Start_point, End_point, knotsPerAxis);

nSensors = 200;
noise = 0.1;
% Start_point =-5;
% End_point = 8;
knotspan=.2%knot_calculation (nSensors,Start_point,End_point); %Automatic Claculation of Knot Span --> Rupert Extimation min(n/4,40)
knots = Start_point:.2:End_point;
xMin = knots(1);
xMax =  knots(end);
xGrid = 1;
nKnots = length(knots);
xVec= xMin:1/xGrid:xMax;
xLen = length(xVec);
yVec = NaN(xLen,1);
add_spline = 0;
add_derv=0;
%lambda=.005;
lambda=1;
%lambda=[.1];
sum_Error= 0;
Grid_opt =.01;
RMS = 0;
firstKnot=knots(1);
lastKnot =knots(end);


%-------------------------------
xVec = xMin:1/10:xMax;
xVec =xVec';
x = 1:length(xVec);
yVec = NaN(length(xVec),1);
yVec = xMin:1/10:xMax;
yVec=yVec';
xLen = length(xVec);
%-------------------------------
[X,Y]=meshgrid(xVec,yVec);
Zvec= NaN (length(X),length(Y));

[Xvec,Yvec] = meshgrid(xVec ,yVec);
Zvec = NaN(length(Xvec),length(Yvec));
for i = 1:length(Xvec)
    for j = 1:length (Yvec)
        x =Xvec(i,j);
         y = Yvec(i,j);
        Zvec(i,j) = dummyCurve ( x ,1) *dummyCurve (y,1);
    end
end
%figure (3);
%plot3(Xvec,Yvec,Zvec);
 
xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = sort(xSensors);
ySensors = NaN(nSensors,1);
ySensors= xMin + (xMax-xMin)*rand(nSensors,1);


%taking the matrix of sensors

zSensors = NaN(nSensors,1);
for i = 1:nSensors
zSensors(i)= dummyCurve(xSensors(i) ,1) * dummyCurve(ySensors(i),1 ) +noise*randn();
end
hold on
plot3(xSensors,ySensors, zSensors,'y*');
surf (Xvec,Yvec,Zvec);
hold off

add1 = NaN(length( xVec), length (yVec));
add2 = NaN(length( xVec), length (yVec));
add3 = NaN(length( xVec), length (yVec));
add4 = NaN(length( xVec), length (yVec));
add5 = NaN(length( xVec), length (yVec));

for i = 1:length(xVec)
    for j = 1:length (yVec)
        x_temp=X(i,j);
        y_temp = Y(i,j);
        
         quadruple_start1=0;
         quadruple_start2=0;
         triple_start1  = 0;
         triple_start2  = 0;
         double_start1  = 0;                                       
         double_start2  = 0;
         quadruple_end1 = 0;
         quadruple_end2 = 0;
         triple_end1    = 0;
         triple_end2  = 0;
         double_end1  = 0;
         double_end2  = 0;
         basic_start1 = 0;
         basic_start2 =0;
         basic_start3=0;
         basic_start4 =0;
       for a =0
%                  %STARTING SPLINES
                     quadruple_start1 = quadruple_start1   + quadruple_reccurence_start_modified(x_temp,xMin,knotspan)        *  quadruple_reccurence_start_modified(y_temp,xMin,knotspan);%+ quadruple_reccurence_start_modified(y_temp,xMin,knotspan)        *  quadruple_reccurence_start_modified(x_temp,xMin,knotspan);
                     quadruple_start2 =  quadruple_start2   + quadruple_reccurence_start_modified(x_temp,xMin,knotspan)       *  quadruple_reccurence_end_modified(y_temp,xMax,knotspan) ;%+  quadruple_reccurence_start_modified(y_temp,xMin,knotspan)       *  quadruple_reccurence_end_modified(x_temp,xMax,knotspan);
                  quadruple_end1 = quadruple_end1       + quadruple_reccurence_end_modified(x_temp,xMax,knotspan)       *  quadruple_reccurence_end_modified(y_temp,xMax,knotspan) ;%+quadruple_reccurence_end_modified(y_temp,xMax,knotspan)       *  quadruple_reccurence_end_modified(x_temp,xMax,knotspan); 
                    quadruple_end2 = quadruple_end2       + quadruple_reccurence_end_modified(x_temp,xMax,knotspan)       *  quadruple_reccurence_start_modified(y_temp,xMin,knotspan);%+quadruple_reccurence_end_modified(y_temp,xMax,knotspan)       *  quadruple_reccurence_start_modified(x_temp,xMin,knotspan);                
% % % % % %  ------------------------------------------------------------------                 
                   triple_start1    = triple_start1      + triple_reccurence_start_modified(x_temp,xMin+a,knotspan)      *   quadruple_reccurence_start_modified(y_temp,xMin,knotspan)+ triple_reccurence_start_modified(y_temp,xMin+a,knotspan)      *   quadruple_reccurence_start_modified(x_temp,xMin,knotspan);
                      triple_start2    = triple_start2      + triple_reccurence_start_modified(x_temp,xMin,knotspan)        *  quadruple_reccurence_end_modified(y_temp,xMax,knotspan)+ triple_reccurence_start_modified(y_temp,xMin,knotspan)        *  quadruple_reccurence_end_modified(x_temp,xMax,knotspan);
                  triple_end1    = triple_end1      + triple_reccurence_end_modified(x_temp,xMax-a,knotspan)       *  quadruple_reccurence_end_modified(y_temp,xMax,knotspan)+ triple_reccurence_end_modified(y_temp,xMax-a,knotspan)       *  quadruple_reccurence_end_modified(x_temp,xMax,knotspan);  
                   triple_end2    = triple_end2      + triple_reccurence_end_modified(x_temp,xMax,knotspan)         *  quadruple_reccurence_start_modified(y_temp,xMin,knotspan)+triple_reccurence_end_modified(y_temp,xMax,knotspan)         *  quadruple_reccurence_start_modified(x_temp,xMin,knotspan);
%                   
%                   
% % % % % %  --------------------------------------------------------------------                 
                     double_start1    = double_start1      + Double_reccurence_start_modified(x_temp,xMin+a,knotspan)      *   quadruple_reccurence_start_modified(y_temp,xMin,knotspan)+ Double_reccurence_start_modified(y_temp,xMin+a,knotspan)      *   quadruple_reccurence_start_modified(x_temp,xMin,knotspan);
                   double_start2    = double_start2      + Double_reccurence_start_modified(x_temp,xMin,knotspan)        *   quadruple_reccurence_end_modified(y_temp,xMax,knotspan)+Double_reccurence_start_modified(y_temp,xMin,knotspan)        *   quadruple_reccurence_end_modified(x_temp,xMax,knotspan);                            
                   double_end1    = double_end1      + Double_reccurence_end_modified(x_temp,xMax-a,knotspan)       *   quadruple_reccurence_end_modified(y_temp,xMax,knotspan)+Double_reccurence_end_modified(y_temp,xMax-a,knotspan)       *   quadruple_reccurence_end_modified(x_temp,xMax,knotspan); 
                   double_end2    = double_end2      + Double_reccurence_end_modified(x_temp,xMax,knotspan)         *  quadruple_reccurence_start_modified(y_temp,xMin,knotspan)+Double_reccurence_end_modified(y_temp,xMax,knotspan)         *  quadruple_reccurence_start_modified(x_temp,xMin,knotspan);
% % % % % ---------------------------------------------------------------------    
                    
                     basic_start1= basic_start1 +    Basis_Spline_modified(x_temp,xMin,knotspan)  *quadruple_reccurence_start_modified(y_temp,xMin,knotspan)+Basis_Spline_modified(y_temp,xMin,knotspan) *quadruple_reccurence_start_modified(x_temp,xMin,knotspan);
                     basic_start2= basic_start2 +    Basis_Spline_modified(x_temp,xMin,knotspan)  *quadruple_reccurence_end_modified(y_temp,xMax,knotspan) +Basis_Spline_modified(y_temp,xMin,knotspan) *quadruple_reccurence_end_modified(x_temp,xMax,knotspan) ;
                   
                      basic_start3= basic_start3 +    Basis_Spline_modified(y_temp,xMax-knots(end)+knotspan,knotspan) *quadruple_reccurence_end_modified(x_temp,xMax-knots(end)+knotspan*5,knotspan)+ Basis_Spline_modified(x_temp,xMax-knots(end)+knotspan,knotspan)*quadruple_reccurence_end_modified(y_temp,xMax-knots(end)+knotspan*5,knotspan);
                      basic_start4= basic_start4 +   Basis_Spline_modified(x_temp,xMax-knots(end)+knotspan,knotspan)  *quadruple_reccurence_start_modified(y_temp,xMin,knotspan)+Basis_Spline_modified(y_temp,xMax-knots(end)+knotspan,knotspan)*quadruple_reccurence_start_modified(x_temp,xMin,knotspan);
zz= 0;
         for m = 3:nKnots
            for n =3:nKnots
                  % basic_start1= basic_start1 +    Basis_Spline_modified(x_temp,xMin-knots(m),knotspan) * Basis_Spline_modified(y_temp,xMin-knots(n),knotspan);
                    zz = zz + Basis_Spline_modified(x_temp,xMin+knotspan*2+knots(n),knotspan) *Basis_Spline_modified(y_temp,xMin+knotspan*2+knots(m),knotspan)   ;
            end
        end
        z(i,j) = zz;
         ss=0;
        for m =3
            for n =5:nKnots
                  % basic_start1= basic_start1 +    Basis_Spline_modified(x_temp,xMin-knots(m),knotspan) * Basis_Spline_modified(y_temp,xMin-knots(n),knotspan);
                    ss = ss + Basis_Spline_modified(x_temp,xMin+knots(n)+knotspan,knotspan) *Basis_Spline_modified(y_temp,xMin+knots(m)+knotspan,knotspan)   ;
            end
        end
       s(i,j)=ss;
       add1 (i,j) = quadruple_start1+ quadruple_start2+ quadruple_end1+quadruple_end2;
            add2 (i,j) =  triple_start1 + triple_start2 + triple_end1+triple_end2 ;
            add4(i,j) = double_start1+double_start2+double_end1+double_end2;
            add3(i,j)=basic_start1+basic_start2+basic_start3+basic_start4;
           dd(i,j)=basic_start3;
       end  
            
    end
end




%surfc(add1+add2+add4+z+add3+s)
surf(add1+add2+add4+z)
    







