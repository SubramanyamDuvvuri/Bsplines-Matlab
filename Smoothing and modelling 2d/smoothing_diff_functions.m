%Smoothing in 2d USING DIFFERENT FUNCTIONS

clear
clc
xyMin = -3;
xyMax = 8;
nSensors =500;
noiseLevel = 0.02;

knotsPerAxis = 7;
splinesPerAxis = knotsPerAxis+2;
knotspan = (xyMax-xyMin)/(knotsPerAxis-1);
cleanLen=30;
%splineNumber = 3;
plotSingleSplines = 0;

xVec = linspace(xyMin,xyMax,cleanLen);
yVec = linspace(xyMin,xyMax,cleanLen);
xLen = length(xVec);
yLen = length(yVec);
zVec = NaN(xLen,yLen);
sumZ = zeros(xLen,yLen);

xSensor = xyMin + (xyMax-xyMin)*rand(nSensors,1);
xSensor = sort(xSensor);
ySensor = NaN(nSensors,1);
ySensor= xyMin + (xyMax-xyMin)*rand(nSensors,1);
[xx,yy] = meshgrid(xVec, yVec);
for i = 1:cleanLen
    for j = 1:cleanLen
        x =xx(i,j);
         y = yy(i,j);
        zzClean(i,j) = dummyCurve ( x ,1) *dummyCurve (y,1);
    end
end
figure (1)
title('Clean Data');
hold on 
surf (xx,yy,zzClean,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.5);

%taking the matrix of sensors
[XSENSORS,YSENSORS] = meshgrid ( xSensor , ySensor);
zMess = NaN(nSensors,1);
for i = 1:nSensors
zMess(i)= dummyCurve(xSensor(i) ,1) * dummyCurve(ySensor(i),1 ) +noiseLevel*randn();
end

plot3(xSensor,ySensor,zMess,'r.');
hold off




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
            x = xVec(i);
            horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
            for j=1:yLen
                y = yVec(j);
                vertical = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumbervertical );
                zVec(i,j) = horizontal*vertical *weights_matrix(splineNumberHorizontal,splineNumbervertical)  ;
            end
         end

            sumZZ = sumZZ + zVec;
    end
end
figure (3)
title('regression spline')
hold on
%plot3(xSensor,ySensor,zMess,'r.');
surf(xx,yy, sumZZ,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.8);
%axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.1 1.1]);
hold off





vector = xyMin+knotspan/2:knotspan:xyMax;
vector_length =length(vector);
p=0;
q=0;
Derv = NaN(splinesPerAxis^2,nSensors);
for splineNumberHorizontal= 1:splinesPerAxis
    for splineNumberVertical= 1:splinesPerAxis
        p=p+1;
        q=0;
        for m= 1:vector_length
            for n = 1:vector_length
                q=q+1;
                x = vector (m);
                y = vector (n);
                [horizontal,HorDerv] = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal);
                [vertical,VerDerv] = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumberVertical);
                BS_Val(p,q) =horizontal*vertical ;
                BS_Derv(p,q)= HorDerv*HorDerv;
            end
        end
    end
end


lambda = 0.01;
opt = [BS,BS_Derv*lambda];
zMess_opt = [zMess ;zeros(size(BS_Derv',1),1) ];
weights_opt = opt'\zMess_opt;

weights_opt_matrix = NaN(splinesPerAxis, splinesPerAxis);
count =0;
for i =1: splinesPerAxis
    for j =1:splinesPerAxis
        count=count+1;
        weights_opt_matrix(j,i) = weights_opt(count);
    end
end

sumZZ_opt = zeros(xLen,yLen);
sumDerv_opt = zeros(xLen,yLen);
for splineNumberHorizontal = 1:splinesPerAxis
    for splineNumbervertical = 1:splinesPerAxis
        for i=1:xLen
            x = xVec(i);
            [horizontal,HorDerv] = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
            for j=1:yLen
                y = yVec(j);
                [vertical,VerDerv] = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumbervertical );
                zVec(i,j) = horizontal*vertical *weights_opt_matrix(splineNumberHorizontal,splineNumbervertical)  ;
                zVevDerv(i,j)=HorDerv*VerDerv;%*weights_opt_matrix(splineNumberHorizontal,splineNumbervertical);
                
            end
        end
        sumZZ_opt = sumZZ_opt + zVec;
        sumDerv_opt=sumDerv_opt+zVevDerv;
        
    end
end
figure (4)
surf (xx,yy,sumZZ_opt);
%axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -0.1 1.1]);
