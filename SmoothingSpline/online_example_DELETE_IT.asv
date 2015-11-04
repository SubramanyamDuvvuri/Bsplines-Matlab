lambda = .08
y = ySensors;
X = BS_value';
w = ( inv( X' * X + lambda * eye(size(X'*X)) ) * X' ) * y ;
y_fit = X * w ;
H = X * inv( X' * X + lambda * eye(size(X'*X)) ) * X' ;
yh_fit = H * y ;
both_fits = [ y_fit yh_fit ];
% plot( y , 'b', y_fit , 'r' , yh_fit , 'g' )
plot( xSensors ,y , 'b*');
hold on 
plot( xSensors , y_fit , 'r*');
hold on
plot (xSensors ,yh_fit , 'g' )
hold off
