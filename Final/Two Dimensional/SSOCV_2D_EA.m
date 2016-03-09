%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Date of completion of code : 25-Feb-2016
%Contains code to find optimised smoothing parameter using ordinary cross
%validation  in two dimensions
%Comparision has been made between the estimation through smoothing
%and clean data AND estimation through regression and clean data
%Two data sets have been used for comparision
%One generated through mathematical functions, other through COMSOL.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
clear
clc
close
noiseLevel_vec =[.03];%[ 0.8,.1,.13,.17,.2];
for noisevec =1:length(noiseLevel_vec)
    noiseLevel = noiseLevel_vec(noisevec);
    select_DataSet =2; % SELECT THE DATA SET TO BE USED (1,2)
    xyMin = -1;
    xyMax = 1;
    nSensors =[200];
    for q = 1: length(nSensors)
        
        knotsPerAxis = [8];
        for knotnumber =1:length(knotsPerAxis)
            splinesPerAxis = knotsPerAxis(knotnumber)+2;
            totalSplines = splinesPerAxis^2;
            knotspan = (xyMax-xyMin)/(knotsPerAxis(knotnumber)-1);
            cleanLen=51;
            
            lambda_grid=.4;
            lambda_start =.0001;                            %Setting the starting value of lambda
            lambda_end = 10;
            lambda = lambda_start:lambda_grid:lambda_end;
            % RMS=NaN(20 ,1);
            xVec = linspace(xyMin,xyMax,cleanLen);
            yVec = linspace(xyMin,xyMax,cleanLen);
            xLen = length(xVec);
            yLen = length(yVec);
            zVec = NaN(xLen,yLen);
            sumZ = zeros(xLen,yLen);
            yVec=yVec';
            knots = linspace(xyMin,xyMax, knotsPerAxis(knotnumber));
            zzMatrix = NaN(cleanLen, cleanLen);
            FunctionType =1;
            doEquispaced = 0;
            if select_DataSet ==1
                [xSensor, ySensor, zClean, zMess, CleanRef] = generateTestData2D(nSensors(q), noiseLevel, FunctionType, doEquispaced);
                xSensor(1:4)=[-1,-1,1,1];
                ySensor(1:4)=[-1,1,-1,1];
                zzMatrix = CleanRef.zzMatrix;
            elseif select_DataSet ==2
                [SensorData, CleanData] = loadTestData(nSensors(q), noiseLevel, 'f', 'r');
                xSensor = SensorData.x;
                ySensor = SensorData.y;
                zMess = SensorData.zMess;
                zClean = SensorData.zClean;
                xVec = CleanData.xVec;
                yVec = CleanData.yVec;
                zzMatrix = CleanData.zMatrix;
            end
            [xx,yy] = meshgrid(xVec, yVec);
            z=0;
            if select_DataSet ==1
                for i=1:cleanLen
                    for k=1:cleanLen
                        zzMatrix(i,k)=getHiddenSpatialFunction(xVec(i),yVec(k), FunctionType);
                    end
                end
            end
            figure (1)
            surf(xx,yy,zzMatrix','EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.5);title ( 'Clean data');
            hold on
            plot3 ( xSensor , ySensor , zMess ,'r*');
            legend ( 'CleanData', 'Sensors');
            axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.2 1.2])
            text(0.5, 0.7, .75, sprintf('noise = %g',noiseLevel));
            text(0.5, 0.9, .5, sprintf('nSensors= %g',nSensors(q)));
            xlabel('x [n]');
            ylabel('y [n]');
            zlabel('z [n]');
            hold off
            fprintf('nSensors(q)= %3.5f  \n',nSensors(q));
            fprintf('Noise= %3.5f  \n',noiseLevel);
            fprintf('Splines= %3.5f  \n',totalSplines);
            
            
            
            %calculating Basis of B-SPlines
            %matrix  BS represents Basis
            %The rows of the matrix represent spline number and the colomns represent sensors
            BS= Calculate_Basis( splinesPerAxis,knotsPerAxis(knotnumber),xSensor,ySensor,nSensors(q) ,xyMin,xyMax); % Function to calculate Basis functions
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
            zz_rs=plot_Spline( splinesPerAxis,knotsPerAxis(knotnumber), xVec,yVec,xyMin,xyMax,weights_matrix); % Function to plot the splines
            figure(2)
            surf(xx,yy,zz_rs,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.5);
            title ( 'Estimation through Regression');
            hold on
            plot3 ( xSensor , ySensor , zMess ,'r*');
            axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.1 1.1]);
            legend ( 'Predictor', 'Sensors');
            axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.2 1.2])
            text(0.5, 0.7, max(zMess+1.5), sprintf('noise = %g',noiseLevel));
            text(0.5, 0.9, max(zMess+1), sprintf('nSensors %g',nSensors(q)));
            text(0.5, 0.9, max(zMess+2), sprintf('Total Splines %g',totalSplines));
            xlabel('x [n]');
            ylabel('y [n]');
            zlabel('z [n]');
            sumError=0;
            for i=1:cleanLen
                for k=1:cleanLen
                    error = zz_rs(k,i)-zzMatrix(i,k);
                    sumError = sumError +error^2;
                end
            end
            RMSE = sqrt(sumError/(cleanLen*cleanLen));
            fprintf('RMSE of Regression Spline = %3.5f \n',RMSE);
            %--------------------------------------------------
            %Selection using Ordinary cross validation
            %-------------------------------------------------
            leftout_point = 1; 
            nSensors(q) = nSensors(q)-1;
            resolution_vec =[1:4];
            for resolution = 1:length(resolution_vec)
                lambda = lambda_start:lambda_grid:lambda_end;
                
                for lambda_counter =1:length(lambda)
                    count =0 ;
                    xleftout = 0;
                    yleftout = 0;
                    zleftout = 0;
                    leftout_point = 0;
                    sum_Error= 0;
                    nSensors1 =nSensors(q);
                    for i = 1 : nSensors1+1
                        add_M_splines= 0;
                        add_spline_value =0;
                          leftout_point =leftout_point+1;
                        if isequal (leftout_point,0)
                            xleftout = xSensor(nSensors1+1);
                            yleftout = ySensor(nSensors1+1);
                            zleftout = zMess(nSensors1+1);
                            nSensors(q) = nSensors1 +1;
                            break;
                        end
                        if isequal(leftout_point,1)
                            xleftout = xSensor(leftout_point +1:nSensors1+1);
                            yleftout = ySensor(leftout_point +1:nSensors1+1);
                            zleftout = zMess(leftout_point +1:nSensors1+1);
                        elseif isequal(leftout_point ,nSensors1+1)
                            xleftout = xSensor(1:nSensors1);
                            yleftout = ySensor(1:nSensors1);
                            zleftout = zMess(1:nSensors1);
                        else
                            xleftout = [xSensor(1:leftout_point-1) ; xSensor(leftout_point+1:nSensors(q)+1)];
                            yleftout =  [ySensor(1:leftout_point-1) ; ySensor(leftout_point+1:nSensors(q)+1)];
                            zleftout = [zMess(1:leftout_point-1) ; zMess(leftout_point+1:nSensors(q)+1)];
                        end
                        %[spline_value , spline_derv] = calculate_spline (knotspan,knots ,xLen , xVec); %calculating splines
                        hold off
                        BS = NaN(totalSplines,nSensors(q));
                        BS=Calculate_Basis(splinesPerAxis,knotsPerAxis(knotnumber),xleftout,yleftout,nSensors(q) ,xyMin,xyMax);
                      
                        vector = xyMin+knotspan/2:knotspan:xyMax;
                        vector_length =length(vector);
                        vector_span = 1:vector_length;
                        BS_Hori = NaN(vector_length, vector_length);
                        BS_Verti = NaN(vector_length, vector_length);
                        %BS_Val = NaN(vector_length, vector_length);
                        
                        [~, BS_Hori, BS_Verti] = Plot_Basis( splinesPerAxis,knotsPerAxis(knotnumber),vector,xyMin,xyMax);
                        
                        opt = [BS,BS_Hori*lambda(lambda_counter), BS_Verti*lambda(lambda_counter)];
                        zMess_opt = [zleftout ;zeros(2*size(BS_Hori',1),1) ];
                        weights_opt = opt'\zMess_opt;
                        xMissing = xSensor(leftout_point);
                        yMissing = ySensor(leftout_point);
                        zMissing = zMess(leftout_point);
                        BS_Val = NaN (totalSplines,1);
                        
                        p=0;
                        BS_Val= Basis_cal_one_point ( splinesPerAxis,knotsPerAxis(knotnumber),xMissing,yMissing,xyMin,xyMax);
                        
                        prediction = BS_Val'*weights_opt;
                        difference = prediction-zMissing;
                        sum_Error = sum_Error + difference.^2;
                        % fprintf('Leftout point Nr. %i at x= %3.3f y=%3.3f \tPrediction = %3.3f \tdelta = %3.3f \n', ...
                        %    leftout_point, xMissing, yMissing, prediction, prediction-yMissing);
                    end
                    
                    RMS(lambda_counter)= sqrt(sum_Error/length(zMess));
                    fprintf('average Error for lambda = %3.4f --> %3.4f \n\n', ...
                        lambda(lambda_counter), RMS(lambda_counter));
                    count = count +1;
                    
                    if lambda_counter > 1
                        if RMS(lambda_counter-1)< RMS(lambda_counter)||(lambda_counter == length (lambda)) % change the 15 number for more precise calculation
                            if resolution_vec(resolution) == 1
                                increament1 = -2;
                                increament2 = -1;
                            end
                            if lambda_counter+increament1 == 0
                                lambda_counter = lambda_counter +1;
                            end
                            lambda_start = lambda(lambda_counter+increament1);
                            lambda_end = lambda(lambda_counter+increament2);
                            lambda_grid =lambda_grid/10;
                            if resolution_vec(resolution) == 1
                                increament1 = increament1 +1;
                                increament2 = increament2 +1;
                            end
                            %                             if (lambda_counter >=3)||  length(lambda)>3
                            %                                 break;
                            %                             end
                            fprintf('Adding more resolution\n');
                            fprintf('...\n');
                            break;
                        end
                    end
                    if  lambda_counter>=8
                        break;
                    end
                end
                if  lambda_counter>=8
                    fprintf('Using previous lambda\n');
                    break;
                end
            end
            
            nSensors(q) = nSensors(q)+1;
            BS= Calculate_Basis( splinesPerAxis,knotsPerAxis(knotnumber),xSensor,ySensor,nSensors(q) ,xyMin,xyMax  );
            vector = xyMin+knotspan/2:knotspan:xyMax;
            vector_length =length(vector);
            vector_span = 1:vector_length;
            [BS_Val, BS_Hori, BS_Verti]= Plot_Basis( splinesPerAxis,knotsPerAxis(knotnumber),vector,xyMin,xyMax);
            lambda_new = max (lambda ( find ( RMS == min (RMS))));
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
            
            zz= plot_Spline( splinesPerAxis,knotsPerAxis(knotnumber), xVec,yVec,xyMin,xyMax,weights_opt_matrix); % function to plot spline
            figure (3)
            
            surf (xx,yy,zz,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.5);
            title ( ' Smoothing parameter choosen with OCV ' );
            hold on
            plot3 ( xSensor , ySensor , zMess ,'r*');
            legend ( 'Prediction', 'Sensors');
            axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.2 1.2]);
            %text(0.5, 0.5, 1, sprintf('\\lambda_1= %g \\lambda_2= %g',lambda_start, lambda_end));
            
            text(0.5, 0.5, 1, sprintf('\\lambda = %g',lambda_new));
            text(0.5, 0.7, max(zMess+1.5), sprintf('noise = %g',noiseLevel));
            text(0.5, 0.9, max(zMess+1), sprintf('nSensors %g',nSensors(q)));
            text(0.5, 0.9, max(zMess+2), sprintf('Total Splines %g',totalSplines));
            xlabel('x [n]');
            ylabel('y [n]');
            zlabel('z [n]');
            
            
            
            % calucalte final RMSE
            sumError=0;
            for i=1:cleanLen
                for k=1:cleanLen
                    error = zz(k,i)-zzMatrix(i,k)';
                    sumError = sumError +error^2;
                end
            end
            RMSE = sqrt(sumError/(cleanLen*cleanLen));
            fprintf('RMSE of Smoothing Spline = %3.5f \n',RMSE);
            
            figure(4);
            surf (xx,yy,zz,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.5);
            title ( ' Comparing Smoothing Spline  result and clean data ' );
            hold on
            surf (xx,yy,zzMatrix','EdgeColor','r','FaceColor',[1 0.7 0.7],'FaceAlpha',0.5);
            text(0.5, 0.7, max(zMess+1.5), sprintf('noise = %g',noiseLevel));
            text(0.5, 0.9, max(zMess+1), sprintf('nSensors %g',nSensors(q)));
            text(0.5, 0.9, max(zMess+2), sprintf('Total Splines %g',totalSplines));
            theLegend = [...
                {'Smoothed data'}
                {'Clean Reference'}
                ];
            legend(theLegend,'Location','NorthWest');
            xlabel('x [n]');
            ylabel('y [n]');
            zlabel('z [n]');
            hold off;
            
            figure(5);
            surf (xx,yy,zz_rs,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.5);
            text(0.5, 0.7, max(zMess+1.5), sprintf('noise = %g',noiseLevel));
            text(0.5, 0.9, max(zMess+1), sprintf('nSensors %g',nSensors(q)));
            text(0.5, 0.9, max(zMess+2), sprintf('Total Splines %g',totalSplines));
            title ( ' Comparing Regression spline result and clean data ' );
            hold on
            surf (xx,yy,zzMatrix','EdgeColor','r','FaceColor',[1 0.7 0.7],'FaceAlpha',0.5);
            text(0.5, 0.7, max(zMess+1.5), sprintf('noise = %g',noiseLevel));
            text(0.5, 0.9, max(zMess+1), sprintf('nSensors %g',nSensors(q)));
            text(0.5, 0.9, max(zMess+2), sprintf('Total Splines %g',totalSplines));
            theLegend = [...
                {'Estimate data'}
                {'Clean Reference'}
                ];
            legend(theLegend,'Location','NorthWest');
            xlabel('x [n]');
            ylabel('y [n]');
            zlabel('z [n]');
            fprintf('************************* \n');
        end
        
    end
end

toc