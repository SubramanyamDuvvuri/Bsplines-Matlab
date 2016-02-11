% fitB_Spline
clear all
clc
nSensors = 70;
noise = 0.1;
knots = -5:5;
nKnots = length(knots);
xMin = -5;
xMax =  5;
xGrid = 10;
xVec= xMin:1/xGrid:xMax;
xLen = length(xVec);
yVec = NaN(xLen,1);
yVec = xMin:1/xGrid:xMax;
hold on;
[Xvec,Yvec] = meshgrid(xVec ,yVec);
Zvec = NaN(length(Xvec),length(Yvec));
for i = 1:length(Xvec)
    for j = 1:length (Yvec)
        x =Xvec(i,j);
         y = Yvec(i,j);
        Zvec(i,j) = dummyCurve ( x ,1) *dummyCurve (y,1);
    end
end
figure (3);
surf(Xvec,Yvec,Zvec);
 
xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = sort(xSensors);
ySensors = NaN(nSensors,1);
ySensors= xMin + (xMax-xMin)*rand(nSensors,1);

hold on
%taking the matrix of sensors
[XSENSORS,YSENSORS] = meshgrid ( xSensors , ySensors);
zSensors = NaN(nSensors,1);
for i = 1:nSensors
zSensors(i)= dummyCurve(xSensors(i) ,1) * dummyCurve(ySensors(i),1 ) +noise*randn();
end
hold on
plot3(xSensors,ySensors, zSensors,'m*');
hold off

p =0;
for  i = 1:nKnots
    for j= 1:nKnots
         p=p+1;
        for q= 1:nSensors
            xs = xSensors (q);
            ys =ySensors(q);
            BS(p,q) = bSpline3(xs-knots(j)) * bSpline3(ys-knots(i));
        end
    end
end
  % surf(BS)
  weights =BS'\zSensors;
hold off
count =0;
for i =1: nKnots
    for j =1:nKnots
        count=count+1;
        weights1(i,j) = weights (count);
    end
end

% 
% q=0;
% for xi=1:length(Xvec)
%     for yi=1:length(Yvec)
%         x = Xvec(xi,yi);
%         y = Xvec(xi,yi);
%         z=0;
%        for xOffset = 1:nKnots
%             for yOffset = 1:nKnots
%                 horizontal= bSpline3(x-knots(xOffset));%*bSpline3(y-knots(yOffset));%W(xOffset,yOffset) ;
%                 vertical =bSpline3(y-knots(yOffset));
%                 splineproduct(xOffset,yOffset) =horizontal *vertical ;%*weights1(xOffset,yOffset);
%                 z = z+ splineproduct(xOffset,yOffset);
%             end
%         end
%         zz(xi,yi)=z;
%     end
% end
% surf(zz)