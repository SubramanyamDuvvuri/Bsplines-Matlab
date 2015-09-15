 function [val,derv] = Double_reccurence_end_modified(x_val,shift)
 x = x_val-shift+2  ;
val =0;
derv=0;
if ((x>=.5)&&(x<1))
    val= val + ((x-.5)/1.5) * (x-.5) *((x-.5)/.5);
    derv =8;
elseif((x>=1)&&(x<1.5))
    val=val+  (x-.5)/1.5  *  (x-.5)  *  ( 1.5 -x ) /.5  + ((x-.5)/1.5)  *  ( 2 - x)*((x-1)/.5)  + (2.00-x)/1.00 *(x-1.00)/1.00 *  (x-1.00)/0.50;
    derv =-28;
 elseif((x>=1.5)&&(x<2))
     val=val + ((x-.5)/1.5) * (2-x)* (( 2-x)/.5) + (2-x) * (x-1)  *( (2-x)/.5) +  (2-x) * ( (2-x)/.5)  *  ((x-1.5)/.5);  
     derv = 44;
end



end

