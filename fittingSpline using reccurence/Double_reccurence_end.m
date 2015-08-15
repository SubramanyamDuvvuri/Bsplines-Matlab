function val = Double_reccurence_end(x_val,shift)
x = x_val-shift+5  ;
val =0;

if ((x>=2)&&(x<=3))
    val= val +x^3/6 - x^2 + 2*x - 4/3; % (x-2)*(x-2)*(x-2)/6;|
    %val =1;
elseif((x>=3)&&(x<=4))
    val=val+ - (7*x^3)/12 + (23*x^2)/4 - (73*x)/4 + 227/12; %(x-2)*(x-2)*(4-x)/6 + (x-2)*(5-x)*(x-3)/6+(5-x)*(x-3)*(x-3)/4 ;
    %val =-7/2;
 elseif((x>=4)&&(x<=5))
     val=val + (11*x^3)/12 - (49*x^2)/4 + (215*x)/4 - 925/12; %(x-2) *(5-x)*(5-x)/6 + (5-x)*(5-x) * (x-3) /4 + (5-x)*(5-x)*(x-4)/2;
     %val = 11/2;
end