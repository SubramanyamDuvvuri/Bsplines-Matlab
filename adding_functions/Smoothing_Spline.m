%New script using functions to shorten the code
clc
clear
nSensors = 100;
noise = 0.1;
Start_point =-6;
End_point = 7;
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
lamda=[.001,1];
%lamda=[.1];
sum_Error= 0;
Grid_opt =.1;
RMS = 0;


for i=1:xLen
    yVec(i) = dummyCurve(xVec(i));
    %yVec (i) = example_curve (xVec(i));
    %yVec (i) = example_curve_2 (xVec(i)); %knot value should be 0:1    
end

plot(xVec, yVec,'g--','LineWidth',3);
legend ('nknots');
hold on;
load DataRandom1000;  %randomXpositions  randomYpositions  randomZ   


xSensors = xMin + (xMax-xMin)* (0.5 *randomXpositions(5:nSensors+4)+0.5);  % ignore first 4 samples in random list, due to fixed postions
xSensors = sort(xSensors); %Determining X posotion of sensors
ySensors = NaN(nSensors,1);



for i=1:nSensors
      ySensors(i)=dummyCurve(xSensors(i)) + noise*randomZ(i); %Determining Y posotion of sensors
end
plot(xSensors, ySensors, 'mo','MarkerFaceColor',[.10 1 .63]);


BS1 = NaN(nSensors);
firstKnot=knots(1);
lastKnot =knots(end);
count = 1;

for s=1:nSensors
 xs = xSensors(s) ;
BS1(:,s) = Calculate_BS (s,xs , firstKnot , lastKnot , knotspan,nknots,knots);
count = count +1;
end
