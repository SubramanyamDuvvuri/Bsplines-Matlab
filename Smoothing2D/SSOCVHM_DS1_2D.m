%Contains code to find optimised smoothing parameter using ordinary cross validation.

%WITH DATA SET ONE

tic
close all
clear
clc
xyMin = -1;
xyMax = 1;
nSensors =250;
noiseLevel = 0.1;
lambda_start = .0001:.0001:.0007;
lambda_end = .5;
lambda_same =1; RMS=NaN(length(lambda_start),1);% 0 to use different lambdas , 1 for same lambdas as lambda_start and do cross validation
RMS=NaN(length(lambda_start),1);
knotsPerAxis = 5;
splinesPerAxis = knotsPerAxis+2;
totalSplines = splinesPerAxis^2;
knotspan = (xyMax-xyMin)/(knotsPerAxis-1);
cleanLen=30;
select_DataSet =1;

xVec = linspace(xyMin,xyMax,cleanLen);
yVec = linspace(xyMin,xyMax,cleanLen);
xLen = length(xVec);
yLen = length(yVec);
zVec = NaN(xLen,yLen);
sumZ = zeros(xLen,yLen);

yVec=yVec';
knots = linspace(xyMin,xyMax, knotsPerAxis);
zzClean = NaN(cleanLen, cleanLen);
FunctionType =1;
doEquispaced = 0;
if select_DataSet ==1
    [xSensor, ySensor, zClean, zMess, CleanRef] = generateTestData2D(nSensors, noiseLevel, FunctionType, doEquispaced);
elseif select_DataSet ==2
    [SensorData, CleanData] = loadTestData(nSensors, noiseLevel, 'f', 'r');
    xSensor = SensorData.x;
    ySensor = SensorData.y;
    zMess = SensorData.zMess;
    zClean = SensorData.zClean;
    xVec = CleanData.xVec;
    yVec = CleanData.yVec;
    zzClean = CleanData.zMatrix;
end

[xx,yy] = meshgrid(xVec, yVec);
z=0;
if select_DataSet ==1
    for i=1:cleanLen
        for k=1:cleanLen
            zzClean(i,k)=getHiddenSpatialFunction(xVec(i),yVec(k), FunctionType);
        end
    end
end
figure (1)

surf(xx,yy,zzClean','EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.5);title ( 'Clean data');
hold on
plot3 ( xSensor , ySensor , zMess ,'r*');
legend ( 'CleanData', 'Sensors');
axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.2 1.2])
text(0.5, 0.7, .75, sprintf('noise = %g',noiseLevel));
text(0.5, 0.9, .5, sprintf('nSensors %g',nSensors));
xlabel('x [n]');
ylabel('y [n]');
zlabel('z [n]');
hold off
%calculating Basis of B-SPlines
%matrix  BS represents Basis
%The rows of the matrix represent spline number and the colomns represent sensors
BS= Calculate_Basis( splinesPerAxis,knotsPerAxis,xSensor,ySensor,nSensors ,xyMin,xyMax  ); % Function to calculate Basis functions
weights = BS'\zMess; % calculating the weights usi
%converting weight vector into matrix
weights_matrix = NaN(splinesPerAxis, splinesPerAxis);
count =0;
for i =1: splinesPerAxis
    for j =1:splinesPerAxis
        count=count+1;
        weights_matrix(j,i) = weights(count);
    end
end
%Plotting the regression splines using the calculated weights
zz=plot_Spline( splinesPerAxis,knotsPerAxis, xVec,yVec,xyMin,xyMax,weights_matrix); % Function to plot the splines
figure(2)

surf(xx,yy,zz,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.5);title ( 'Clean data');
title ( 'Regression Spline') ;

hold on
plot3 ( xSensor , ySensor , zMess ,'r*');
axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.1 1.1]);
legend ( 'Predictor', 'Sensors');
axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.2 1.2])
text(0.5, 0.7, .75, sprintf('noise = %g',noiseLevel));
text(0.5, 0.9, .5, sprintf('nSensors %g',nSensors));
xlabel('x [n]');
ylabel('y [n]');
zlabel('z [n]');


%--------------------------------------------------
%Selection using Ordinary cross validation
%-------------------------------------------------

leftout_point = 1; % put 0 to include all the values

if lambda_same ==1
    for lambda_counter = 1:length(lambda_start)
        xleftout = 0;
        yleftout = 0;
        zleftout = 0;
        leftout_point = 0;
        sum_Error= 0;
        
        parfor i = 1 : nSensors
            [BS]=Calculate_Basis(splinesPerAxis,knotsPerAxis,xSensor,ySensor,nSensors ,xyMin,xyMax  );%-----
            
            %----------------------------------------------
            %calculate optimized weights by lambda 
            %------------------------------------------------
         
            vector = xyMin+knotspan/2:knotspan:xyMax;
            vector_length =length(vector);
            BS_Hori = NaN(vector_length, vector_length);
            BS_Verti = NaN(vector_length, vector_length);
            BS_Val = NaN(vector_length, vector_length);
            
            [BS_Val, BS_Hori, BS_Verti] = Plot_Basis( splinesPerAxis,knotsPerAxis,vector,xyMin,xyMax);%-----
            
            opt = [BS,BS_Hori*lambda_start(lambda_counter), BS_Verti*lambda_start(lambda_counter)];
            zMess_opt = [zMess ;zeros(2*size(BS_Hori',1),1) ];
            weights_opt = opt'\zMess_opt;
            xCal = xSensor(i);
            yCal = ySensor(i);
            zCal =zMess(i);
            M_Splines = NaN (totalSplines,1);
             p=0;

            M_Splines= Basis_cal_one_point ( splinesPerAxis,knotsPerAxis,xCal,yCal,xyMin,xyMax);
           
            prediction = M_Splines'*weights_opt;
            difference = prediction-zCal;
            
            X = BS';
            H = X * inv( X' * X + lambda_start(lambda_counter) * eye(size(X'*X)) ) * X' ;
          
            division= ((difference)/(1 - H(i,i)));
            sum_Error = sum_Error + division.^2;
        end
        
        RMS(lambda_counter)= sqrt(sum_Error/length(zMess));
        fprintf('average Error for lambda = %3.4f --> %3.4f \n\n', ...
            lambda_start(lambda_counter), RMS(lambda_counter));
        
    end
    
    BS= Calculate_Basis( splinesPerAxis,knotsPerAxis,xSensor,ySensor,nSensors ,xyMin,xyMax  );
    vector = xyMin+knotspan/2:knotspan:xyMax;
    vector_length =length(vector);
    vector_span = 1:vector_length;
    [BS_Val, BS_Hori, BS_Verti]= Plot_Basis( splinesPerAxis,knotsPerAxis,vector,xyMin,xyMax);
    lambda_new = lambda_start ( find ( RMS == min (RMS)));
    opt = [BS,BS_Hori*lambda_new, BS_Verti*lambda_new];
    %opt = [BS,BS_Hori*lambda, BS_Verti*lambda]
    zMess_opt = [zMess ;zeros(2*size(BS_Hori',1),1) ];
    
    weights_opt = opt'\zMess_opt;
    
    weights_opt_matrix = NaN(splinesPerAxis, splinesPerAxis);
    count =0;
    for i =1: splinesPerAxis
        for j =1:splinesPerAxis
            count=count+1;
            weights_opt_matrix(j,i) = weights_opt(count);
        end
    end
    
    zz= plot_Spline( splinesPerAxis,knotsPerAxis, xVec,yVec,xyMin,xyMax,weights_opt_matrix); % function to plot spline
    figure (3)
    
    surf (xx,yy,zz,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.5);
    title ( ' Smoothing Spline parameter choosen manually ' );
    hold on
    plot3 ( xSensor , ySensor , zMess ,'r*');
    legend ( 'Prediction', 'Sensors');
    axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.2 1.2]);
    %text(0.5, 0.5, 1, sprintf('\\lambda_1= %g \\lambda_2= %g',lambda_start, lambda_end));
    if lambda_same ==1
        text(0.5, 0.5, 1, sprintf('\\lambda = %g',lambda_new));
    else
        text(0.5, 0.5, 1, sprintf('\\lambda_1 = %g lambda_2 = %g',lambda_new, lambda_end));
    end
    
    text(0.5, 0.7, .75, sprintf('noise = %g',noiseLevel));
    text(0.5, 0.9, .5, sprintf('nSensors %g',nSensors));
    xlabel('x [n]');
    ylabel('y [n]');
    zlabel('z [n]');
end

toc