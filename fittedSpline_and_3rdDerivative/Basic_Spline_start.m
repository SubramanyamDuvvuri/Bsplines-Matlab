function [val,derv] = Basic_Spline_start (x_val,shift)
x = x_val-shift  ;
val =0;
derv = 0;
if ((x>= 0) &&( x <1))
    val = val +x^3/6; % x*x*x/6;
    derv =1;
elseif ((x>=1)&&(x<2))
    val= val +- x^3/2 + 2*x^2 - 2*x + 2/3; %x*x*(2-x)/6+x*(3-x)*(x-1)/6+(4-x)*(x-1)*(x-1)/6;
    derv =-3;
elseif((x>=2)&&(x<3))
    val=val+ x^3/2 - 4*x^2 + 10*x - 22/3;%x*(3-x)*(3-x)/6+(4-x)*(x-1)*(3-x)/6+(4-x)*(4-x)*(x-2)/6;||
    derv =3;
 elseif((x>=3)&&(x<4))
     val=val + - x^3/6 + 2*x^2 - 8*x + 32/3; %(4-x)*(4-x)*(4-x)/6;||
     derv =-1;
end