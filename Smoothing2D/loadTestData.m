function  [SensorData, CleanData] = loadTestData(s_max, noiseLevel, comsolMesh, randomMode)

switch(comsolMesh)
    case 'n' % normal Comsol Mesh
        load CleanGridConvection_IJDSN %CleanData
        load SensorData1000_IJDSN %SensorData        
        
    case 'f'  % fine Comsol Mesh
        load CleanGridConvection_Fine %CleanData
        load SensorDataFine2000 %SensorData        
end


%%% add noise to measurements %%% 
lenAll = length(SensorData.x);
if(s_max>lenAll)
    s_max=lenAll;
end

SD.x = NaN(s_max,1);
SD.y = NaN(s_max,1);
SD.zClean = NaN(s_max,1);
SD.zMess = NaN(s_max,1);

switch(randomMode)
    case 'c'  %  = include 4 corner sensors, in addition to 'both'
        randomZ = randn(s_max,1);
        sensorOffset = round((lenAll-4)*rand()+4);
        
        for i=1:4
            SD.x(i) = SensorData.x(i);
            SD.y(i) = SensorData.y(i);
            SD.zClean(i) = SensorData.zClean(i);
            SD.zMess(i) = SensorData.zClean(i) + noiseLevel*randomZ(i);
        end
       
        for i=5:s_max
            sensorOffset = sensorOffset+1;
            if(sensorOffset>lenAll)
                sensorOffset=5;
            end
            SD.x(i) = SensorData.x(sensorOffset);
            SD.y(i) = SensorData.y(sensorOffset);
            SD.zClean(i) = SensorData.zClean(sensorOffset);
            SD.zMess(i) = SensorData.zClean(sensorOffset) + noiseLevel*randomZ(i);
        end
        
    case 'p'  %  = random pulling, no sequent sensors, otherwise same as 'both'
        randomZ = randn(s_max,1);
        inUse = zeros(lenAll,1);
     
        for i=1:s_max
            sensorOffset = floor((lenAll-4)*rand()+5);
            count = 0;
            while((inUse(sensorOffset)==1) && (count<50) )
                count = count+1;
                sensorOffset = floor((lenAll-4)*rand()+5);
                %fprintf('Sensor %i in use, repeat %i \n',sensorOffset,count);    
            end
            if(count>48)
                fprintf('ERROR not enough sensors \n');
                stop
            end
            inUse(sensorOffset)=1;
            
            SD.x(i) = SensorData.x(sensorOffset);
            SD.y(i) = SensorData.y(sensorOffset);
            SD.zClean(i) = SensorData.zClean(sensorOffset);
            SD.zMess(i) = SensorData.zClean(sensorOffset) + noiseLevel*randomZ(i);
        end
        
   case 'g'  % equispaced grid on fine Comsol Mesh
        CleanDataOLD = CleanData;
        randomZ = randn(s_max,1);
        load CleanGrid256Fine %CleanData
        
        sRoot = round(sqrt(s_max));
        if(sRoot^2 ~= s_max)
            fprintf('s_max must be square %i \n',s_max);
        end
        pDelta = 256/sRoot;

        yIndex = pDelta/2:pDelta:256;
        yOffset = pDelta*rand(1)-pDelta/2;
        yIndex = ceil(yIndex + yOffset);
        if(yIndex(1)<1)
            yIndex(1)=1;
            fprintf('yIndex(1) korrected!\n');
        end
        if(yIndex(end)>256)
            yIndex(end)=256;
            fprintf('yIndex(end) korrected!\n');
        end
        
        xIndex = pDelta/2:pDelta:256;
        xOffset = pDelta*rand(1)-pDelta/2;
        xIndex = ceil(xIndex + xOffset);
        if(xIndex(1)<1)
            xIndex(1)=1;
            fprintf('xIndex(1) corrected!\n');
        end
        if(xIndex(end)>256)
            xIndex(end)=256;
            fprintf('xIndex(end) corrected!\n');
        end
    
        count=0;
        for x=1:sRoot
            for y=1:sRoot
                count = count+1;
                SD.x(count)=CleanData.xVec(xIndex(x));
                SD.y(count)=CleanData.yVec(yIndex(y));
                SD.zClean(count) = CleanData.zMatrix(xIndex(x), yIndex(y));
                SD.zMess(count) = SD.zClean(count)+ noiseLevel*randomZ(count);
            end
        end
        %fprintf('Grid sensor data loaded with offset %i/%i \n',gridOffsetX, gridOffsetY);
        CleanData = CleanDataOLD;
        
    case 'b'  %  = both, new noise, random start position in sensor selection
        randomZ = randn(s_max,1);
        sensorOffset = round(lenAll*rand());
       
        for i=1:s_max
            sensorOffset = sensorOffset+1;
            if(sensorOffset>lenAll)
                sensorOffset=1;
            end
            SD.x(i) = SensorData.x(sensorOffset);
            SD.y(i) = SensorData.y(sensorOffset);
            SD.zClean(i) = SensorData.zClean(sensorOffset);
            SD.zMess(i) = SensorData.zClean(sensorOffset) + noiseLevel*randomZ(i);
        end
        
     case 'n'  % n = new noise instance for each call
        randomZ = randn(s_max,1);
        for i=1:s_max
            SD.x(i) = SensorData.x(i);
            SD.y(i) = SensorData.y(i);
            SD.zClean(i) = SensorData.zClean(i);
            SD.zMess(i)  = SensorData.zClean(i) + noiseLevel*randomZ(i);
        end
        
    case 'r' %  = repeated always the same values
        randomFile = 'DataRandom1000.mat';
        load(randomFile);
        for i=1:s_max
            SD.x(i) = SensorData.x(i);
            SD.y(i) = SensorData.y(i);
            SD.zClean(i) = SensorData.zClean(i);
            SD.zMess(i)  = SensorData.zClean(i) + noiseLevel*randomZ(i);
        end
end
SensorData = SD;




