function val = Spline_StartQuadCubic(x_val)
x = x_val -5;
if ((x>0) &&( x <1))
    val =(1-x)*(1-x)*(1-x);
end