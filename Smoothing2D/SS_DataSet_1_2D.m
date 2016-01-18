%Smoothing using manual select_DataSetion on smoothing parameter
%WITH TEST DATA SET ONE AND TWO

tic
close all
clear
clc
select_DataSet=2;
xyMin = -1;
xyMax = 1;
nSensors =300;
noiseLevel = 0.1;
lambda_start = .007;
lambda_end = .9;
lambda_same =1; % 0 to use different lambdas , 1 for same lambdas as lambda_start and do cross validation
figNumSmooth =5;
knotsPerAxis = 5;
splinesPerAxis = knotsPerAxis+2;
totalSplines = splinesPerAxis^2;
knotspan = (xyMax-xyMin)/(knotsPerAxis-1);
cleanLen=52;
%splineNumber = 3;

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
title ( 'Clean data');
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
hold off;


%----------------------------
%Calculating smoothing spline
%----------------------------

vector = xyMin+knotspan/2:knotspan:xyMax;
vector_length =length(vector);
p=0;
q=0;
BS_Hori = NaN(vector_length, vector_length);
BS_Verti = NaN(vector_length, vector_length);
BS_Val = NaN(vector_length, vector_length);
[  BS_Val, BS_Hori, BS_Verti]= Plot_Basis( splinesPerAxis,knotsPerAxis,vector,xyMin,xyMax); %function to calculate Basis Functions

%opt = [BS,BS_Derv*lambda];
%zMess_opt = [zMess ;zeros(size(BS_Derv',1),1) ];
%algorithm to multiply higher value of lambda for for quadruple triple and
%double splines

if lambda_same ==1
    lambda_end = lambda_start;
end

squared_vector = vector_length^2;
BS_Hor_lambda = NaN (totalSplines, squared_vector);
count =0;
for i = 1:totalSplines^2
    for j = 1:splinesPerAxis
        if count == totalSplines
            break;
        elseif (j >= 1)&(j<=splinesPerAxis-3)
            count = count +1;
            BS_Hor_lambda(count,:) = BS_Hori (count,:)*lambda_start(1);
            BS_ver_lambda (count,:) =BS_Verti ( count,:) *lambda_start(1);
        elseif (j > splinesPerAxis-3) & (j<=splinesPerAxis)
            count = count +1;
            BS_Hor_lambda(count,:) =BS_Hori (count,:)*lambda_end(1);
            BS_ver_lambda (count,:) =BS_Verti( count,:) *lambda_end(1);
            
        end
    end
end

%opt = [BS,BS_Hori*lambda, BS_Verti*lambda];
opt = [BS,BS_Hor_lambda,  BS_ver_lambda];
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
    text(0.5, 0.5, 1, sprintf('\\lambda = %g',lambda_start(1)));
else
    text(0.5, 0.5, 1, sprintf('\\lambda_1 = %g \\lambda_2 = %g',lambda_start(1), lambda_end));
end
if select_DataSet == 1
    text(0.5, 0.5, .9, sprintf('noise = %g',noiseLevel));
    text(0.5, 0.5, .8, sprintf('nSensors %g',nSensors));
    xlabel('x [n]');
    ylabel('y [n]');
    zlabel('z [n]');
else
    text(0.5, 0.7, .75, sprintf('noise = %g',noiseLevel));
    text(0.5, 0.9, .5, sprintf('nSensors %g',nSensors));
    xlabel('x [n]');
    ylabel('y [n]');
    zlabel('Temperature [°C]');
end
%fprintf('Lambda1 was %g  and Lambda2 was %g \n',lambda_start ,lambda_end );
toc