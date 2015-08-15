function [val,derv] = quadruple_reccurence_end(x_val,shift)
x = x_val-shift +5 ;
val = 0 ;
derv=0;
if ((x>=4)&&(x<5))
    val=  x^3 - 12*x^2 + 48*x - 64;      %(x-4)*(x-4)*(x-4);||
    derv =6;
end