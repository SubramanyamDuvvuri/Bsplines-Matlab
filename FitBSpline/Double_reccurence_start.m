function val = Double_reccurence_start(x_val,shift)
x = x_val-shift  ;
val =0;
if ((x> 0) &&( x <=1))
    val = - (11*x^3)/12 + (3*x^2)/2;%(x^2)*(1-x)/2+(3-x)*(x^2)/6+(x^2)*(2-x)/4;||
    %val =-11/2;
elseif ((x>=1)&&(x<=2))
    val= (7*x^3)/12 - 3*x^2 + (9*x)/2 - 3/2;%(x)*((2-x)^2)/4+(3-x)*(2-x)*x/6+(3-x)^2*(x-1)/6;||
    %val =7/2;
    elseif ((x>=2)&&(x<3))
        val =- x^3/6 + (3*x^2)/2 - (9*x)/2 + 9/2;%((3-x)^3)/6||
        %val = -1;
end
