function val = Spline_12345 (x_val,shift)
x = x_val+shift  ;
val =0;
if ((x>= 1) &&( x <=2))
    val = val + (x-1)*(x-1)*(x-1)/6;
elseif ((x>=2)&&(x<=3))
    val= val +(x-1)*(x-1)*(3-x)/6+(4-x)*(x-1)*(x-2)/6+(5-x)*(x-2)*(x-2)/6;
elseif((x>=3)&&(x<=4))
    val=val+ (x-1)*(4-x)*(4-x)/6 + (5-x)*(x-2)*(4-x)/6 + (5-x)*(5-x)*(x-3)/6 ;
 elseif((x>=4)&&(x<=5))
     val=val + (5-x)*(5-x)*(5-x)/6;
end