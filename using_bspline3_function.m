% x=linspace ( -3,3);
% 
% 
% 
% 
% for i = 1:length (x)
% 
% y(i) = bSpline3(x(i));
% end
%  plot (x,y)
% hold on
% 
% x1= linspace(-2,4);
% for i = 1:length (x)
% y1(i) = bSpline3(x(i));
% end
% 
% plot (x1,y1)
% 
% 
% 
% [X,Y]= meshgrid (x,y);
% 
% for i =1: size(X,1)
%     
%  for j=1: size(X,2)
%      Z(i,j)= bSpline3(X(i,j)) * bSpline3(Y(i,j));
%  end
% end
% surf (X,Y,Z)
%%%%%%%%%%%%%%%%%%%%%%%%

% 
% xinit=-4;
% xend=4;
% for i = 1:4
%     xinit1=xinit+i-1;
%     xend1 =xend+i-1;
% x=linspace(xinit1,xend1);
% 
%     for j = 1:length(x)
%         y(j) = bSpline3(x(j));
%     end
%     
%     figure
%   plot (x,y)
%   hold on
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 
% hold on
% 
% [X1,Y1]= meshgrid (x1,y1);
% 
% for i =1: size(X,1)
%     
%  for j=1: size(X,2)
%      Z1(i,j)= bSpline3(X1(i,j)) * bSpline3(Y1(i,j));
%  end
% end
% surf (X1,Y1,Z1)
% 
% 
% % 
% % for i=1:length(x)
% %     z(i)=interp1(x,y,i);
% % end
% % 
% % 
% % 
% % [X,Y,Z]=meshgrid (x,y,z);
% % surf(X,´Y,Z)
% %  

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

for k=1:4
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
     [xx,yy] = meshgrid(xSpline,var);
     xx
     yy
      for i = 1 : size(xx,1)
          for j = 1: size (xx , 2)
              z(i,j)= bSpline3(xx (i,j))*bSpline3 (yy (i,j));
          end
      end
      hold on
    % mesh (xx,yy,z)
     hold on;
  yVec(xIndex:xIndex+xPoints-1) = yVec(xIndex:xIndex+xPoints-1) + weights(k)*ySpline;
   
end

plot (xVec,yVec,':')

[xgrid,ygrid]=meshgrid(xVec,yVec);
for i = 1:size(xgrid,1)
    for j= 1: size(xgrid,2)
        zVec(i,j) = xgrid(i,j)*ygrid(i,j);
    
    
    end
end
figure
mesh(xgrid,ygrid,zVec) 



%plot3(xVec,yVec,zVec,':');
hold off;




