xMin = -5;
xMax= 8;
yMin=-5;
yMax=8;
nsensors = 100;
noise = 0

xSensors = xMin + (xMax-xMin)*rand(nsensors,1);
xSensors = sort(xSensors);

ySensors =  yMin + (yMax-yMin)*rand(nsensors,1);
ySensors= sort(ySensors);
[sensorX,sensorY]=meshgrid(xSensors,ySensors);

length_xSensors = length(xSensors);
length_ySensors = length (ySensors);

for i = 1:length_xSensors
    for j = 1:length_ySensors
        x1=sensorX(i,j);
        y1=sensorY(i,j);
       z1=dummyCurve(x1)*dummyCurve(y1) + noise*randn();
      % z1=dummyCurve(x1)*dummyCurve(y1)
       sensorZ(i,j)=z1;
       
    end
end

%--------------------------
KnotsX = -3:3;
KnotsY = -3:3;


[xxKnots,yyKnots]= meshgrid(KnotsX,KnotsY);

nKnotsX = length(KnotsX);
nKnotsY = length(KnotsY);
%-----------------------------

xGrid =10;
yGrid=10;
BS = NaN(nKnotsX,nsensors);



% for k=1:nKnotsX 
%   for  l = 1:nKnotsY
%     xk = xxKnots(k,l);
%     yk= yyKnots(k,l);
%     z = 0;
%     for s=1:nsensors
%         for d=1:nsensors
%            xs = xSensors(s);
%            ys = ySensors(d);
%               
%            for  m =-3:3
%                for n = -3 :3
%                 z = bSpline3(xs-xk-m)*bSpline3(ys-yk-n);
%                end 
%            end
%            
%          BS(l,s)=z;
%         end
%     end
%   end
% end
% 
% weights = BS'\sensorZ;
spanSpline = 2;

for kx=1:nKnotsX
  for ky = 1: nKnotsY
    xStart = xxKnots(kx,ky)-spanSpline;
    xEnd = xxKnots(kx,ky)+spanSpline;
    xPoints = 2*spanSpline*xGrid+1;
    xIndex = (xStart-xMin)*xGrid+1;
     xSpline = xStart:1/xGrid:xEnd;
    yStart = yyKnots(kx,ky)-spanSpline;
    yEnd = yyKnots(kx,ky)+spanSpline;
    yPoints = 2*spanSpline*yGrid+1;
    yIndex = (yStart-yMin)*xGrid+1;
    ySpline = yStart:1/yGrid:yEnd;
    [xxSpline,yySpline]=meshgrid(xSpline,ySpline);
    zzSpline = NaN(xPoints,yPoints);
    z=0;
    for i=1:xPoints
        for j = 1:yPoints
             x=-spanSpline+(i-1)/xGrid;
             y=-spanSpline+(j-1)/yGrid;
              z = bSpline3(x)*bSpline3(y);
              zzSpline(i,j)=z;
        end        
    end
    %figure(2)
  end
    surf(xxSpline, yySpline,zzSpline );
   hold on
end