%plotSensorData2D
load DataClean2D %xClean yClean zzClean
load DataSensors2D %xSensor ySensor zClean zMess noiseLevel FunctionType doEquispaced
[xx,yy] = meshgrid(xClean, yClean); 
fontAxis = 14;
fig = figure(1);
subplot('Position',[0.12 0.1 0.86 0.88])
surf(xx,yy,zzClean','EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.6);  % transparent works only with new MATLAB versions
%surf(xx,yy,zzClean','EdgeColor',[0.7 0.7 0.7]);  

hold on;
nSensors = length(xSensor);
for i=1:nSensors
    x = xSensor(i);   
    y = ySensor(i);
    z = zMess(i);
    c = zClean(i);
    plot3([x x], [y y], [c z],'k');
    plot3(x,y, c,'ro'); 
    hold on;
    plot3(x,y,z,'k*');
end

text(0.4, 0.8, 0.9, sprintf('%i Sensors',nSensors), 'FontSize',fontAxis);
text(0.4, 0.8, 0.7, sprintf('\\sigma_N_O_I_S_E = %3.2f',noiseLevel), 'FontSize',fontAxis);
xlabel('x','FontSize',fontAxis);
ylabel('y','FontSize',fontAxis);
zlabel('Temperature','FontSize',fontAxis);
axis([-1 1 -1 1 -1 1]);
hold off;
