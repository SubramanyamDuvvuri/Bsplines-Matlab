%plotSensorData1D
load DataClean1D % xClean yClean zzClean
load DataSensors1D % xSensor ySensor zClean zMess noiseLevel FunctionType doEquispaced
 
fontAxis = 14;
fig = figure(1);
subplot('Position',[0.1 0.1 0.88 0.88])
plot(xClean, zzClean,'r');

hold on;
nSensors = length(xSensor);
for i=1:nSensors
    x = xSensor(i);
    y = ySensor;
    z = zMess(i);
    c = zClean(i);
    plot([x x], [c z],'k');
    %plot(x, c,'ro'); 
    plot(x,z,'k*');
end

text(0.3, 0.8,  sprintf('%i Sensors',nSensors), 'FontSize',fontAxis);
text(0.3, 0.6,  sprintf('\\sigma_N_O_I_S_E = %3.2f',noiseLevel), 'FontSize',fontAxis);
xlabel('x','FontSize',fontAxis);
ylabel('Temperature','FontSize',fontAxis);
axis([-1 1 -1 1]);
hold off;
