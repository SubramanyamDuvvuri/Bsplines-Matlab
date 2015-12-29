function [val,derv] = quadruple_reccurence_end_modified(x_val,shift,width)

factor = 1/width;
%x_val = x_val*factor;
xDiff = x_val-shift ;
xDiff = xDiff * factor;
x = xDiff + 5;
val = 0 ;
derv=0;
if ((x>=4)&&(x<=5))
    val=  x^3 - 12*x^2 + 48*x - 64;      %(x-4)*(x-4)*(x-4);||
    derv =6;
end
derv = derv * factor^3;
end