function [val,derv] = Double_reccurence_start_modified(x_val,shift)
x = x_val-shift  ;
val =0;
derv=0;
if ((x> 0) &&( x <.5))
    val = val + x * x/.5 * ((.5 -x)/.5) + ((1.5-x)/1.5) *(x)* x/.5 ; 
    derv =-11/2;
elseif ((x>=.5)&&(x<1))
    val= val + x * ( 1.5 -x) * ((x- .5)/.5) + ((1.5-x)/1.5)* x*  ((1-x)/.5) + ((1.5 -x) / 1.5) * ( 1.5 -x ) * ((x-.5) / .5); 
    derv =7/2;
    elseif ((x>=1)&&(x<1.5))
       val =val + x * (1.5 -x )* ((1.5 -x)/.5) + ((1.5 -x)/1.5) * (1.5-x) * ((1.5 -x)/.5);
        derv = -1;
end
