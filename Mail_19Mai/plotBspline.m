% plotBspline
clear;

knots =   [0 1 2 3 4];
weights = [1 1 1 1 1];
nKnots = length(knots); %number od knots =5

xGrid = 10;             % variable defining x axis grid
xMin = -4;              
xMax = 12;

spanSpline = 2; % of 3rd order B-Spline

%xLen = xGrid*(xMax-xMin)+1; 
xVec = xMin:1/xGrid:xMax;           % -4:.1:-12
xLen = length(xVec);                %161
yVec = zeros(xLen,1);               

figure(1);

for k=1:nKnots
    xStart = knots(k)-spanSpline;
    xEnd = knots(k)+spanSpline;
    xPoints = 2*spanSpline*xGrid+1;         %41
    xIndex = (xStart-xMin)*xGrid+1;
    ySpline = NaN(xPoints,1);
    xSpline = xStart:1/xGrid:xEnd;
    
    for i=1:xPoints
        x=-spanSpline+(i-1)/xGrid;    %-2 to 2
        y = bSpline3(x)
        ySpline(i)=y;
        %yVec(xIndex+i-1)=yVec(xIndex+i-1)+ weight(k)*y;
    end
    
     var=weights(k)*ySpline;
     %plot(xSpline, var,'r');
     %plot (xSpline,ySpline,'+')
     hold on; 
      [xx,yy] = meshgrid(xSpline,var);
      tri = delaunay(xx,yy);
      
      for i = 1 : size(xx,1)
          for j = 1: size (xx , 2)
              %z(i,j)= bSpline3(xx (i,j))*bSpline3 (yy (i,j));
              z(i,j)= bSpline3(xx (i,j)).^bSpline3 (yy (i,j));
              
          end       
    end
      hold on
     surf(xx,yy,z)
     hold on;
  yVec(xIndex:xIndex+xPoints-1) = yVec(xIndex:xIndex+xPoints-1) + weights(k)*ySpline;
  hold on
  set(gca,'fontSize',8)
   
end

%plot (xVec,yVec,':')

%plot3(xVec,yVec,zVec,':');
hold off;




