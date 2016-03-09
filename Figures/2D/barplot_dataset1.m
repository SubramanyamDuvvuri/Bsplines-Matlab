clear all
clc
close all











z_smooth_01_gcv =[0.01962	0.01809	0.01659
0.01872	0.0159	0.01437
0.02353	0.01845	0.01405];

z_smooth_01_ocvhm =[0.11586	0.06867	0.06029
0.0885	0.04678	0.04249
0.05228	0.03347	0.03088
];


z_smooth_01_ocv =[0.01987	0.01869	0.01654
0.01763	0.01576	0.01447
0.03246	0.03631	0.01325];



z_smooth_05_gcv =[0.03865	0.03177	0.02535
0.05436	0.04132	0.02778
0.04146	0.03469	0.02656];

z_smooth_05_ocvhm = [0.13786	0.08612 	0.15871
0.07794	0.06457	0.0873
0.09108	0.05872	0.07332];


z_smooth_05_ocv =[0.03742	0.03078	0.02527
0.1286	0.13182	0.02548
0.13518	0.1262	0.1164
];


z_smooth_08_gcv =[0.05667	0.04396	0.03528
0.06465	0.04984	0.03826
0.06202	0.04674	0.05472
];


z_smooth_08_ocvhm =[0.13786	0.08612	0.15871
0.07794	0.06457	0.0873
0.09108	0.05872	0.07332
]

z_smooth_08_ocv =[0.1215	0.04186	0.03528
0.13187	0.14305	0.04272
0.13799	0.12661	0.11588];



y = NaN(3,3);

y (1,1)=sum(z_smooth_01_gcv(:))/numel(z_smooth_01_gcv);
y(1,2) = sum (z_smooth_01_ocvhm(:))/numel(z_smooth_01_ocvhm);
y(1,3) = sum (z_smooth_01_ocv(:))/numel(z_smooth_01_ocv);

y (2,1)=sum(z_smooth_05_gcv(:))/numel(z_smooth_05_gcv);
y(2,2) = sum (z_smooth_05_ocvhm(:))/numel(z_smooth_05_ocvhm);
y(2,3) = sum (z_smooth_05_ocv(:))/numel(z_smooth_05_ocv);

y (3,1)=sum(z_smooth_08_gcv(:))/numel(z_smooth_08_gcv);
y(3,2) = sum (z_smooth_08_ocvhm(:))/numel(z_smooth_08_ocvhm);
y(3,3) = sum (z_smooth_08_ocv(:))/numel(z_smooth_08_ocv);




x= [.01 .05 .08 ]


bar(x,y)
xlabel(' Noise Level ');
ylabel ('RMSE');
legend ('GCV ',' OCVHM','OCV');
title('Comparision between different methods');
axis([0 .12 0 .12])
set(gca,'XTick',[ .01 .05 .08 ])


