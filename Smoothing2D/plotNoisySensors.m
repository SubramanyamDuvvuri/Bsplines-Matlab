% (C) Reiner Jedermann, University Bremen / IMSAS, Germany
% rjedermann@imsas.uni-bremen.de
% File: plotNoisySensors.m
%
% The test data can be used under the condition that the following article
% is quoated and modified files contain also this header, see also ReadMe.pdf
%
% Jedermann, R. and Paul, H. (2015). 
% Accuracy of Spatial Field Reconstruction in Wireless Sensor Networks
% What can 100 Sensors tell us? 
% International Journal of Distributed Sensor Networks, Hindawi
% 

function plotNoisySensors(SensorData)
figure(3)
hold on

nSensors = length(SensorData.x);
for i=1:nSensors
    x = SensorData.x(i);
    y = SensorData.y(i);
    z = SensorData.zMess(i);
    c = SensorData.zClean(i);
    hLine1=plot3([x x], [y y], [c z],'r');
    set(get(get(hLine1,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); 

    hold on;
    hLine2 = plot3(x,y, c,'ro'); 
    hLine3 = plot3(x,y,z,'rx','MarkerSize',10,'LineWidth',2);
    if(i>1)
        set(get(get(hLine2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); 
        set(get(get(hLine3,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');       
    end
end
hold off
