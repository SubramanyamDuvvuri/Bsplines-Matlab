function val = Spline_00001(x_val,shift)
x = x_val+shift  ;
val =0;
if ((x>0) &&( x <1))
    val =(1-x)*(1-x)*(1-x);
end