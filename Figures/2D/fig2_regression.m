x = [350, 400 , 450 ];
y = [ .173041, .2006 , .156351];



plot (x,y,'d-','LineWidth',2)
xlabel ( 'Sensors' );
ylabel ( 'RMSE');
title('RMSE vs Sensors Plot with Knots = 49');


figure (2)
x = [ 25 36 49 ];
y=[.261664 .46031 .197302];

plot (x,y,'d-','LineWidth',2)
xlabel ( 'Knots' );
ylabel ( 'RMSE');
title('RMSE vs Knots Plot with Sensors= 400 ');


