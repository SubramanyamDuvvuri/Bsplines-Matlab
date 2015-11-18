%Demo1D
nSensors = 100;    % maximum 1000 
noiseLevel = 0.07;  % adjust sigma of noise
FunctionType = 11;  % 1 normal, 2 jump
doEquispaced = 0;  % 0 or 1

generateTestData1D(nSensors, noiseLevel, FunctionType, doEquispaced)
% generates 
% - DataClean1D.mat  (clean function in higher resolution for plotting)
%
% - DataSensors1D.mat  (xSensor ySensor zClean zMess noiseLevel FunctionType doEquispaced) 
%       - xSensor = Sensor Postions  --> copy to tempMonthly
%       - zMess = Noisy Measurement  --> copy to timeInYears
%       - zClean = Without Noise     --> copy to yClean


plotSensorData1D
