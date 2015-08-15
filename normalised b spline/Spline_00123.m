function val = Spline_00123 (x_val,shift)
x = x_val+shift  ;
val =0;
val = 0 ;
if ((x> 0) &&( x <=1))
    val = val +(x^2)*(1-x)/2+(3-x)*(x^2)/6+(x^2)*(2-x)/4;
elseif ((x>=1)&&(x<=2))
    val= val +(x)*((2-x)^2)/4+(3-x)*(2-x)*x/6+(3-x)^2*(x-1)/6;
    elseif ((x>=2)&&(x<3))
        val =val +((3-x)^3)/6;
end
