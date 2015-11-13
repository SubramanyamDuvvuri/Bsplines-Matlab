% plotBspline
%The basic Beginning plot , demonstratig the spline , and uniform splines form a flat surface
clear;

knots = [0 1 2 3 7];
weights = [1 1 1 1 1.5];
nKnots = length(knots);

xGrid = 10;
xMin = -4;
xMax = 12;

spanSpline = 2; % of 3rd order B-Spline

%xLen = xGrid*(xMax-xMin)+1;
xVec = xMin:1/xGrid:xMax;
xLen = length(xVec);
yVec = zeros(xLen,1);


figure(1);

for k=1:nKnots
    xStart = knots(k)-spanSpline;
    xEnd = knots(k)+spanSpline;
    xPoints = 2*spanSpline*xGrid+1;
    xIndex = (xStart-xMin)*xGrid+1;
    ySpline = NaN(xPoints,1);
    xSpline = xStart:1/xGrid:xEnd;
    
    for i=1:xPoints
        x=-spanSpline+(i-1)/xGrid;
        y = bSpline3(x);
        ySpline(i)=y;
        %yVec(xIndex+i-1)=yVec(xIndex+i-1)+ weight(k)*y;
    end
    var=weights(k)*ySpline;
    plot(xSpline, var,'r');
    hold on;
    yVec(xIndex:xIndex+xPoints-1) = yVec(xIndex:xIndex+xPoints-1) + weights(k)*ySpline;
end



plot(xVec,yVec,':');
hold off;