%New script using functions to shorten the code
clc
clear
nSensors = 120;
noise = 0.1;
Start_point =-5;
End_point = 8;
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
lamda=.005;
%lamda=[.1,2];
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
    yVec(i) = dummyCurve(xVec(i));
end
plot(xVec, yVec,'g--','LineWidth',3);
legend ('nknots');
hold on;
load DataRandom1000;  %randomXpositions  randomYpositions  randomZ   
xSensors = xMin + (xMax-xMin)* (0.5 *randomXpositions(5:nSensors+4)+0.5);  % ignore first 4 samples in random list, due to fixed postions
xSensors = sort(xSensors); %Determining X posotion of sensors
ySensors = NaN(nSensors,1);
for i=1:nSensors
      ySensors(i)=dummyCurve(xSensors(i)) + noise*randomZ(i); %Determining Y posotion of sensors
end
plot(xSensors, ySensors, 'mo','MarkerFaceColor',[.10 1 .63]);
%--------------------------------------------------------
%CALCULATING THE ESTIMATION
%============================
%--------------------------------------------------------
 leftout_point =1; % put 0 to include all the values
nSensors = nSensors -1;
for lamda_counter = 1:length(lamda)
    xleftout = 0;
    yleftout = 0;
    leftout_point = 0;
    sum_Error= 0;
    
    for i = 1 : nSensors+1
         add_M_splines= 0;
         add_spline_value =0;
         leftout_point =leftout_point +1;% comment this incase only one point  or no point needs to be left out
         if isequal (leftout_point,0)
            xleftout = [xSensors(1:nSensors+1) ];
            yleftout =  [ySensors(1:nSensors+1) ];
            nSensors = nSensors +1;
            break;
        end
        if isequal(leftout_point,1)
            xleftout = [xSensors(leftout_point +1:nSensors+1) ];
            yleftout =  [ySensors(leftout_point +1:nSensors+1) ];
        elseif isequal(leftout_point ,nSensors+1)
            xleftout = [xSensors(1:nSensors) ];
            yleftout =  [ySensors(1:nSensors) ];
        else
            xleftout = [xSensors(1:leftout_point-1) ; xSensors(leftout_point+1:nSensors+1)];
            yleftout =  [ySensors(1:leftout_point-1) ; ySensors(leftout_point+1:nSensors+1)];
        end

        [BS_value, BS_derv]=calculate_spline(knotspan,knots , nSensors,xleftout);
        weights = BS_value /yleftout'; %calculating weights
        [spline_value , spline_derv] = calculate_spline (knotspan,knots ,xLen , xVec); %calculating splines
        for i = 1: nknots     %multiplying with the weights
            spline_value(i,:) = spline_value(i,:)*weights(i);
            spline_derv(i,:) = spline_derv(i,:)*weights(i);
        end
        add_spline_value = 0;
        for i = 1 : nknots
            add_spline_value = sum(spline_value);
            add_spline_derv = sum(spline_derv);
        end
        %plot ( xVec , spline_value , 'b',xVec , add_spline_value ,'k');
        %legend('Clean Data','Noisy Measurements','Spines');
        %text(xMin+2, 2.7,sprintf('Number of knots: %g', nknots +2));
        %text(xMin+2,2.5,sprintf(' First Value %g,Last value %g ',xMin, xMax));
        hold off
        %----------------------------------------------
        %PLOTTING SMOOTINH SPLINE 
        %=========================
        %------------------------------------------------
        add_derv_opt=0;
        M_Derivatives =NaN(nknots-1,nknots+2);
        M_splines = zeros (nknots-1,nknots+2);
        %vector=xMin:Grid_opt:xMax;
        vector = Start_point+knotspan/2:knotspan:End_point; %########### less extra equations #####

        vector_length =length(vector);
        vector_span = 1:vector_length;
        [M_splines ,M_Derivatives] = calculate_spline(knotspan,knots,vector_length, vector);
        opt = [BS_value,M_Derivatives*lamda(lamda_counter)];
        yleftout_opt = [yleftout ;zeros(size(M_Derivatives',1),1) ];
        weights_opt = opt'\yleftout_opt;                   %calculating the optimised weights
        for i = 1: nknots     %multiplying with the weights
            M_splines(i,:) = M_splines(i,:)*weights_opt(i);
        end
        for i = 1 : nknots
            add_M_splines = sum(M_splines);
        end
        PUC = xSensors(i);
        position = find(abs (vector-PUC)<10^-4);
        difference=ySensors(i)- add_M_splines(position);
        sum_Error = sum_Error + difference.^2;
        RMS(lamda_counter,leftout_point) = RMSE_calculate (ySensors(i) , add_M_splines(position) );
    end
%%RMS(lamda_counter)= sqrt(sum_Error/length(ySensors));
end

figure (2)%Plotting the curves
plot ( vector, M_splines'); %plotting optimised splines
hold on
plot ( vector ,add_M_splines, 'k-','LineWidth',1.6 )%plotting the fitting of the optimised splines
plot(xVec, yVec,'g--','LineWidth',3);
%legend('Clean Data','Spines');
print_pos=max(yleftout-1);
text(xMin+1,print_pos+.4,sprintf('Sensors =>%g', nSensors));
text(xMin+1,print_pos+.3,sprintf('Lambda =>%g', lamda));
text(xMin+1, print_pos+.2,sprintf('Number of knots=> %g', nknots +2));
text(xMin+1,print_pos+.1,sprintf('First Value=> %g    Last value= %g ',xMin, xMax));
text(xMin+1,print_pos+0,sprintf('Knotspan=> %g ',knotspan));
title('After Optimisation')
plot(xleftout, yleftout, 'mo','MarkerFaceColor',[.10 1 .63]);
hold off