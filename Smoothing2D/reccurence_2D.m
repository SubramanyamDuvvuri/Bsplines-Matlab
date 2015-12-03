
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
option = input ('\n>>');
[Start_point, End_point ] = choose_location (option);
nSensors = 100;
noise = 0.1;
% Start_point =-5;
% End_point = 8;
knotspan=knot_calculation (nSensors,Start_point,End_point); %Automatic Claculation of Knot Span --> Rupert Extimation min(n/4,40)
knots = Start_point:knotspan:End_point;
xMin = knots(1);
xMax =  knots(end);
xGrid = 10;
nknots = length(knots);
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

xVec = xMin:.1:xMax;
x = 1:length(xVec);
yVec = xMin:.1:xMax;
[X,Y]=meshgrid(xVec,yVec);
Z= NaN (length(X),length(Y));
for i=1:length(X)
    for j =1:length(Y)
        Z(i,j) = dummyCurve(X(i,j),1)*dummyCurve(Y(i,j),1);
    end
end
figure(1)
surf(X,Y,Z);

xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = sort(xSensors);
ySensors = xSensors;

% for i=1:nSensors
%     ySensors(i)=dummyCurve(xSensors(i),1) + noise*randn();
% end

[XSENSORS,YSENSORS] = meshgrid(xSensors,ySensors);


for i = 1:nSensors
    for j = 1:nSensors
        z(i,j)=dummyCurve(XSENSORS(i,j),1)*dummyCurve(YSENSORS(i,j),1)+noise*randn();
    end
end 
figure (2)
surf (XSENSORS , YSENSORS ,z);




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
         triple_start1 = 0;
         triple_start2 = 0;
         double_start1 = 0;
         double_start2 = 0;
         quadruple_end1=0;
         quadruple_end2=0;
         triple_end1 = 0;
         triple_end2 = 0;
         double_end1 = 0;
         double_end2 = 0;
         basic_start2=0;
         basic_start3  =0;
         basic_start4 =0;
       for a =1:1:nknots-5
               %STARTING SPLINES
              quadruple_start1 = quadruple_start1   + quadruple_reccurence_start_modified(x_temp,xMin+a,knotspan)   *  quadruple_reccurence_start_modified(y_temp,xMin,knotspan);
              quadruple_start2 = quadruple_start2   + quadruple_reccurence_start_modified(x_temp,xMin,knotspan)  *   quadruple_reccurence_start_modified(y_temp,xMin+a,knotspan);              
              triple_start1    = triple_start1      + triple_reccurence_start_modified(x_temp,xMin+a,knotspan)      *   triple_reccurence_start_modified(y_temp,xMin,knotspan);
              triple_start2    = triple_start2      + triple_reccurence_start_modified(x_temp,xMin,knotspan)        *   triple_reccurence_start_modified(y_temp,xMin+a,knotspan);              
              double_start1    = double_start1      + Double_reccurence_start_modified(x_temp,xMin+a,knotspan)      *   Double_reccurence_start_modified(y_temp,xMin,knotspan);
              double_start2    = double_start2      + Double_reccurence_start_modified(x_temp,xMin,knotspan)        *   Double_reccurence_start_modified(y_temp, xMin+a,knotspan);                            
              %%ENDING SPLINES
              quadruple_end1 = quadruple_end1  + quadruple_reccurence_end_modified(x_temp,xMax-a,knotspan)    *   quadruple_reccurence_end_modified(y_temp,xMax,knotspan);
              quadruple_end2 = quadruple_end2   + quadruple_reccurence_end_modified(x_temp,xMax,knotspan)     *   quadruple_reccurence_end_modified(y_temp,xMax-a,knotspan);
              triple_end1    = triple_end1     + triple_reccurence_end_modified(x_temp,xMax-a,knotspan)       *   triple_reccurence_end_modified(y_temp,xMax,knotspan);
              triple_end2    = triple_end2     + triple_reccurence_end_modified(x_temp,xMax,knotspan)         *   triple_reccurence_end_modified(y_temp,xMax-a,knotspan);
              double_end1    = double_end1     + Double_reccurence_end_modified(x_temp,xMax-a,knotspan)       *   Double_reccurence_end_modified(y_temp,xMax,knotspan);
              double_end2    = double_end2     + Double_reccurence_end_modified(x_temp,xMax,knotspan)         *   Double_reccurence_end_modified(y_temp, xMax-a,knotspan);                            
       end 
              add1 (i,j) = quadruple_start1+ triple_start1+ double_start1;
            add2 (i,j) = quadruple_start2 + triple_start2 + double_start2;
            add3 (i,j)=  quadruple_end1+triple_end1+double_end1;
            add4 (i,j)=  quadruple_end2+triple_end2+double_end2;
            %add5 (i,j) = basic_start1 + basic_start2+basic_start3;
    end
end
for i = 1:length(xVec)
    for j = 1:length (yVec)
        x_temp=X(i,j);
        y_temp = Y(i,j);
        basic_start1 = 0;
      for shiftx= 0:1:nknots-5
        for shifty= 0:1:nknots-5
          basic_start1     =  basic_start1     + Basis_Spline_modified(x_temp,xMin+shiftx,knotspan)   * Basis_Spline_modified(y_temp,xMin+shifty,knotspan);               
        end
      end
    add5(i,j) = basic_start1;
    end
end

hold off




