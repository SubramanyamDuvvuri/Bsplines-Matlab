%DemoLoadData
s_max = 200;        % number of sensors
noiseLevel = 0.1;   % sigma of random noise
comsolMesh = 'f';   % f=fine Mesh (recomended), n = normal
randomMode = 'r';   % b=both new sensor postions and noise vector (recommended) r=repeat same values, n = only new noise vector

[SensorData, CleanData] = loadTestData(s_max, noiseLevel, comsolMesh, randomMode);
plotCleanData(CleanData);
plotNoisySensors(SensorData);
theLegend = [...
    {'Clean data'}
    {'Sensor positions'}
    {'Noisy sensor values'}
 ];

legend(theLegend, 'Location', 'NorthWest');
axis([-1 1 -1 1 -1.2 1.2]);

% save files to correct names
save SensorDataNoise SensorData noiseLevel  
save CleanGridReference CleanData
