%Contains code to find optimised smoothing parameter using Generalised  cross validation.

%WITH DATA SET ONE ANS TWO
tic
clear
clc
close
diary ('results_GCV_dataSet2_lessSensors.txt');
noiseLevel_vec =[.01];%[ 0.8,.1,.13,.17,.2];
for noisevec =1:length(noiseLevel_vec)
    noiseLevel = noiseLevel_vec(noisevec);
    select_DataSet =2; % SELECT THE DATA SET TO BE USED (1,2)
    xyMin = -1;
    xyMax = 1;
    nSensors =[300];
    for q = 1: length(nSensors)
        % 0 to use different lambdas , 1 for same lambdas as lambda_start and do cross validation
        knotsPerAxis = [8];
        for knotnumber =1:length(knotsPerAxis)
            splinesPerAxis = knotsPerAxis(knotnumber)+2;
            totalSplines = splinesPerAxis^2;
            knotspan = (xyMax-xyMin)/(knotsPerAxis(knotnumber)-1);
            cleanLen=51;
            
            lambda_grid=.4;
            lambda_start =.0001;
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
            text(0.0, 0.8, max(zMess+.1), sprintf('noise = %g',noiseLevel));
            text(0.0, 0.8, max(zMess+.25), sprintf('nSensors %g',nSensors(q)));
            xlabel('x [n]');
            ylabel('y [n]');
            zlabel('z [n]');
            hold off
        
            fprintf('nSensors(q)= %3.5f  \n',nSensors(q));
            fprintf('Noise= %3.5f  \n',noiseLevel);
            fprintf('Splines= %3.5f  \n',totalSplines);
            hold off
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
            text(0.0, 0.8, max(zMess+.1), sprintf('noise = %g',noiseLevel));
            text(0.0, 0.8, max(zMess+.25), sprintf('nSensors %g',nSensors(q)));
            text(0.0, 0.8, max(zMess+.4), sprintf('Total Splines %g',totalSplines));
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
            %Selection using Generalised cross validation
            %-------------------------------------------------
            
            
            
            
            
            resolution_vec =[1:4];
            for resolution = 1:length(resolution_vec)
                lambda = lambda_start:lambda_grid:lambda_end;
                
                for lambda_counter =1:length(lambda)
                    sum_Error= 0;
                    
                    for i = 1 : nSensors(q)
                        [BS]=Calculate_Basis(splinesPerAxis,knotsPerAxis(knotnumber),xSensor,ySensor,nSensors(q) ,xyMin,xyMax  );%-----
                        
                        %----------------------------------------------
                        %calculate optimized weights by lambda
                        %------------------------------------------------
                        
                        vector = xyMin+knotspan/2:knotspan:xyMax;
                        vector_length =length(vector);
                        BS_Hori = NaN(vector_length, vector_length);
                        BS_Verti = NaN(vector_length, vector_length);
                        BS_Val = NaN(vector_length, vector_length);
                        
                        [BS_Val, BS_Hori, BS_Verti] = Plot_Basis( splinesPerAxis,knotsPerAxis(knotnumber),vector,xyMin,xyMax);%-----
                        
                        opt = [BS,BS_Hori*lambda(lambda_counter), BS_Verti*lambda(lambda_counter)];
                        zMess_opt = [zMess ;zeros(2*size(BS_Hori',1),1) ];
                        weights_opt = opt'\zMess_opt;
                        xCal = xSensor(i);
                        yCal = ySensor(i);
                        zCal =zMess(i);
                        M_Splines = NaN (totalSplines,1);
                        p=0;
                        M_Splines= Basis_cal_one_point ( splinesPerAxis,knotsPerAxis(knotnumber),xCal,yCal,xyMin,xyMax);
                        
                        prediction = M_Splines'*weights_opt;
                        difference = prediction-zCal;
                        
                        X = BS';
                        H = X/(X'*X+lambda(lambda_counter)*eye(size(X'*X))) * X' ;
                        sum_Error = sum_Error + difference.^2;
                    end
                    division = sum_Error / (1- inv(length(zMess))*trace (H)).^2;
                    RMS(lambda_counter)= sqrt(division/length(zMess));
                    fprintf('average Error for lambda = %3.4f --> %3.4f \n\n', ...
                        lambda(lambda_counter), RMS(lambda_counter));
                    
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
            
            %nSensors(q) = nSensors(q)+1;
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
            title ( ' Smoothing parameter choosen with GCV ' );
            hold on
            plot3 ( xSensor , ySensor , zMess ,'r*');
            legend ( 'Prediction', 'Sensors');
            axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.2 1.2]);
            %text(0.5, 0.5, 1, sprintf('\\lambda_1= %g \\lambda_2= %g',lambda, lambda_end));
            
            text(0.0, 0.8, max(zMess-.05), sprintf('\\lambda = %g',lambda_new));
             text(0.0, 0.8, max(zMess+.1), sprintf('noise = %g',noiseLevel));
            text(0.0, 0.8, max(zMess+.25), sprintf('nSensors %g',nSensors(q)));
            text(0.0, 0.8, max(zMess+.4), sprintf('Total Splines %g',totalSplines));
            xlabel('x [n]');
            ylabel('y [n]');
            zlabel('z [n]');
            hold off
            
            
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
            plot3 ( xSensor , ySensor , zMess ,'r*');
            surf (xx,yy,zzMatrix','EdgeColor','r','FaceColor',[1 0.7 0.7],'FaceAlpha',0.5);
            
            text(0.0, 0.8, max(zMess+.1), sprintf('noise = %g',noiseLevel));
            text(0.0, 0.8, max(zMess+.25), sprintf('nSensors %g',nSensors(q)));
            text(0.0, 0.8, max(zMess+.4), sprintf('Total Splines %g',totalSplines));
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
            hold on
            plot3 ( xSensor , ySensor , zMess ,'r*');
            title ( ' Comparing Regression spline result and clean data ' );
            
            surf (xx,yy,zzMatrix','EdgeColor','r','FaceColor',[1 0.7 0.7],'FaceAlpha',0.5);
            text(0.0, 0.8, max(zMess+.1), sprintf('noise = %g',noiseLevel));
            text(0.0, 0.8, max(zMess+.25), sprintf('nSensors %g',nSensors(q)));
            text(0.0, 0.8, max(zMess+.4), sprintf('Total Splines %g',totalSplines));
            theLegend = [...
                {'Estimate data'}
                {'Clean Reference'}
                ];
            legend(theLegend,'Location','NorthWest');
            xlabel('x [n]');
            ylabel('y [n]');
            zlabel('z [n]');
            hold off
            
            fprintf('************************* \n');
        end
    end
end

diary off
toc