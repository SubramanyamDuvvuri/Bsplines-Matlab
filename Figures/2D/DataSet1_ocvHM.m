%Graphs for OCVHM


close all

%.03 is no there



x = [220 , 300, 400];
y = [ 64 , 81 , 100 ];
z_reg_01 = [0.11589	0.06867	0.06689
0.08916	0.04678	0.04249
0.1884	0.03361	0.0309

];


z_smooth_01 =[0.11586	0.06867	0.06029
0.0885	0.04678	0.04249
0.05228	0.03347	0.03088
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
z_reg_01 = [0.12331	0.0781	0.07421
0.14209	0.06692	0.06411
1.91898	0.0848	0.06913




];


z_smooth_01 =[0.12328	0.0764	0.11153
0.06744	0.05941	0.06411
0.08258	0.08367	0.05113


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
z_reg_01 = [0.13788	0.0882	0.08206
0.24191	0.09012	0.08731
3.44894	0.13448	0.10541



];


z_smooth_01 =[0.13786	0.08612	0.15871
0.07794	0.06457	0.0873
0.09108	0.05872	0.07332


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











