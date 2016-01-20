%Smoothing in 2d USING DIFFERENT FUNCTIONS
clear
clc
close all
xyMin = -3;
xyMax = 6;
nSensors =500;
noiseLevel = 0.02;
lambda = .1;
num =8;

option =1 ;
knotsPerAxis = 7;
splinesPerAxis = knotsPerAxis+2;
knotspan = (xyMax-xyMin)/(knotsPerAxis-1);
cleanLen=30;
xVec = linspace(xyMin,xyMax,cleanLen);
yVec = linspace(xyMin,xyMax,cleanLen);
xLen = length(xVec);
yLen = length(yVec);
zVec = NaN(xLen,yLen);
sumZ = zeros(xLen,yLen);

xSensor = xyMin + (xyMax-xyMin)*rand(nSensors,1);
xSensor = sort(xSensor);
ySensor = NaN(nSensors,1);
ySensor= xyMin + (xyMax-xyMin)*rand(nSensors,1);
[xx,yy] = meshgrid(xVec, yVec);
for i = 1:cleanLen
    for j = 1:cleanLen
        x =xx(i,j);
         y = yy(i,j);
        zzClean(i,j) = dummyCurve ( x ,option) *dummyCurve (y,option);
    end
end
figure (1)


surf (xx,yy,zzClean,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.5);
title('Clean Data');
hold on 

%taking the matrix of sensors
[XSENSORS,YSENSORS] = meshgrid ( xSensor , ySensor);
zMess = NaN(nSensors,1);
for i = 1:nSensors
zMess(i)= dummyCurve(xSensor(i) ,option) * dummyCurve(ySensor(i),option) +noiseLevel*randn();
end

plot3(xSensor,ySensor,zMess,'r.');
legend ( 'CleanData', 'Sensors');
%axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.2 1.2])
text(1, 0.7, 7, sprintf('noise = %g',noiseLevel));
text(1, 0.9, 6.5, sprintf('nSensors %g',nSensors));
xlabel('x [n]');
ylabel('y [n]');
zlabel('z [n]');
hold off




p=0;
  BS = NaN(splinesPerAxis^2,nSensors);
  for splineNumberHorizontal= 1:splinesPerAxis
    for splineNumberVertical= 1:splinesPerAxis
        p=p+1;
        for q= 1:nSensors
            x = xSensor (q);
            y = ySensor (q);
            horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal);
            vertical = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumberVertical);
           BS(p,q) =horizontal*vertical ;%*weights(i,k) ;
        end
   end
  end
  weights = BS'\zMess;
%converting weight vector into matrix
weights_matrix = NaN(splinesPerAxis, splinesPerAxis);

count =0;
for i =1: splinesPerAxis
    for j =1:splinesPerAxis
        count=count+1;
        weights_matrix(j,i) = weights(count);
    end
end
%weights_matrix(3,4)=4;
%Plotting the regression splines
sumZZ = zeros(xLen,yLen);
for splineNumberHorizontal = 1:splinesPerAxis
    for splineNumbervertical = 1:splinesPerAxis
        for i=1:xLen
            x = xVec(i);
            horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
            for j=1:yLen
                y = yVec(j);
                vertical = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumbervertical );
                zVec(i,j) = horizontal*vertical *weights_matrix(splineNumberHorizontal,splineNumbervertical)  ;
            end
         end

            sumZZ = sumZZ + zVec;
    end
end
figure (3)

%plot3(xSensor,ySensor,zMess,'r.');

surf(xx,yy, sumZZ,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.8);
title('Estimate using Regression spline')
hold on
plot3(xSensor,ySensor,zMess,'r.');
%axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.1 1.1]);
legend ( 'CleanData', 'Sensors');
%axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.2 1.2])
text(1, 0.7, 8, sprintf('noise = %g',noiseLevel));
text(1, 0.9, 7, sprintf('nSensors %g',nSensors));
xlabel('x [n]');
ylabel('y [n]');
zlabel('z [n]');
hold off



% vector = xyMin+knotspan/2:knotspan:xyMax;
% vector_length =length(vector);
% p=0;
% q=0;
% Derv = NaN(splinesPerAxis^2,nSensors);
% for splineNumberHorizontal= 1:splinesPerAxis
%     for splineNumberVertical= 1:splinesPerAxis
%         p=p+1;
%         q=0;
%         for m= 1:vector_length
%             for n = 1:vector_length
%                 q=q+1;
%                 x = vector (m);
%                 y = vector (n);
%                 [horizontal,HorDerv] = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal);
%                 [vertical,VerDerv] = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumberVertical);
%                BS_Hori(p,q)= vertical*HorDerv;  %%%%%%%%%% Little Change RJ %%%%% [product rule -->(f.g)' = f'.g + g'+f  ]
%                 BS_Verti(p,q)= horizontal*VerDerv;
%             end
%         end
%     end
% end
% 
% 
% 
% opt = [BS,BS_Hori*lambda,  BS_ver_lambda];
% zMess_opt = [zMess ;zeros(size(BS_Derv',1),1) ];
% weights_opt = opt'\zMess_opt;
% 
% weights_opt_matrix = NaN(splinesPerAxis, splinesPerAxis);
% count =0;
% for i =1: splinesPerAxis
%     for j =1:splinesPerAxis
%         count=count+1;
%         weights_opt_matrix(j,i) = weights_opt(count);
%     end
% end
% 
% sumZZ_opt = zeros(xLen,yLen);
% sumDerv_opt = zeros(xLen,yLen);
% % for splineNumberHorizontal = 1:splinesPerAxis
% %     for splineNumbervertical = 1:splinesPerAxis
% %         for i=1:xLen
% %             x = xVec(i);
% %             [horizontal,HorDerv] = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
% %             for j=1:yLen
% %                 y = yVec(j);
% %                 [vertical,VerDerv] = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumbervertical );
% %                 zVec(i,j) = horizontal*vertical *weights_opt_matrix(splineNumberHorizontal,splineNumbervertical)  ;
% %                 
% %                 
% %             end
% %         end
% %         sumZZ_opt = sumZZ_opt + zVec;
% %        % sumDerv_opt=sumDerv_opt+zVevDerv;
% %         
% %     end
% % end
% 
% 
% surf (xx,yy,sumZZ_opt);
% %axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -0.1 1.1]);
% 
%  
%  
%  
 
 
