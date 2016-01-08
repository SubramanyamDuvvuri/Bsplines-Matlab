clear
clc
xyMin = -1;
xyMax = 1;
nSensors =200;
knotsPerAxis = 5;
splinesPerAxis = knotsPerAxis+2;
knotspan = (xyMax-xyMin)/(knotsPerAxis-1);
cleanLen=50;
%splineNumber = 3;
plotSingleSplines = 0;

xVec = linspace(xyMin,xyMax,cleanLen);
yVec = linspace(xyMin,xyMax,cleanLen);
xLen = length(xVec);
yLen = length(yVec);
zVec = NaN(xLen,yLen);
sumZ = zeros(xLen,yLen);
lambda = .2;

yVec=yVec';
knots = linspace(xyMin,xyMax, knotsPerAxis);
zzClean = NaN(cleanLen, cleanLen);
FunctionType =1;
[xx,yy] = meshgrid(xVec, yVec);
z=0;
for i=1:cleanLen
    for k=1:cleanLen
        zzClean(i,k)=getHiddenSpatialFunction(xVec(i),yVec(k), FunctionType);
    end
end
figure (1)
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
%calculating weights
  p=0;
  BS = NaN(splinesPerAxis^2,nSensors);
  for splineNumberHorizontal= 1:splinesPerAxis
    for splineNumberVertical= 1:splinesPerAxis
        p=p+1;
        for q= 1:nSensors
            x = xSensor (q);
            y = ySensor (q);
            horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal);
            vertical = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumberVertical);
           BS(p,q) =horizontal*vertical ;%*weights(i,k) ;
        end
   end
  end
weights = BS'\zMess;
%converting weight vector into matrix
weights_matrix = NaN(splinesPerAxis, splinesPerAxis);

count =0;
for i =1: splinesPerAxis
    for j =1:splinesPerAxis
        count=count+1;
        weights_matrix(j,i) = weights(count);
    end
end
%weights_matrix(3,4)=4;
%Plotting the regression splines
sumZZ = zeros(xLen,yLen);
for splineNumberHorizontal = 1:splinesPerAxis
    for splineNumbervertical = 1:splinesPerAxis
        for i=1:xLen
            for j=1:yLen
                x = xVec(i);
                y = yVec(j);
                [horizontal,derv1] = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
                [vertical,derv2] = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumbervertical );
                zVec(i,j) = horizontal*vertical *weights_matrix(splineNumberHorizontal,splineNumbervertical);
                
            end
         end

            sumZZ = sumZZ + zVec;
    end
end
figure(2)
%sumZZ=round(sumZZ);
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
surf(xx,yy, sumZZ,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.6);
%axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -0.1 1.1]);
hold off;

%Calculating smoothing spline
%------------------------------

add_derv_opt=0;
M_Derivatives =NaN(knotsPerAxis-1,knotsPerAxis+2);
M_splines = zeros (knotsPerAxis-1,knotsPerAxis+2);

vector = xyMin+knotspan/2:knotspan:xyMax;

opt = [BS,M_Derivatives*lambda];
zMess_opt = [zMess ;zeros(size(M_Derivatives',1),1) ];
weights_opt = opt'\ySensors_opt;

weights_matrix_opt = NaN(splinesPerAxis, splinesPerAxis);

count =0;
for i =1: splinesPerAxis
    for j =1:splinesPerAxis
        count=count+1;
        weights_matrix_opt(j,i) = weights(count);
    end
end

sumZZ = zeros(xLen,yLen);
for splineNumberHorizontal = 1:splinesPerAxis
    for splineNumbervertical = 1:splinesPerAxis
        for i=1:xLen
            for j=1:yLen
                x = xVec(i);
                y = yVec(j);
                [horizontal,derv1] = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
                [vertical,derv2] = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumbervertical );
                zVec(i,j) = horizontal*vertical *weights_matrix_opt(splineNumberHorizontal,splineNumbervertical);
                
            end
         end

            sumZZ = sumZZ + zVec;
    end
end
figure(3)
%sumZZ=round(sumZZ);
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
surf(xx,yy, sumZZ,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.6);
%axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -0.1 1.1]);
hold off;


