clear
clc
xyMin = -1;
xyMax = 1;
nSensors =200;
knotsPerAxis = 11;
splinesPerAxis = knotsPerAxis+2;
knotspan = (xyMax-xyMin)/(knotsPerAxis-1);

splineNumber = 3;

figure(1);
xVec = xyMin:0.02:xyMax;
yVec = xyMin:0.02:xyMax;
xLen = length(xVec);
yLen = length(yVec);
zVec = NaN(xLen,1);
sumZ = zeros(xLen,yLen);
colors = 'rgbmcykkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk';
for splineNumberHorizontal = 1:splinesPerAxis
    for splineNumberVertical =1:splinesPerAxis
        for i=1:xLen
            for j =1:yLen
                x = xVec(i);
                y= yVec (j);
                horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
                vertical = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumberVertical );
                zVec(i,j) = horizontal*vertical;
            end
        end
        plot(xVec, zVec, colors(splineNumberHorizontal));
        hold on
        sumZ = sumZ + zVec;
    end
end
plot(xVec, sumZ, 'b:');
hold off;
figure (2)                
surf (xVec,yVec,sumZ)

stop

