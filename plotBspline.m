% plotBspline
clear;

knots = [0 1 2 3 6];
weights = [1 1 1 1 1.5];
nKnots = length(knots);

xGrid = 10;
xMin = -4;
xMax = 12;

spanSpline = 3; % of 3rd order B-Spline

%xLen = xGrid*(xMax-xMin)+1;
xVec = xMin:1/xGrid:xMax;
xLen = length(xVec);
yVec = zeros(xLen,1);
zVec= zeros(xLen,1);

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
%     hold on; 
%      [xx,yy] = meshgrid(xSpline,var);
%      for i = 1 : size(xx,1)
%          for j = 1: size (xx , 2)
%              z(i,j)= bSpline3(xx (i,j))*bSpline3 (yy (i,j));
%          end       
%      end
%      hold on
%     surf (xx,yy,z)
     hold on;
  yVec(xIndex:xIndex+xPoints-1) = yVec(xIndex:xIndex+xPoints-1) + weights(k)*ySpline;
   
end

%plot (xVec,yVec,':')

%plot3(xVec,yVec,zVec,':');
hold off;



