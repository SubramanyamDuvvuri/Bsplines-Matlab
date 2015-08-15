function val = Spline_00012 (x_val,shift)
x = x_val+shift  ;
val =0;
if ((x> 0) &&( x <=1))
    val = val + x*(1-x)*(1-x) + (2-x)*(x)*(1-x)/2+(2-x)*(x)*(2-x)/4 ;
elseif ((x>=1)&&(x<2))
    val= val +(2-x)*(2-x)*(2-x)/4 ;
end