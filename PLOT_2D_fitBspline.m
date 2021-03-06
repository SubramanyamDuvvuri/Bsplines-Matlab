%ExampleMesh to add 2D splines
clear
noise = 0;    % Can be changed to observe the noise
nsensors = 140;
weights = [ 0.468 0.0261 0.3314 0.0610 0.3828 0.4987 1.8069 2.7012 1.8445 0.8098 0.5679 0.7946 0.7368 0.9659 ];
%---------------------------------
knots= [-5:8];
nknots=length(knots);
xMin = knots(1);
xMax= knots(end);
yMin = knots(1);
yMax= knots(end); 

xVec = xMin-1:.1:xMax+3;
yVec= yMin-1:.1:yMax+3;
[xx,yy ] = meshgrid(xVec,yVec);
lenX = length(xVec);
lenY = length(yVec);
%zz = NaN(lenX, lenY);

%--------------------------------------------------------
%plot(xSensors,ySensors)

xSensors = xMin + (xMax-xMin)*rand(nsensors,1);
xSensors = sort(xSensors);

ySensors =  yMin + (yMax-yMin)*rand(nsensors,1);
ySensors= sort(ySensors);

[sensorX,sensorY]=meshgrid(xSensors,ySensors);

length_xSensors = length(xSensors);
length_ySensors = length (ySensors);
sensorZ=NaN(length_xSensors,length_ySensors);

for i = 1:length_xSensors
    for j = 1:length_ySensors
        x1=sensorX(i,j);
        y1=sensorY(i,j);
       z1=dummyCurve(x1)*dummyCurve(y1) + noise*randn();
      % z1=dummyCurve(x1)*dummyCurve(y1)
       sensorZ(i,j)=z1;
       
    end
end
 figure(1)
 surf(sensorX,sensorY,sensorZ)
 title(sprintf(' NOISE = %f and SENSORS = %d', noise,nsensors));
 %axis([-6 9 -6 9 0 6]);
axis auto
%++++++++++++++++++++++++++++++++++++++++ 


BS = NaN(nknots,nsensors,nknots);
for k=1:nknots
    xk = knots(k);
    for s=1:nsensors
        xs = xSensors(s);
        BS(k,s) = bSpline3(xs-xk);
    end
end
%weights = BS'\sensorZ;
%spanSpline = 2

% % % for k=1:nKnots
% % %     xStart = knots(k)-spanSpline;
% % %     xEnd = knots(k)+spanSpline;
% % %     xPoints = 2*spanSpline*xGrid+1;
% % %     xIndex = (xStart-xMin)*xGrid+1;
% % %      xSpline = xStart:1/xGrid:xEnd;
% % %     yStart = knots(k)-spanSpline;
% % %     yEnd = knots(k)+spanSpline;
% % %     yPoints = 2*spanSpline*yGrid+1;
% % %     yIndex = (yStart-yMin)*xGrid+1;
% % %     ySpline = yStart:1/yGrid:yEnd;
% % %     
% % %     
% % %     [xxSpline,yySpline]=meshgrid(xSpline,ySpline);
% % %     
% % %     
% % %     
% % %     zzSpline = NaN(xPoints,yPoints);
% % %     
% % %     z=0;
% % %     for i=1:xPoints
% % %         for j = 1:yPoints
% % %              x=-spanSpline+(i-1)/xGrid;
% % %              y=-spanSpline+(j-1)/yGrid;
% % %               z = bSpline3(x)*bSpline3(y);
% % %               zzSpline(i,j)=z;
% % %         end
% % %             
% % %     end
% % %     figure(2)
% % %     surf(xxSpline, yySpline,zzSpline*weights(k));
% % %    hold on
% % % end

for i = 1:lenX
    for j = 1:lenY
        x_temp = xx(i,j);
        y_temp = yy(i,j);
        add = 0;
        
        for shiftx = knots(1):3:knots(end)
            for shifty = knots(1):3:knots(end)
                        add = add+bSpline3(x_temp-shiftx)*bSpline3(y_temp-shifty);
            end
        end
        zz(i,j)=add;
    end
end


surf(xx,yy,zz);



         
        
        
        
        







