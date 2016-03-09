clear
clc

option = 1;
xyMin = -1;
xyMax = 1;

knotsPerAxis = 12;
totalKnots = knotsPerAxis^2;
knotsX = linspace(xyMin, xyMax, knotsPerAxis);
knotsY = linspace(xyMin, xyMax, knotsPerAxis);
load DataSensors2D %xSensor ySensor zClean zMess noiseLevel FunctionType doEquispaced
nSensors = 200;
noise = 0.1;

knotspan=.166;%knot_calculation (nSensors,Start_point,End_point); %Automatic Claculation of Knot Span --> Rupert Extimation min(n/4,40)

xGrid = 1;

createRandomVectors=0;
cleanLen = 51;
xyMin = -1;
xyMax =  1;

Nx = xyMax-xyMin;  % lenght of interva
xClean= linspace(xyMin,xyMax,cleanLen);
yClean= linspace(xyMin,xyMax,cleanLen);
yClean=yClean';
zzClean = NaN(cleanLen, cleanLen);
FunctionType =0;
[xx,yy] = meshgrid(xClean, yClean);
for i=1:cleanLen
    for k=1:cleanLen
        zzClean(i,k)=getHiddenSpatialFunction(xClean(i),yClean(k), FunctionType);
    end
end

surf(xx,yy,zzClean','EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.6);
hold on
nSensors = length(xSensor);
for i=1:nSensors
    x = xSensor(i);   
    y = ySensor(i);
    z = zMess(i);
    c = zClean(i);
    plot3([x x], [y y], [c z],'k');
    plot3(x,y, c,'ro'); 
    hold on;
    plot3(x,y,z,'k*');

end
 weights = ones((knotsPerAxis^2),1);
spline_2d=get_spline( weights ,knotsPerAxis ,knotspan,knotsX , xyMin , xyMax,xClean,yClean,xx,yy );
figure(2)
surf(spline_2d)
%surf(get_spline( weights ,knotsPerAxis ,knotspan,knotsX , xyMin , xyMax,xClean,yClean ,xx,yy));
hold off
