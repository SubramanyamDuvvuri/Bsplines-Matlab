function generateTestData2D(nSensors, noiseLevel, FunctionType, doEquispaced)

createRandomVectors=0;
cleanLen = 51;
xMin = -1;
xMax =  1;

Nx = xMax-xMin;  % lenght of interval

xClean= linspace(xMin,xMax,cleanLen);
yClean= linspace(xMin,xMax,cleanLen);
zzClean = NaN(cleanLen, cleanLen);

for i=1:cleanLen
    for k=1:cleanLen
        zzClean(i,k)=getHiddenSpatialFunction(xClean(i),yClean(k), FunctionType);
    end
end

randomFile = 'DataRandom1000.mat';
randomMax = 1000;

save DataClean2D xClean yClean zzClean

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
    sensorsPerAxis=floor(sqrt(nSensors));
    fprintf('Creating Mesh grid for %i Sensors per Axis EQUISPACED \n',sensorsPerAxis);
    xy = linspace(-1, 1, sensorsPerAxis);
    [xx, yy] = meshgrid(xy, xy);
    xSensor = reshape(xx, numel(xx), 1); 
    ySensor = reshape(yy, numel(yy), 1); 
else
    xSensor = randomXpositions(1:nSensors);
    ySensor = randomYpositions(1:nSensors);
    %xSensor = sort(xSensor)
end


zClean = NaN(nSensors,1);
zMess = NaN(nSensors,1);
for i=1:nSensors
    zClean(i) = getHiddenSpatialFunction(xSensor(i), ySensor(i), FunctionType);
    zMess(i)  = zClean(i) + noiseLevel*randomZ(i);
end

save DataSensors2D xSensor ySensor zClean zMess noiseLevel FunctionType doEquispaced



