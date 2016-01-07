clear
clc
xyMin = -1;
xyMax = 1;
nSensors =200;
knotsPerAxis=10;
knots =linspace(xyMin,xyMax,knotsPerAxis);
cleanLen= 120;
xClean= linspace(xyMin,xyMax,cleanLen);
yClean= linspace(xyMin,xyMax,cleanLen);
yClean=yClean';
zzClean = NaN(cleanLen, cleanLen);
FunctionType =1;
[xx,yy] = meshgrid(xClean, yClean);

for i=1:cleanLen
    for k=1:cleanLen
        zzClean(i,k)=getHiddenSpatialFunction(xClean(i),yClean(k), FunctionType);
    end
end
%figure (1)
surf(xx,yy,zzClean','EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.6);
hold on
load DataSensors2D;
for i=1:nSensors
    x = xSensor(i);   
    y = ySensor(i);
    z = zMess(i);
    c = zClean(i);
    plot3([x x], [y y], [c z],'k');
    plot3(x,y, c,'ro'); 
    hold on;
   plot3(x,y,z,'k*'); % plot of clean data with sensors
end
p=0;
for  i = 1:knotsPerAxis
    for j= 1:knotsPerAxis
         p=p+1;
        for q= 1:nSensors
            xs = xSensor (q);
            ys =ySensor(q);
            BS(p,q) = bSpline3(xs-knots(j)) * bSpline3(ys-knots(i));
        end
    end
end
  weights =BS'\zMess;
hold off
count =0;
for i =1: knotsPerAxis
    for j =1:knotsPerAxis
        count=count+1;
        weights1(i,j) = weights (count);
    end
end

