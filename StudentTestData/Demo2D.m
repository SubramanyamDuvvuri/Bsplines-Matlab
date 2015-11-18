%Demo2D
nSensors = 400;
noiseLevel = 0.1;
FunctionType = 2; 
doEquispaced = 0;

generateTestData2D(nSensors, noiseLevel, FunctionType, doEquispaced)
% generates 
% - DataClean2D.mat
% - DataSensors2D.mat

plotSensorData2D
