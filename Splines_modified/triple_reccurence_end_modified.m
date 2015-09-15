function [val,derv] = triple_reccurence_end_modified(x_val,shift)
x = x_val-shift+2  ;
val =0;
derv=0;
if ((x>=1)&&(x<1.5))
    val=  val + (x-1) * (x-1) * ((x-1)/.5);
    derv =12;
elseif((x>=1.5)&&(x<2))
    val =val +  (x-1.00)/1.00 *  (x-1.00)/1.00 *  (2.00-x)/0.50 +  (x-1.00)/1.00* (2.00-x)/0.50* (x-1.50)/0.50 +  (2.00-x)/0.50* (x-1.50)/0.50* (x-1.50)/0.50;
    derv =-84    ;
end