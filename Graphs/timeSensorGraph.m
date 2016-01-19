%TIME AND Sensor graph

figure(1)
x = [100 ,200,300]
y= [39.722 , 180.67 , 381.55]
hold on
plot (x,y,'d-g','LineWidth',1.6 );
xlabel('Sensors')
ylabel('Time in seconds');
title ( 'Sensors vs Time Graph for noise = .08 ')
y= [66.91 , 282.51 , 587.21]
hold on
plot (x,y,'d-b','LineWidth',1.6 );
hold on
y= [72.22 , 292.62 , 672.03]
plot (x,y,'d-r','LineWidth',1.6 );
axis([100 500 0 800 ])

legend('OCV','GCV','OCV with hat matrix');

figure (2)

x = [100 ,200,300]
y= [40.86 , 184.61 , 379.26]
hold on
plot (x,y,'d-g','LineWidth',1.6 );
xlabel('Sensors')
ylabel('Time in seconds');
title ( 'Sensors vs Time Graph for noise = .12 ')
y= [66.76 , 278.18 , 595.24]
hold on
plot (x,y,'d-b','LineWidth',1.6 );
hold on
y= [73.45 , 291.89 , 673.14]
plot (x,y,'d-r','LineWidth',1.6 );
axis([100 500 0 800 ])

legend('OCV','GCV','OCV with hat matrix');

figure (3)

x = [100 ,200,300]
y= [39.29 , 181.27 , 380.1]
hold on
plot (x,y,'d-g','LineWidth',1.6 );
xlabel('Sensors')
ylabel('Time in seconds');
title ( 'Sensors vs Time Graph for noise = .2 ')
y= [67.166 , 279.34 , 594.23]
hold on
plot (x,y,'d-b','LineWidth',1.6 );
hold on
y= [72.89 , 293.47 , 671.79]
plot (x,y,'d-r','LineWidth',1.6 );
axis([100 500 0 800 ])

legend('OCV','GCV','OCV with hat matrix');

