%Graphs for OCVHM


close all

%.03 is no there



x = [220 , 300, 400];
y = [ 64 , 81 , 100 ];
z_reg_01 = [0.01989	0.01815	0.01663
0.01884	0.01591	0.01438
0.03275	0.01901	0.01462


];


z_smooth_01 =[0.01962	0.01809	0.01659
0.01872	0.0159	0.01437
0.02353	0.01845	0.01405

];



figure (1)
subplot(2,1,1)
plot (y,z_reg_01(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_reg_01(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_reg_01(:,3),'bs-','LineWidth',1.5)%----400

hold off
xlabel('Splines');
ylabel('RMSE');
axis([60 110  -.001 .25])
title(' Regression Splines:RMSE vs Splines plot for different number of sensors and Noise = .01');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');

subplot(2,1,2)
plot (y,z_smooth_01(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_smooth_01(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_smooth_01(:,3),'bs-','LineWidth',1.5)%----400

hold off
xlabel('Splines');
ylabel('RMSE');
axis([60 110  -.001 .25])
title(' Smoothing Splines:RMSE vs Splines plot for different number of sensors and Noise = .01');
legend('220 Sensors', '300 Sensors' , '400 Sensors' );
%-----------------------------------------------------------------------------------
%.05
%-----------------------------------------------------------------------------------

x = [220 , 300, 400];
y = [ 64 , 81 , 100 ];
z_reg_01 = [0.04046	0.03276	0.02551
0.06899	0.04547	0.02863
0.168	0.0748	0.04205





];


z_smooth_01 =[0.03865	0.03177	0.02535
0.05436	0.04132	0.02778
0.04146	0.03469	0.02656



];



figure (2)
subplot(2,1,1)
plot (y,z_reg_01(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_reg_01(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_reg_01(:,3),'bs-','LineWidth',1.5)%----400

hold off
xlabel('Splines');
ylabel('RMSE');
axis([60 110  -.001 .25])
title(' Regression Splines:RMSE vs Splines plot for different number of sensors and Noise = .05');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');

subplot(2,1,2)
plot (y,z_smooth_01(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_smooth_01(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_smooth_01(:,3),'bs-','LineWidth',1.5)%----400

hold off
xlabel('Splines');
ylabel('RMSE');
axis([60 110  -.001 .25])
title(' Smoothing Splines:RMSE vs Splines plot for different number of sensors and Noise = .05');
legend('220 Sensors', '300 Sensors' , '400 Sensors' );

%------------------------------------------------------------------------------------------------------------------------------------------------



x = [220 , 300, 400];
y = [ 64 , 81 , 100 ];
z_reg_01 = [0.06006	0.04761	0.03572
0.11004	0.07178	0.04272
0.27091	0.11928	0.06571




];


z_smooth_01 =[0.05667	0.04396	0.03528
0.06465	0.04984	0.03826
0.06202	0.04674	0.05472
];



figure (3)
subplot(2,1,1)
plot (y,z_reg_01(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_reg_01(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_reg_01(:,3),'bs-','LineWidth',1.5)%----400

hold off
xlabel('Splines');
ylabel('RMSE');
axis([60 110  -.001 .25])
title(' Regression Splines:RMSE vs Splines plot for different number of sensors and Noise = .08');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');

subplot(2,1,2)
plot (y,z_smooth_01(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_smooth_01(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_smooth_01(:,3),'bs-','LineWidth',1.5)%----400

hold off
xlabel('Splines');
ylabel('RMSE');
axis([60 110  -.001 .25])
title(' Smoothing Splines:RMSE vs Splines plot for different number of sensors and Noise = .08');
legend('220 Sensors', '300 Sensors' , '400 Sensors' );











