function val = triple_reccurence_end(x_val,shift)
x = x_val-shift+5  ;
val =0;
if ((x>=3)&&(x<=4))
    val=  x^3/4 - (9*x^2)/4 + (27*x)/4 - 27/4;%(x-3)*(x-3)*(x-3)/4||
    %val =3/2;
elseif((x>=4)&&(x<=5))
   val= - (7*x^3)/4 + (87*x^2)/4 - (357*x)/4 + 485/4; % (x-3)*(x-3)*(5-x)/4 + (x-3)*(5-x)*(x-4)/2 + (5-x)*(x-4)*(x-4);||
   % val =-21/2    ;
end