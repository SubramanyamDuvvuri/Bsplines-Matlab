function val = quadruple_reccurence_end(x_val,shift)
x = x_val-shift  ;
val = 0 ;
if ((x>4)&&(x<5))
    %val=  x^3 - 12*x^2 + 48*x - 64      %(x-4)*(x-4)*(x-4);||
    val = val + 6;
end