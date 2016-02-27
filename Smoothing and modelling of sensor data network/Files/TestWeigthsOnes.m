clear
clc
close all
xyMin = -1;
xyMax = 1;
knotsPerAxis = 6;
splinesPerAxis = knotsPerAxis+2;
knotspan = (xyMax-xyMin)/(knotsPerAxis-1);
cleanLen=50;
%splineNumber = 3;
plotSingleSplines = 1;

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
        figure(splineNumbervertical)
        if  splineNumberHorizontal ==2&& splineNumbervertical ==1
            vvec=zVec;
       %surf(xVec,yVec, zVec);
        end
         if  splineNumberHorizontal ==2
             surf(xVec,yVec, vvec,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.3);
             hold on
        surf(xVec,yVec, zVec,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.75);
        hold off
         end
        xlabel('x[n]');
        ylabel('y[n]');
        zlabel('z[n]');
       % pause(.2);
    end
    
    end
end
% figure(1)
% surf(xVec,yVec, sumZ);
% axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -0.1 1.1]);
% axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -0.1 1.1]);
hold off;