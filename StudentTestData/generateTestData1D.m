function generateTestData1D(nSensors, noiseLevel, FunctionType, doEquispaced)
ySensor = 0;
yClean = 0;
createRandomVectors=0;
cleanLen = 251;
xMin = -1;
xMax =  1;

%Nx = xMax-xMin;  % lenght of interval

xClean= linspace(xMin,xMax,cleanLen);
zzClean = NaN(cleanLen, 1);

for i=1:cleanLen
        zzClean(i)=getHiddenSpatialFunction(xClean(i),ySensor, FunctionType);
end

randomFile = 'DataRandom1000.mat';
randomMax = 1000;

save DataClean1D xClean yClean zzClean

isFile = exist(randomFile, 'file');

if( (isFile~=2) || (createRandomVectors>0) )
    fprintf('Creating new Random Vector \n');
    randomXpositions = 2*rand(randomMax,1)-1;
    randomYpositions = 2*rand(randomMax,1)-1;
    randomZ = randn(randomMax,1);
    save(randomFile, 'randomXpositions', 'randomYpositions', 'randomZ');
else
    load(randomFile);
end

if(doEquispaced)
    fprintf('Creating %i Sensors per Axis EQUISPACED \n',nSensors);
    xSensor = linspace(-1, 1, nSensors); 
else
    xSensor = randomXpositions(1:nSensors);
    xSensor = sort(xSensor);
end


zClean = NaN(nSensors,1);
zMess = NaN(nSensors,1);
for i=1:nSensors
    zClean(i) = getHiddenSpatialFunction(xSensor(i), ySensor, FunctionType);
    zMess(i)  = zClean(i) + noiseLevel*randomZ(i);
end

save DataSensors1D xSensor ySensor zClean zMess noiseLevel FunctionType doEquispaced



