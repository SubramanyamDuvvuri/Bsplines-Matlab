function val = Spline_34555(x_val,shift)
x = x_val+shift  ;
val =0;
if ((x>=3)&&(x<=4))
    val= val + (x-3)*(x-3)*(x-3)/4;
elseif((x>=4)&&(x<=5))
    val=val+  (x-3)*(x-3)*(5-x)/4 + (x-3)*(5-x)*(x-4)/2 + (5-x)*(x-4)*(x-4);    
end