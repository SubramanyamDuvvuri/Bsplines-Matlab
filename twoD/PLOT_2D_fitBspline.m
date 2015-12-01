%ExampleMesh to add 2D splines
clear 
clc

fprintf('Enter a function for consideration')
fprintf (['    1-->y = 2*exp(-0.4*(x-2)^2) + 5/(x+10) + 0.1*x -0.2' ...
            '\n  2-->y= 3^i - 2^i + exp(-5*i) + exp (-20 * (i-.5)^2)' , ...
            ' \n 3-->y = 4.26 * (exp(-i)-4 * exp (-2*i) +3 * exp (-3 *i))'...
            '\n 4--> y = cos(x)'...
            '\n 5-->y = cos(x) * sin (x)'...
            '\n 6--> y = sqrt(1-(abs(x)-1)^2), acos((1-abs(x))-pi)'...
            '\n 7 --> y =x*x']);
option = input ('\n>>');
[Start_point, End_point ] = choose_location (option);
 nSensors = 100; 
noise = 0.05;
%Start_point =-2;
%End_point =2;
knotspan=knot_calculation (nSensors,Start_point,End_point); %Automatic Claculation of Knot Span --> Rupert Extimation min(n/4,40)
knots = Start_point:knotspan:End_point;

xMin = knots(1);
xMax =  knots(end);
xGrid = 10;
nknots = length(knots);
xVec= xMin:1/xGrid:xMax;
xLen = length(xVec);
yLen =length(xVec);
yVec = xMin:1/xGrid:xMax;
add_spline = 0;
add_derv=0;
[Xvec,Yvec] = meshgrid(xVec ,yVec);
Zvec = NaN(length(Xvec),length(Yvec));
for i=1:length(Xvec)
      for j = 1: length(Yvec)
      x =Xvec(i,j);
      y = Yvec(i,j);
      Zvec(i,j) = dummyCurve( x,option)*dummyCurve( y,option) ;
      end
end
figure (1);

surf (Xvec,Yvec,Zvec );



xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = sort(xSensors);
ySensors =  xMin + (xMax-xMin)*rand(nSensors,1);
ySensors = sort(ySensors);

[XSENSORS,YSENSORS]=meshgrid ( xSensors , ySensors);
ZSENSORS = NaN(length(XSENSORS),length(YSENSORS));

for i=1:nSensors
    for j =1:nSensors
    ZSENSORS(i,j)=dummyCurve(XSENSORS(i,j),option) *dummyCurve(YSENSORS(i,j),option)  + noise*randn();
    end
end
 

figure (2)
surf (XSENSORS,YSENSORS,ZSENSORS);

% xKnots = length(knots);
% yKnots =length (knots);
% meshknots = meshgrid (knots);
% 
% for i = 1: 1
%     for j = 1 : 1
%         xk = meshknots (i,j);
%         for p = 1:nSensors
%             for q = 1:nSensors
%                 xs = XSENSORS(p,q);
%                 ys= YSENSORS (p,q);
%                 BS(i,j,p,q) = bSpline3(xs-xk) * bSpline3(ys-xk);
%             end
%         end   
%     end
% end
% weights = BS'\ZSENSORS;
% 
% 
% 
% 
% 
% 
% for i = n:xKnots
%     for j = 1:yKnots
%         
% 
% 
% %   BS = zeros(100,24,24);
% for k=1:nknots
for k = 1:nknots
for i=1:nknots
    for j=1:nSensors
        xs = xSensors(j);
        BS(i,j) = bSpline3(xs-knots(i))*bSpline3(xSensors(j)-knots(i));
    end
end
g (:,:,k)=BS;
end
%weights2 = BS'\ySensors;
% end
%WEIGHTS=meshgrid(weights);
% 
% for i = 1:length(xVec)
%     for j = 1:length (yVec)
%         x_temp=Xvec(i,j);
%         y_temp = Yvec(i,j);
%         
%          quadruple_start1=0;
%         
%          
%         for a =0:.1:nknots-1
%             
%                 
%             %STARTING SPLINES
%                 
%             quadruple_start1 = quadruple_start1   + bSpline3(x_temp-xMin+a)   *  bSpline3(y_temp-xMin) *WEIGHTS(i,j);
% 
%     end
%     end
% end
% 
% %plotting the curve with noise
% % % % % %--------------------------------------------------------
% % % % % %plot(xSensors,ySensors)
% % % % % 
% % % % % xSensors = xMin + (xMax-xMin)*rand(nsensors,1);
% % % % % xSensors = sort(xSensors);
% % % % % 
% % % % % ySensors =  yMin + (yMax-yMin)*rand(nsensors,1);
% % % % % ySensors= sort(ySensors);
% % % % % 
% % % % % [sensorX,sensorY]=meshgrid(xSensors,ySensors);
% % % % % 
% % % % % length_xSensors = length(xSensors);
% % % % % length_ySensors = length (ySensors);
% % % % % sensorZ=NaN(length_xSensors,length_ySensors);
% % % % % sensorsZ2=NaN(length_xSensors,length_ySensors);
% % % % % 
% % % % % for i = 1:length_xSensors
% % % % %     for j = 1:length_ySensors
% % % % %         x1=sensorX(i,j);
% % % % %         y1=sensorY(i,j);
% % % % %        z1=dummyCurve(x1)*dummyCurve(y1) ;
% % % % %        z2=dummyCurve(x1)*dummyCurve(y1) + noise*randn();
% % % % %        %z1=dummyCurve(x1)*dummyCurve(y1)  + noise*randn();
% % % % %       % z1=dummyCurve(x1)*dummyCurve(y1)
% % % % %        sensorZ(i,j)=z1;
% % % % %        sensorsZ2(i,j)=z2;
% % % % %        
% % % % %     end
% % % % % end
% % % % %  figure(1)
% % % % %  surf(sensorX,sensorY,sensorZ)
% % % % %  hold on 
% % % % %   surf(sensorX,sensorY,sensorsZ2)
% % % % %  title(sprintf(' NOISE = %f and SENSORS = %d', noise,nsensors));
% % % % %  %axis([-6 9 -6 9 0 6]);
% % % % %  hold off
% % % % %  knots = -5:8;
% % % % %  nKnots = length(knots);
% % % % % axis auto
% % % % % %+++++++++++++++++++++++++++++++++++++++++
% % % % % weights = [ 0.468 0.0261 0.3314 0.0610 0.3828 0.4987 1.8069 2.7012 1.8445 0.8098 0.5679 0.7946 0.7368 0.9659 ];
% % % % % BS = NaN(nKnots,nsensors);
% % % % % for k=1:nKnots
% % % % %     xk = knots(k);
% % % % %     for s=1:nsensors
% % % % %         xs = xSensors(s);
% % % % %         BS(k,s) = bSpline3(xs-xk);
% % % % %     end
% % % % % end
% % % % % %now get the weights by Penrose Pseudo Inverse
% % % % % weights = BS'\ySensors;
% % % % % % % 
% % % % %  
% % % % % % % nKnots = length(knots);
% % % % % % % xGrid =10;
% % % % % % % yGrid=10;
% % % % % % % BS = NaN(nKnots,nsensors,nKnots,nsensors);
% % % % % % % Knots_mesh=meshgrid(knots);
% % % % % % % for k1=1:nKnots
% % % % % % %     for k2 = 1:nKnots
% % % % % % %         xk = Knots_mesh(k1,k2);
% % % % % % %          for s1=1:nsensors
% % % % % % %              for  s2 = 1:nsensors   
% % % % % % %                  xs = sensorX(s1,s2);
% % % % % % %                  BS(k1,s1,k2,s2) = bSpline3(xs-xk)*bSpline3(xs-xk);
% % % % % % %             end 
% % % % % % %          end
% % % % % % %     end
% % % % % % % end
% % % % % weights = BS'\ySensors;
% % % % % spanSpline = 2;
% % % % % 
% % % % % for k=1:nKnots
% % % % %     xStart = knots(k)-spanSpline;
% % % % %     xEnd = knots(k)+spanSpline;
% % % % %     xPoints = 2*spanSpline*xGrid+1;
% % % % %     xIndex = (xStart-xMin)*xGrid+1;
% % % % %      xSpline = xStart:1/xGrid:xEnd;
% % % % %     yStart = knots(k)-spanSpline;
% % % % %     yEnd = knots(k)+spanSpline;
% % % % %     yPoints = 2*spanSpline*yGrid+1;
% % % % %     yIndex = (yStart-yMin)*xGrid+1;
% % % % %     ySpline = yStart:1/yGrid:yEnd;
% % % % %     
% % % % %     
% % % % %     [xxSpline,yySpline]=meshgrid(xSpline,ySpline);
%      
% % % % %     zzSpline = NaN(xPoints,yPoints);
% % % %     
% % % %     z=0;
% % % %     for i=1:xPoints
% % % %         for j = 1:yPoints
% % % %              x=-spanSpline+(i-1)/xGrid;
% % % %              y=-spanSpline+(j-1)/yGrid;
% % % %               z = bSpline3(x)*bSpline3(y);
% % % %               zzSpline(i,j)=z;
% % % %         end
% % % %             
% % % %     end
% % % %     figure(2)
% % % %     surf(xxSpline, yySpline,zzSpline*weights(k));
% % % %    hold on
% % % % end
 
% % % % % for xi=1:lenX
% % % % %     for yi=1:lenY
% % % % %         x = xx(xi,yi);
% % % % %         y = yy(xi,yi);
% % % % %         
% % % % %         z=0;
% % % % %         
% % % % %         for xOffset =-1
% % % % %           for  yOffset =-1
% % % % %                 z = bSpline3(x-xOffset)*dummyCurve(y-yOffset)
% % % % %           end
% % % % %         end
% % % % %         zz(xi,yi)=z;
% % % % %     end
% % % % % end
% % % % % 
% % % % % figure(1);
% % % % % h=surf(xx,yy,zz');
% % % % % title('Idle Curve without noise');

% % % % 
% % % % % 
% % % % % xlabel('x-->')
% % % % % ylabel('<--y')
% % % % % zlabel('z-->')