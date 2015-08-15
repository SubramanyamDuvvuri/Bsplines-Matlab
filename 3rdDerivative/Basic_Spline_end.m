function [val,derv] = Basic_Spline_end (x_val,shift)
x = x_val-shift+5  ;
val =0;
derv=0;
if ((x>= 1) &&( x <=2))
    val = val + x^3/6 - x^2/2 + x/2 - 1/6;%(x-1)*(x-1)*(x-1)/6;
    derv = val + 1;
elseif ((x>=2)&&(x<=3))
    val= val +- x^3/2 + (7*x^2)/2 - (15*x)/2 + 31/6;%(x-1)*(x-1)*(3-x)/6+(4-x)*(x-1)*(x-2)/6+(5-x)*(x-2)*(x-2)/6;||
    derv = val -2;
elseif((x>=3)&&(x<=4))
   val=val+ x^3/2 - (11*x^2)/2 + (39*x)/2 - 131/6;%(x-1)*(4-x)*(4-x)/6 + (5-x)*(x-2)*(4-x)/6 + (5-x)*(5-x)*(x-3)/6 ;
    derv = val + -3;
 elseif((x>=4)&&(x<=5))
     val=val + - x^3/6 + (5*x^2)/2 - (25*x)/2 + 125/6;%(5-x)*(5-x)*(5-x)/6;
     derv=  val+ -1;
end