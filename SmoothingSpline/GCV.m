%GCV Algorithm
clc
clear
fprintf('Enter a function for consideration')
fprintf (['    1-->y = 2*exp(-0.4*(x-2)^2) + 5/(x+10) + 0.1*x -0.2' ...
            '\n  2-->y= 3^i - 2^i + exp(-5*i) + exp (-20 * (i-.5)^2)' , ...
            ' \n 3-->y = 4.26 * (exp(-i)-4 * exp (-2*i) +3 * exp (-3 *i))'...
            '\n 4--> y = cos(x)'...
            '\n 5-->y = cos(x) * sin (x)'...
            '\n 6--> y = sqrt(1-(abs(x)-1)^2), acos((1-abs(x))-pi)'...
            '\n 7 --> y =x*x']);
option = input ('\n>>');
tic
[Start_point, End_point ] = choose_location (option);
 nSensors = 100; 
noise = 0.08;
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
yVec = NaN(xLen,1);
add_spline = 0;
add_derv=0;
lambda=[0.010,.002 ,.003];
sum_Error= 0;
Grid_opt =.001;
RMS = 0;
firstKnot=knots(1);
lastKnot =knots(end);
%------------------------------------------
%PLOTTING THE TRUE DATA
%=======================
%------------------------------------------
for i=1:xLen
    yVec(i) = dummyCurve(xVec(i),option);
end
%plot(xVec, yVec,'g--','LineWidth',3);
%legend ('nknots');
hold on;
load DataRandom1000;  %randomXpositions  randomYpositions  randomZ   
xSensors = xMin + (xMax-xMin)* (0.5 *randomXpositions(5:nSensors+4)+0.5);  % ignore first 4 samples in random list, due to fixed postions
xSensors = sort(xSensors); %Determining X posotion of sensors
ySensors = NaN(nSensors,1);
for i=1:nSensors
      ySensors(i)=dummyCurve(xSensors(i),option) + noise*randomZ(i); %Determining Y posotion of sensors
end
%plot(xSensors, ySensors, 'mo','MarkerFaceColor',[.10 1 .63]);
%hold off
%--------------------------------------------------------
%CALCULATING THE ESTIMATION
%============================
%--------------------------------------------------------

for lambda_counter = 1:length(lambda)
    xleftout = 0;
    yleftout = 0;
    leftout_point = 0;
    sum_Error= 0;
    for i = 1 : nSensors
        [BS_value, BS_derv]=calculate_spline(knotspan,knots , nSensors,xSensors);
        [spline_value , spline_derv] = calculate_spline (knotspan,knots ,xLen , xVec); %calculating splines
%         ----------------------------------------------
%         calculate optimized weights by lambda for one point left out 
%         ------------------------------------------------
        add_derv_opt=0;
        M_Derivatives =NaN(nknots-1,nknots+2);
        M_splines = zeros (nknots-1,nknots+2);
        vector=xMin:Grid_opt:xMax;
        vector = Start_point+knotspan/2:knotspan:End_point; %########### less extra equations #####
        vector_length =length(vector);
        vector_span = 1:vector_length;
        [M_splines ,M_Derivatives] = calculate_spline(knotspan,knots,vector_length, vector);
        opt = [BS_value,M_Derivatives*lambda(lambda_counter)];
        ySensors_opt = [ySensors ;zeros(size(M_Derivatives',1),1) ];
        weights_opt = opt'\ySensors_opt;   %calculating the optimised weights
         xPoint = xSensors(i);
        yPoint= ySensors(i);
        [M_splines ,M_Derivatives] = calculate_spline(knotspan,knots,1, xPoint);
        prediction = M_splines'*weights_opt;
        difference = prediction-yPoint;
        
        X = BS_value';
        H = X * inv( X' * X + lambda(lambda_counter) * eye(size(X'*X)) ) * X' ;
        sum_Error = sum_Error + difference.^2;
    end
    division = sum_Error / (1- inv(length(ySensors))*trace (H)).^2;
    RMS(lambda_counter)= sqrt(division/length(ySensors));
    fprintf('average Error for lambda = %3.4f --> %3.4f \n\n', ...
    lambda(lambda_counter), RMS(lambda_counter));
end
[BS_value, BS_derv]=calculate_spline(knotspan,knots , nSensors,xSensors);
lambda_new = lambda ( find ( RMS == min (RMS)));
vector = Start_point+knotspan/2:knotspan:End_point; %########### less extra equations #####
vector_length =length(vector);
[M_splines ,M_Derivatives] = calculate_spline(knotspan,knots,vector_length, vector);
lambda_new = lambda ( find ( RMS == min (RMS)));
opt = [BS_value,M_Derivatives*lambda_new];
ySensors_opt = [ySensors ;zeros(size(M_Derivatives',1),1) ];
weights_opt = opt'\ySensors_opt;                   %calculating the optimised weights
for i = 1: nknots     %multiplying with the weights
    M_splines(i,:) = M_splines(i,:)*weights_opt(i);
end
for i = 1 : nknots
    add_M_splines = sum(M_splines);
end
y=ySensors;
H = X * inv( X' * X + lambda_new * eye(size(X'*X)) ) * X' ;
yh_fit = H * y ;
figure (2)%Plotting the curves
%plot ( vector, M_splines'); %plotting optimised splines
title('Smoothing spline using GCV')
hold on
plot ( vector ,add_M_splines, 'k-','LineWidth',1.6 )%plotting the fitting of the optimised splines
plot( xSensors , yh_fit , 'k-','LineWidth',1.6);
plot(xVec, yVec,'g--','LineWidth',3);
%legend('Clean Data','Spines');
print_pos=max(yleftout-1);
text(xMin+.3,print_pos+.4,sprintf('Sensors =>%g', nSensors));
text(xMin+.3,print_pos+.3,sprintf('Lambda =>%g', lambda_new));
text(xMin+.3, print_pos+.2,sprintf('Number of knots=> %g', nknots +2));
text(xMin+.3,print_pos+.1,sprintf('First Value=> %g    Last value= %g ',xMin, xMax));
text(xMin+.3,print_pos+0,sprintf('Knotspan=> %g ',knotspan));
plot(xSensors, ySensors, 'mo','MarkerFaceColor',[.10 1 .63]);
hold off
toc