clear
clc
xyMin = -1;
xyMax = 1;
nSensors =200;
knotsPerAxis = 11;
splinesPerAxis = knotsPerAxis+2;
knotspan = (xyMax-xyMin)/(knotsPerAxis-1);
cleanLen=50;
splineNumber = 3;

xVec = linspace(xyMin,xyMax,cleanLen);
yVec = linspace(xyMin,xyMax,cleanLen);
xLen = length(xVec);
yLen = length(yVec);
zVec = NaN(xLen,yLen);
sumZ = zeros(xLen,yLen);
weights =rand( splinesPerAxis,splinesPerAxis);
%Basic Spline Plot
for splineNumberHorizontal = 1:splinesPerAxis
    for splineNumbervertical = 1:splinesPerAxis
        for i=1:xLen
            for j=1:yLen
                x = xVec(i);
                y = yVec(j);
                horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
                vertical = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumbervertical );
                zVec(i,j) = horizontal*vertical;
                zVec(i,j)=zVec(i,j);
            end
         end

            sumZ = sumZ + zVec;
    end
end
figure(1)
surf(xVec,yVec, sumZ);
hold off;
% 
% yVec=yVec';
% knots = linspace(xyMin,xyMax, knotsPerAxis);
% zzClean = NaN(cleanLen, cleanLen);
% FunctionType =1;
% [xx,yy] = meshgrid(xVec, yVec);
% z=0;
% for i=1:cleanLen
%     for k=1:cleanLen
%         zzClean(i,k)=getHiddenSpatialFunction(xVec(i),yVec(k), FunctionType);
%     end
% end
% figure (2)
% surf(xx,yy,zzClean','EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.6);
% hold on
% load DataSensors2D;
% for i=1:nSensors
%     x = xSensor(i);   
%     y = ySensor(i);
%     z = zMess(i);
%     c = zClean(i);
%     plot3([x x], [y y], [c z],'k');
%     plot3(x,y, c,'ro'); 
%     hold on;
%     plot3(x,y,z,'k*'); % plot of clean data with sensors
% end
% %calculating weights
%   p=0;
%   for splineNumberHorizontal= 1:splinesPerAxis
%     for splineNumberVertical= 1:splinesPerAxis
%         p=p+1;
%         for q= 1:nSensors
%             x = xSensor (q);
%             y = ySensor (q);
%             horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal);
%             vertical = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumberVertical);
%            BS(p,q) =horizontal*vertical ;%*weights(i,k) ;
%         end
%    end
%   end
% weights = BS'\zMess;
% %converting weight vector into matrix
% 
% count =0;
% for i =1: splinesPerAxis
%     for j =1:splinesPerAxis
%         count=count+1;
%         weights_matrix(j,i) = weights(count);
%     end
% end
% weights_matrix(3,4)=4;
% %Plotting the regression splines
% sumZZ = zeros(xLen,yLen);
% for splineNumberHorizontal = 1:splinesPerAxis
%     for splineNumbervertical = 1:splinesPerAxis
%         for i=1:xLen
%             for j=1:yLen
%                 x = xVec(i);
%                 y = yVec(j);
%                 horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
%                 vertical = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumbervertical );
%                 zVec(i,j) = horizontal*vertical *weights_matrix(splinesPerAxis,splinesPerAxis)  ;
%             end
%          end
% 
%             sumZZ = sumZZ + zVec;
%     end
% end
% figure(3)
% sumZZ=round(sumZZ);
% surf(xVec,yVec, sumZZ);
% hold off;
% axis([xyMin-0.1 xyMax+0.1 -0.1 1.1]);
% %Calculating smoothing spline
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
