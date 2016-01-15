clear
clc
xyMin = -1;
xyMax = 1;
knotsPerAxis = 11;
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
%weights =rand( splinesPerAxis,splinesPerAxis);
weights =ones( splinesPerAxis,splinesPerAxis);
%Basic Spline Plot
for splineNumberHorizontal = 1:splinesPerAxis
    for splineNumbervertical = 1:splinesPerAxis
        for i=1:xLen
            x = xVec(i);
            horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
            for j=1:yLen
                y = yVec(j);
                vertical = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumbervertical );
                zVec(i,j) = horizontal*vertical*weights(splineNumberHorizontal,splineNumbervertical);
                %zVec(i,j)=zVec(i,j);
            end
        end
    if(plotSingleSplines)
        figure(2)
        surf(xVec,yVec, zVec);
        pause(0.2);
    end
    
    sumZ = sumZ + zVec;
    end
end
figure(1)
surf(xVec,yVec, sumZ);
title('Open Uniform B-Spline');
hold on
axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -0.1 1.1]);
axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -0.1 1.1]);
xlabel('x [n]');
ylabel('y [n]');
zlabel('z [n]');
hold off;