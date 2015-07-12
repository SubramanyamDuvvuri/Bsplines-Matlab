function [val,derv]= quadruple_reccurence_start(x_val,shift)
x = x_val-shift  ;
val =0;
derv=0;
if ((x>0) &&( x <1))
    val =     - x^3 + 3*x^2 - 3*x + 1;   %(1-x)*(1-x)*(1-x);||3rd derivative =
    derv =-6;
end