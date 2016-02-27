%Graphs for OCVHM


close all

x = [220 , 300, 400, 450];
y = [ 36 , 49 , 64 , 81 , 100 ,121];
z_reg_01 = [0.11854	0.11226	0.11094	0.11001
0.11012	0.09385	0.09442	0.09086
0.11589	0.06867	0.06689	0.06005
0.08916	0.04678	0.04249	0.04198
0.1884	0.03361	0.0309	0.03184
57.42233	0.09125	0.03634	0.03438];


z_smooth_01 =[0.18484	0.2075	0.20052	0.19946
0.16675	0.10922	0.091	0.14707
0.11586	0.06867	0.06029	0.06004
0.0885	0.04656	0.04249	0.06076
0.05228	0.03347	0.03088	0.03182
0.19138	0.06851	0.17319	0.06179];


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
axis([36 150  -.001 .6])
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
axis([36 150  -.001 .6])
title(' Smoothing Splines:RMSE vs Splines plot for different number of sensors and Noise = .01');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');
%-----------------------------------------------------------------------------------
%.05
%-----------------------------------------------------------------------------------
x = [220 , 300, 400, 450];
y = [ 36 , 49 , 64 , 81 , 100 ,121];
z_reg_05 =[ 0.1184	0.11153 	0.11107	0.11023
0.10629	0.0956	0.09538	0.09082
0.12331	0.0781	0.07421	0.0615
0.14209	0.06692	0.06411	0.063
1.9189	0.0848	0.06913	0.06806
24.0125	0.17321	0.08668	0.08919
];


z_smooth_05 =[0.18567	0.20756	0.2004	0.19942
0.1667	0.11033	0.08924	0.13712
0.12328	0.0764	0.11153	0.0615
0.06744	0.05941	0.06411	0.07199
0.08258	0.08367	0.05113	0.05083
0.52193	0.05265	0.173	0.18982];


figure (2)
subplot(2,1,1)
plot (y,z_reg_05(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_reg_05(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_reg_05(:,3),'bs-','LineWidth',1.5)%----400
plot (y,z_reg_05(:,4),'ks-','LineWidth',1.5)%----450
hold off
xlabel('Splines');
ylabel('RMSE');
axis([36 150  -.001 .6])
title(' Regression Splines:RMSE vs Splines plot for different number of sensors and Noise = .01');
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
axis([36 150  -.001 .6])
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


z_smooth_08 =[0.18653	0.20771	0.16558	0.1994
0.16733	0.11185	0.09028	0.20728
0.13786	0.08612	0.15871	0.15479
0.07794	0.06457	0.0873	0.09582
0.09108	0.05872	0.07332	0.18565
0.09722	0.06791	0.17302	0.1901
];


figure (3)
subplot(2,1,1)
plot (y,z_reg_08(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_reg_08(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_reg_08(:,3),'bs-','LineWidth',1.5)%----400
plot (y,z_reg_08(:,4),'ks-','LineWidth',1.5)%----450
hold off
xlabel('Splines');
ylabel('RMSE');
axis([36 150  -.001 .6])
title(' Regression Splines:RMSE vs Splines plot for different number of sensors and Noise = .01');
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
axis([36 150  -.001 .6])
title(' Smoothing Splines:RMSE vs Splines plot for different number of sensors and Noise = .05');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');




%----------------------------------------------------------------------------------------------
%.1
%------------------------------------------------------------------------------------------------

x = [220 , 300, 400, 450];
y = [ 36 , 49 , 64 , 81 , 100 ,121];
z_reg_1 =[0.12148	0.11187	0.11219	0.11144
0.11107	0.10005	0.09833	0.09254
0.15076	0.09595	0.08813	0.06899
0.31298	0.10708	0.10399	0.09548
4.46975	0.16844	0.13031	0.1281
18.22565	0.29765	0.16281	0.16749

];


z_smooth_1 =[0.18729	0.20785	0.15774	0.1177
0.16807	0.11318	0.09147	0.20742
0.15073	0.09359	0.15912	0.15501
0.09072	0.15259	0.10398	0.09825
0.09808	0.0728	0.08897	0.18586
0.1153	0.07901	0.12311	0.19035
];


figure (4)
subplot(2,1,1)
plot (y,z_reg_1(:,1),'rs-','LineWidth',1.5)%----220
hold on
plot (y,z_reg_1(:,2),'gs-','LineWidth',1.5)%----300
plot (y,z_reg_1(:,3),'bs-','LineWidth',1.5)%----400
plot (y,z_reg_1(:,4),'ks-','LineWidth',1.5)%----450
hold off
xlabel('Splines');
ylabel('RMSE');
axis([36 150  -.001 .6])
title(' Regression Splines:RMSE vs Splines plot for different number of sensors and Noise = .01');
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
axis([36 150  -.001 .6])
title(' Smoothing Splines:RMSE vs Splines plot for different number of sensors and Noise = .05');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');











