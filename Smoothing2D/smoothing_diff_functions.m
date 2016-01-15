%Smoothing in 2d USING DIFFERENT FUNCTIONS
close all
clear
clc
option =1;
[start ,end_point] =choose_location (option);
xyMin = start;
xyMax = end_point;
nSensors =350;
noiseLevel = 0.02;
lambda_start =[.0001];
lambda_end = .5;
lambda_same =1;

knotsPerAxis = 6;
splinesPerAxis = knotsPerAxis+2;
totalSplines = splinesPerAxis^2;
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
title('Clean Data');
hold on
surf (xx,yy,zzClean,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.5);

%taking the matrix of sensors
[XSENSORS,YSENSORS] = meshgrid ( xSensor , ySensor);
zMess = NaN(nSensors,1);
for i = 1:nSensors
    zMess(i)= dummyCurve(xSensor(i) ,option) * dummyCurve(ySensor(i),option ) +noiseLevel*randn();
end

plot3(xSensor,ySensor,zMess,'r.');
hold off


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
%axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.1 1.1]);
legend ( 'Predictor', 'Sensors');
%axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.2 1.2])
max_zMess=max(zMess);
    text(0.5, 0.5, max_zMess+.15, sprintf('noise = %g',noiseLevel));
    text(0.5, 0.5, max_zMess+.05, sprintf('nSensors %g',nSensors));
xlabel('x [n]');
ylabel('y [n]');
zlabel('z [n]');


%--------------------------------------------------
%Selection using Ordinary cross validation
%-------------------------------------------------

leftout_point = 1; % put 0 to include all the values
nSensors = nSensors-1;
if lambda_same ==1
    for lambda_counter = 1:length(lambda_start)
        xleftout = 0;
        yleftout = 0;
        zleftout = 0;
        leftout_point = 0;
        sum_Error= 0;
        
        for i = 1 : nSensors+1
            add_M_splines= 0;
            add_spline_value =0;
            leftout_point =leftout_point+1;% comment this incase only one point  or no point needs to be left out
            if isequal (leftout_point,0)
                xleftout = [xSensor(1:nSensors+1) ];
                yleftout =  [ySensor(1:nSensors+1) ];
                zleftout =  [zMess(1:nSensors+1) ];
                nSensors = nSensors +1;
                break;
            end
            if isequal(leftout_point,1)
                xleftout = [xSensor(leftout_point +1:nSensors+1) ];
                yleftout =  [ySensor(leftout_point +1:nSensors+1) ];
                zleftout =  [zMess(leftout_point +1:nSensors+1) ];
            elseif isequal(leftout_point ,nSensors+1)
                xleftout = [xSensor(1:nSensors) ];
                yleftout =  [ySensor(1:nSensors) ];
                zleftout =  [zMess(1:nSensors) ];
            else
                xleftout = [xSensor(1:leftout_point-1) ; xSensor(leftout_point+1:nSensors+1)];
                yleftout =  [ySensor(1:leftout_point-1) ; ySensor(leftout_point+1:nSensors+1)];
                zleftout = [zMess(1:leftout_point-1) ; zMess(leftout_point+1:nSensors+1)];
            end
            
            
            %[spline_value , spline_derv] = calculate_spline (knotspan,knots ,xLen , xVec); %calculating splines
            hold off
            BS = NaN(totalSplines,nSensors);
            BS=Calculate_Basis(splinesPerAxis,knotsPerAxis,xleftout,yleftout,nSensors ,xyMin,xyMax  );
            
            %----------------------------------------------
            %calculate optimized weights by lambda for one point left out
            %------------------------------------------------
            %vector=xMin:Grid_opt:xMax;
            vector = xyMin+knotspan/2:knotspan:xyMax;
            vector_length =length(vector);
            vector_span = 1:vector_length;
            BS_Hori = NaN(vector_length, vector_length);
            BS_Verti = NaN(vector_length, vector_length);
            BS_Val = NaN(vector_length, vector_length);
            
            [BS_Val, BS_Hori, BS_Verti] = Plot_Basis( splinesPerAxis,knotsPerAxis,vector,xyMin,xyMax);
            
            opt = [BS,BS_Hori*lambda_start(lambda_counter), BS_Verti*lambda_start(lambda_counter)];
            zMess_opt = [zleftout ;zeros(2*size(BS_Hori',1),1) ];
            weights_opt = opt'\zMess_opt;
            xMissing = xSensor(leftout_point);
            yMissing = ySensor(leftout_point);
            zMissing = zMess(leftout_point);
            BS_Val = NaN (totalSplines,1);
            
            p=0;
            for splineNumberHorizontal= 1:splinesPerAxis
                for splineNumberVertical= 1:splinesPerAxis
                    p = (splineNumberHorizontal-1) * splinesPerAxis +splineNumberVertical;
                    %p=p+1;
                    %count = (i-1)*splinesPerAxis+j;
                    q=1;
                    x = xMissing;
                    y = yMissing;
                    [horizontal,HorDerv] = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal);
                    [vertical,VerDerv] = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumberVertical);
                    BS_Val(p,q) =horizontal*vertical ;
                    
                end
            end
            prediction = BS_Val'*weights_opt;
            difference = prediction-zMissing;
            sum_Error = sum_Error + difference.^2;
            %fprintf('Leftout point Nr. %i at x= %3.3f y=%3.3f \tPrediction = %3.3f \tdelta = %3.3f \n', ...
            %    leftout_point, xMissing, yMissing, prediction, prediction-yMissing);
        end
        
        RMS(lambda_counter)= sqrt(sum_Error/length(zMess));
        fprintf('average Error for lambda = %3.4f --> %3.4f \n\n', ...
            lambda_start(lambda_counter), RMS(lambda_counter));
    end
    
    nSensors = nSensors+1;
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
    title ( ' Smoothing Spline parameter choosen using OCV ' );
    hold on
    plot3 ( xSensor , ySensor , zMess ,'r*');
    legend ( 'Prediction', 'Sensors');
    % axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.2 1.2]);
    %text(0.5, 0.5, 1, sprintf('\\lambda_1= %g \\lambda_2= %g',lambda_start, lambda_end));
    if lambda_same ==1
       text(0.5, 0.5, max_zMess+.35, sprintf('noise = %g',noiseLevel));
    else
        text(0.5, 0.5, max_zMess+.35, sprintf('noise = %g',noiseLevel));
    end
    
    max_zMess=max(zMess);
    text(0.5, 0.5, max_zMess+.15, sprintf('noise = %g',noiseLevel));
    text(0.5, 0.5, max_zMess+.05, sprintf('nSensors %g',nSensors));
    xlabel('x [n]');
    ylabel('y [n]');
    zlabel('z [n]');

end

toc