clear 
clc

% fprintf('Enter a function for consideration')
% fprintf (['    1-->y = 2*exp(-0.4*(x-2)^2) + 5/(x+10) + 0.1*x -0.2' ...
%             '\n  2-->y= 3^i - 2^i + exp(-5*i) + exp (-20 * (i-.5)^2)' , ...
%             ' \n 3-->y = 4.26 * (exp(-i)-4 * exp (-2*i) +3 * exp (-3 *i))'...
%             '\n 4--> y = cos(x)'...
%             '\n 5-->y = cos(x) * sin (x)'...
%             '\n 6--> y = sqrt(1-(abs(x)-1)^2), acos((1-abs(x))-pi)'...
%             '\n 7 --> y =x*x']);
% option = input ('\n>>');
option =1;
[Start_point, End_point ] = choose_location (option);
 nSensors = 100; 
noise = 0.05;
%Start_point =-2;
%End_point =2;
knotspan=knot_calculation (nSensors,Start_point,End_point); %Automatic Claculation of Knot Span --> Rupert Extimation min(n/4,40)
knots = Start_point:knotspan:End_point;

xMin = knots(1);
xMax =  knots(end);
xGrid = 10;
nknots = length(knots);
xVec= xMin:1/xGrid:xMax;
xLen = length(xVec);
yLen =length(xVec);
yVec = xMin:1/xGrid:xMax;
add_spline = 0;
add_derv=0;
[Xvec,Yvec] = meshgrid(xVec ,yVec);
Zvec = NaN(length(Xvec),length(Yvec));
for i=1:length(Xvec)
      for j = 1: length(Yvec)
      x =Xvec(i,j);
      y = Yvec(i,j);
      Zvec(i,j) = dummyCurve( x,option)*dummyCurve( y,option) ;
      end
end
figure (1);

surf (Xvec,Yvec,Zvec );



xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = sort(xSensors);
ySensors =  xMin + (xMax-xMin)*rand(nSensors,1);
ySensors = sort(ySensors);

[XSENSORS,YSENSORS]=meshgrid ( xSensors , ySensors);
ZSENSORS = NaN(length(XSENSORS),length(YSENSORS));

for i=1:nSensors
    for j =1:nSensors
    ZSENSORS(i,j)=dummyCurve(XSENSORS(i,j),option) *dummyCurve(YSENSORS(i,j),option)  + noise*randn();
    end
end
 

figure (2)
surf (XSENSORS,YSENSORS,ZSENSORS);