function [val,derv] = Basis_Spline_modified (x_val,shift)
x = x_val-shift  ;
val =0;
derv = 0;
if ((x>= 0) &&( x <.5))
    val = val +(2*x^3)/15;
    derv =1;
elseif ((x>=.5)&&(x<1))
    val= val + (x/1.5)*(1-x)*(x) + (x/1.5)*(x)*((x-.5)/.5) +((2-x)/1.5)*(x-.5)*((x-.5)/.5);
    derv =-3;
elseif((x>=1)&&(x<1.5))
    val=val+ (x/1.5)*x*((1.5-x)/.5)  + ((2-x)/1.5 )*( x-.5) *((1.5-x)/.5) + ((2-x)/1.5) *(2-x)*(x-1);
    derv =3;
 elseif((x>=1.5)&&(x<2))
     val=val + ((2-x)^3)/(1.5*.5);
     derv =-1;
end