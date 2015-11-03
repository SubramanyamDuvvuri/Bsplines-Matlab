clear all
lambda = input( 'Enter lambda: ' ) ;
% data
y = rand(20,1) ;
X = [ ones(20,1) rand(20,5) ] ;
w = ( inv( X' * X + lambda * eye(size(X'*X)) ) * X' ) * y ;
y_fit = X * w ;
H = X * inv( X' * X + lambda * eye(size(X'*X)) ) * X' ;
yh_fit = H * y ;
both_fits = [ y_fit yh_fit ]
% plot( y , 'b', y_fit , 'r' , yh_fit , 'g' )
plot( y , 'b');
hold on 
plot(  y_fit , 'r*');
hold on
plot (yh_fit , 'g' )
hold off
