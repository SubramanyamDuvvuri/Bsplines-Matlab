function [val,derv]= quadruple_reccurence_start_modified(x_val,shift)
x = x_val-shift  ;
val =0;
derv=0;
if ((x>0) &&( x <=.5))
    val =    (.5-x)*(.5-x)*(.5-x);
    derv =-6;
end

