function [val,derv] =triple_reccurence_start_modified(x_val,shift)
x = x_val-shift  ;
val =0;
derv=0;
if ((x>=0) &&( x <0.5))
    val =  val  + (x/.5) * ((.5 -x) /.5) * ((.5 -x )/.5)+ (1-x) *( 1-x)*((.5 -x)/.5) + (1-x ) * (1-x ) * (x/.5); 
    derv =21/2;
elseif ((x>=0.5)&&(x<1))
   val= val + (1-x ) * (1 -x ) * ((1-x)/.5); 
    derv =-3/2;
end
