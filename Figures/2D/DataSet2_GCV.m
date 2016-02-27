%Graphs for GCV


close all
clear all
clc

x = [220 , 300, 400, 450];
y = [ 36 , 49 , 64 , 81 , 100 ,121];
z_reg_01 = [0.11854	0.11226	0.11094	0.11001
0.11012	0.09385	0.09442	0.09086
0.11589	0.06867	0.06689	0.06005
0.08916	0.04678	0.04249	0.04198
0.1884	0.03361	0.0309	0.03184
57.42233	0.09125	0.03634	0.03438];


z_smooth_01 =[0.11666	0.11219	0.11181	0.11038
0.10557	0.09287	0.09354	0.09017
0.11364	0.06685	0.06561	0.05968
0.06776	0.04611	0.04217	0.04174
0.0641	0.03125	0.02973	0.03074
0.05759	0.03257	0.0293	0.02866
];


figure (1)
subplot(2,1,1)
plot (y,z_reg_01(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_reg_01(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_reg_01(:,3),'bs-','LineWidth',1.5)%----400
plot (y,z_reg_01(:,4),'ks-','LineWidth',1.5)%----450
hold off
xlabel('Splines');
ylabel('RMSE');
axis([36 150  -.001 .18])
title(' Regression Splines:RMSE vs Splines plot for different number of sensors and Noise = .01');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');

subplot(2,1,2)
plot (y,z_smooth_01(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_smooth_01(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_smooth_01(:,3),'bs-','LineWidth',1.5)%----400
plot (y,z_smooth_01(:,4),'ks-','LineWidth',1.5)%----450

hold off
xlabel('Splines');
ylabel('RMSE');
axis([36 150  -.001 .18])
title(' Smoothing Splines:RMSE vs Splines plot for different number of sensors and Noise = .01');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');





%---------------------------------------------------------------------------------











x = [220 , 300, 400, 450];
y = [ 36 , 49 , 64 , 81 , 100 ,121];
z_reg_03 = [0.11818	0.11179	0.11092	0.11004
0.10737	0.09452	0.09474	0.09068
0.11767	0.0727	0.07003	0.06022
0.09229	0.05447	0.05117	0.0492
0.90314	0.05432	0.04698	0.04667
40.69873	0.12792	0.05846	0.05945];


z_smooth_03 =[0.11386	0.11223	0.11177	0.11041
0.10102	0.09007	0.09387	0.08533
0.21565	0.06478	0.06359	0.05901
0.18632	0.05367	0.05063	0.04369
0.08764	0.04386	0.04276	0.03621
0.06923	0.08769	0.04161	0.03759];


figure (2)
subplot(2,1,1)
plot (y,z_reg_03(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_reg_03(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_reg_03(:,3),'bs-','LineWidth',1.5)%----400
plot (y,z_reg_03(:,4),'ks-','LineWidth',1.5)%----450
hold off
xlabel('Splines');
ylabel('RMSE');
axis([36 150  -.001 .18])
title(' Regression Splines:RMSE vs Splines plot for different number of sensors and Noise = .03');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');

subplot(2,1,2)
plot (y,z_smooth_03(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_smooth_03(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_smooth_03(:,3),'bs-','LineWidth',1.5)%----400
plot (y,z_smooth_03(:,4),'ks-','LineWidth',1.5)%----450

hold off
xlabel('Splines');
ylabel('RMSE');
axis([36 150  -.001 .18])
title(' Smoothing Splines:RMSE vs Splines plot for different number of sensors and Noise = .03');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');
%-----------------------------------------------------------------------------------
%.05
%-----------------------------------------------------------------------------------
x = [220 , 300, 400, 450];
y = [ 36 , 49 , 64 , 81 , 100 ,121];
z_reg_05 =[ 0.1184	0.11153	0.11107	0.11023
0.10629	0.0956	0.09538	0.09082
0.12331	0.0781	0.07421	0.0615
0.14209	0.06692	0.06411	0.063
1.9189	0.0848	0.06913	0.06806
24.0125	0.17321	0.08668	0.08919
];


z_smooth_05 =[0.11636	0.11198	0.1119	0.11059
0.10303	0.09455	0.09451	0.09015
0.09215	0.07566	0.07253	0.06115
0.11126	0.06596	0.06335	0.05971
0.11802	0.06455	0.06169	0.06105
0.17432	0.06335	0.07299	0.06793
];


figure (3)
subplot(2,1,1)
plot (y,z_reg_05(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_reg_05(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_reg_05(:,3),'bs-','LineWidth',1.5)%----400
plot (y,z_reg_05(:,4),'ks-','LineWidth',1.5)%----450
hold off
xlabel('Splines');
ylabel('RMSE');
axis([36 150  -.001 .18])
title(' Regression Splines:RMSE vs Splines plot for different number of sensors and Noise = .05');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');

subplot(2,1,2)
plot (y,z_smooth_05(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_smooth_05(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_smooth_05(:,3),'bs-','LineWidth',1.5)%----400
plot (y,z_smooth_05(:,4),'ks-','LineWidth',1.5)%----450

hold off
xlabel('Splines');
ylabel('RMSE');
axis([36 150  -.001 .18])
title(' Smoothing Splines:RMSE vs Splines plot for different number of sensors and Noise = .05');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');

%----------------------------------------------------------------------------------------------
%.08
%------------------------------------------------------------------------------------------------

x = [220 , 300, 400, 450];
y = [ 36 , 49 , 64 , 81 , 100 ,121];
z_reg_08 =[ 0.11982	0.11157	0.11162	0.11083
0.1079	0.09798	0.09692	0.09162
0.13788	0.0882	0.08206	0.06533
0.24191	0.09012	0.08731	0.08066
3.44894	0.13448	0.10541	0.10359
3.01341	0.2469	0.13194	0.13588


];


z_smooth_08 =[0.11687	0.11273	0.11241	0.11116
0.10028	0.09686	0.09605	0.09097
0.1031	0.08521	0.08004	0.06486
0.16593	0.08887	0.08623	0.07982
0.07987	0.09979	0.09331	0.09198
0.07855	0.06686	0.11199	0.10342

];


figure (4)
subplot(2,1,1)
plot (y,z_reg_08(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_reg_08(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_reg_08(:,3),'bs-','LineWidth',1.5)%----400
plot (y,z_reg_08(:,4),'ks-','LineWidth',1.5)%----450
hold off
xlabel('Splines');
ylabel('RMSE');
axis([36 150  -.001 .18])
title(' Regression Splines:RMSE vs Splines plot for different number of sensors and Noise = .08');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');

subplot(2,1,2)
plot (y,z_smooth_08(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_smooth_08(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_smooth_08(:,3),'bs-','LineWidth',1.5)%----400
plot (y,z_smooth_08(:,4),'ks-','LineWidth',1.5)%----450

hold off
xlabel('Splines');
ylabel('RMSE');
axis([36 150  -.001 .18])
title(' Smoothing Splines:RMSE vs Splines plot for different number of sensors and Noise = .08');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');




%----------------------------------------------------------------------------------------------
%.1
%------------------------------------------------------------------------------------------------

x = [220 , 300, 400, 450];
y = [ 36 , 49 , 64 , 81 , 100 ,121];
z_reg_1 =[0.12148	0.11857	0.11219	0.11144
0.11105	0.10005	0.09833	0.09254
0.15076	0.09595	0.08813	0.06899
0.31298	0.10708	0.10399	0.09548
4.46975	0.16844	0.13031	0.1281
18.22565	0.29765	0.16281	0.16749


];


z_smooth_1 =[0.11887	0.11187	0.11354	0.11209
0.10357	0.09471	0.0935	0.08912
0.08633	0.07434	0.08588	0.0684
0.09175	0.10564	0.1027	0.09448
0.09004	0.06338	0.11517	0.11348
0.08218	0.06622	0.06978	0.12763
];


figure (5)
subplot(2,1,1)
plot (y,z_reg_1(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_reg_1(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_reg_1(:,3),'bs-','LineWidth',1.5)%----400
plot (y,z_reg_1(:,4),'ks-','LineWidth',1.5)%----450
hold off
xlabel('Splines');
ylabel('RMSE');
axis([36 150  -.001 .18])
title(' Regression Splines:RMSE vs Splines plot for different number of sensors and Noise = .1');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');

subplot(2,1,2)
plot (y,z_smooth_1(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_smooth_1(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_smooth_1(:,3),'bs-','LineWidth',1.5)%----400
plot (y,z_smooth_1(:,4),'ks-','LineWidth',1.5)%----450

hold off
xlabel('Splines');
ylabel('RMSE');
axis([36 150  -.001 .18])
title(' Smoothing Splines:RMSE vs Splines plot for different number of sensors and Noise = .1');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');











