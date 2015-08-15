function val = Spline_45555(x_val,shift)
x = x_val+shift  ;
val = 0 ;
if ((x>4)&&(x<5))
    val=val+(x-4)*(x-4)*(x-4);
end