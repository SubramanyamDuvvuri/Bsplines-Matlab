function val = Spline_23455(x_val,shift)
x = x_val+shift  ;
val =0;

if ((x>=2)&&(x<=3))
    val= val + (x-2)*(x-2)*(x-2)/6;
elseif((x>=3)&&(x<=4))
    val=val+ (x-2)*(x-2)*(4-x)/6 + (x-2)*(5-x)*(x-3)/6+(5-x)*(x-3)*(x-3)/4 ;
 elseif((x>=4)&&(x<=5))
     val=val + (x-2) *(5-x)*(5-x)/6 + (5-x)*(5-x) * (x-3) /4 + (5-x)*(5-x)*(x-4)/2;
end