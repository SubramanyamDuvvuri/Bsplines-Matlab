% (C) Reiner Jedermann, University Bremen / IMSAS, Germany
% rjedermann@imsas.uni-bremen.de
% File: plotCleanData.m
%
% The test data can be used under the condition that the following article
% is quoated and modified files contain also this header, see also ReadMe.pdf
%
% Jedermann, R. and Paul, H. (2015). 
% Accuracy of Spatial Field Reconstruction in Wireless Sensor Networks
% What can 100 Sensors tell us? 
% International Journal of Distributed Sensor Networks, Hindawi
% 

function plotCleanData(CleanData)
%hold on;
fontAxis = 14;

%load CleanGridReference %CleanData
figure(3);
[xx,yy] = meshgrid(CleanData.xVec, CleanData.yVec); 
surf(xx,yy,CleanData.zMatrix','EdgeColor',[0.3 0.3 0.3],'FaceAlpha',0.4);  % transparent works only with new MATLAB versions

xlabel('x [m]','FontSize',fontAxis);
ylabel('y [m]','FontSize',fontAxis);
zlabel('Temperature [°C]','FontSize',fontAxis);
%axis([-1 1 -1 1 0 7]);
%hold off;
