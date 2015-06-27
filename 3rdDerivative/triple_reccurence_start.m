function val = triple_reccurence_start(x_val,shift)
x = x_val-shift  ;
val =0;
if ((x> 0) &&( x <=1))
    %val =   (7*x^3)/4 - (9*x^2)/2 + 3*x     % x*(1-x)*(1-x) + (2-x)*(x)*(1-x)/2+(2-x)*(x)*(2-x)/4 ;|| 
    val =21/2;
elseif ((x>=1)&&(x<2))
   % val= - x^3/4 + (3*x^2)/2 - 3*x + 2      %(2-x)*(2-x)*(2-x)/4 ;||
    val =-3/2;
end