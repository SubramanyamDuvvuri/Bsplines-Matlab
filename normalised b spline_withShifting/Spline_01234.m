function val = Spline_01234 (x_val,shift)
x = x_val+shift  ;
val =0;
if ((x>= 0) &&( x <=1))
    val = val + x*x*x/6;
elseif ((x>=1)&&(x<=2))
    val= val +x*x*(2-x)/6+x*(3-x)*(x-1)/6+(4-x)*(x-1)*(x-1)/6;
elseif((x>=2)&&(x<=3))
    val=val+ x*(3-x)*(3-x)/6+(4-x)*(x-1)*(3-x)/6+(4-x)*(4-x)*(x-2)/6;
 elseif((x>=3)&&(x<=4))
     val=val + (4-x)*(4-x)*(4-x)/6;
end