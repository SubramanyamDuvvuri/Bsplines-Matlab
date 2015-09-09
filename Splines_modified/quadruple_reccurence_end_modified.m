function [val,derv] = quadruple_reccurence_end(x_val,shift)
x = x_val-shift +5 ;
val = 0 ;
derv=0;
if ((x>=1.5)&&(x<2))
    val=  ((x-1.5)/.5 )^3;
    derv =6;
end
