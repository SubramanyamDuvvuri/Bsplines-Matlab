function [val,derv] = triple_reccurence_end_modified(x_val,shift)
x = x_val-shift+5  ;
val =0;
derv=0;
if ((x>=1)&&(x<1.5))
    val=  val + (x-1) * (x-1) * ((x-1)/.5);
    derv =3/2;
elseif((x>=1.5)&&(x<2))
   val= val + (x-1)* ((2-x)/.5)* (( x-1.5)/.5) + (x-1) * (x-1) (( 2-x) / .5)+ ((2-x)/.5) + ((x-1.5)/.5; 
    derv =-21/2    ;
end