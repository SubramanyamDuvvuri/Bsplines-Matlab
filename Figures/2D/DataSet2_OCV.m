%Graphs for OCV


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
57.42233	0.09125	0.03634	0.03438
];


z_smooth_01 =[0.11401	0.11268	0.04554	0.11048
0.10115	0.08951	0.0901	0.08718
0.21526	0.06193	0.06146	0.05867
0.18607	0.08339	0.04217	0.03961
0.06475	0.1759	0.02973	0.0342
0.0671	0.04554	0.03774	0.0311
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
axis([36 150  -.001 .3])
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
axis([36 150  -.001 .3])
title(' Smoothing Splines:RMSE vs Splines plot for different number of sensors and Noise = .01');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');

%-------------------------------------------------------------------------------------------------------
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
axis([36 150  -.001 .3])
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
axis([36 150  -.001 .3])
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


z_smooth_05 =[0.11473	0.11218	0.11208	0.11082
0.10166	0.09097	0.09108	0.08893
0.21621	0.06834	0.06459	0.06021
0.18672	0.17432	0.06335	0.05059
0.07289	0.17576	0.07862	0.0654
0.11875	0.17873	0.04843	0.0713

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
axis([36 150  -.001 .3])
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
axis([36 150  -.001 .3])
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


z_smooth_08 =[0.12241	0.11245	0.11241	0.11127
0.10403	0.09643	0.09016	0.08685
0.21735	0.08399	0.06986	0.06352
0.18762	0.1742	0.06028	0.0768
0.08344	0.17628	0.08076	0.05321
0.12109	0.17881	0.05721	0.19037


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
axis([36 150  -.001 .3])
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
axis([36 150  -.001 .3])
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


z_smooth_1 =[0.12434	0.11555	0.11312	0.11195
0.16813	0.11356	0.09207	0.08816
0.21831	0.08535	0.08072	0.06662
0.18681	0.17424	0.07406	0.08036
0.09191	0.17685	0.07974	0.05944
0.13925	0.17896	0.18132	0.19062

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
axis([36 150  -.001 .3])
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
axis([36 150  -.001 .3])
title(' Smoothing Splines:RMSE vs Splines plot for different number of sensors and Noise = .1');
legend('220 Sensors', '300 Sensors' , '400 Sensors' , '450 Sensors');











