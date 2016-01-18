%Implementation of cross validation using ocv  Algorithm using trace of hat matrix

%implementation using extended algorithm
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
nSensors = 200;
noise = 0.08;
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
%lambda=.005;

lambda_grid=.4;
lambda_start =.001;
lambda_end = 1;
lambda = lambda_start:lambda_grid:lambda_end;


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
%hold on;
load DataRandom1000;  %randomXpositions  randomYpositions  randomZ
xSensors = xMin + (xMax-xMin)* (0.5 *randomXpositions(5:nSensors+4)+0.5);  % ignore first 4 samples in random list, due to fixed postions
xSensors = sort(xSensors); %Determining X posotion of sensors
ySensors = NaN(nSensors,1);
for i=1:nSensors
    ySensors(i)=dummyCurve(xSensors(i),option) + noise*randomZ(i); %Determining Y posotion of sensors
end
%plot(xSensors, ySensors, 'mo','MarkerFaceColor',[.10 1 .63]);
%--------------------------------------------------------
%CALCULATING THE ESTIMATION
%============================
%--------------------------------------------------------

for resolution = 1:5
    lambda = lambda_start:lambda_grid:lambda_end;
    for lambda_counter =1:length(lambda)
        
        
        sum_Error= 0;
        
        for i = 1 : nSensors
            [BS_value, BS_derv]=calculate_spline(knotspan,knots , nSensors,xSensors);
            
            
            %----------------------------------------------
            %calculate optimized weights by lambda for one point left out
            %------------------------------------------------
            
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
            xCal = xSensors(i);
            yCal = ySensors(i);
            [M_splines ,M_Derivatives] = calculate_spline(knotspan,knots,1, xCal);
            prediction = M_splines'*weights_opt;
            difference = prediction-yCal;
            y = ySensors;
            X = BS_value';
            H = X * inv( X' * X + lambda(lambda_counter) * eye(size(X'*X)) ) * X' ;
            %         yh_fit = H * y ;
            %         difference = ySensors(i)-yh_fit(i);
            division= ((difference)/(1 - H(i,i)));
            sum_Error = sum_Error + division.^2;
            
        end
        RMS(lambda_counter)=sqrt (sum_Error/length(ySensors));
        fprintf('average Error for lambda = %3.4f --> %3.4f \n\n', ...
            lambda(lambda_counter), RMS(lambda_counter));
        if lambda_counter > 1
            if RMS(lambda_counter-1)< RMS(lambda_counter)
                if resolution == 1
                    increament1 = -2;
                    increament2 = -1;
                end
                lambda_start = lambda(lambda_counter+increament1);
                lambda_end = lambda(lambda_counter+increament2);
                lambda_grid =lambda_grid/5;
                if resolution == 1
                    increament1 = increament1 +1;
                    increament2 = increament1 +1;
                end
                fprintf('adding more resolution\n');
                break;
            end
        end
    end
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
figure (3)%Plotting the curves
title('Smoothing spline using trace of hatmatrix')
%plot ( vector, M_splines'); %plotting optimised splines
hold on
plot ( vector ,add_M_splines, 'k-','LineWidth',1.6 )%plotting the fitting of the optimised splines
%plot( xSensors , yh_fit , 'k-','LineWidth',1.6);
plot(xVec, yVec,'g--','LineWidth',3);
%legend('Clean Data','Spines');
print_pos=max(ySensors-1);
text(xMin+.3,print_pos+.4,sprintf('Sensors =>%g', nSensors));
text(xMin+.3,print_pos+.3,sprintf('Lambda =>%g', lambda_new));
text(xMin+.3, print_pos+.2,sprintf('Number of knots=> %g', nknots +2));
text(xMin+.3,print_pos+.1,sprintf('First Value=> %g    Last value= %g ',xMin, xMax));
text(xMin+.3,print_pos+0,sprintf('Knotspan=> %g ',knotspan));
plot(xSensors, ySensors, 'mo','MarkerFaceColor',[.10 1 .63]);
hold off
toc