 function [val,derv] = Double_reccurence_end_modified(x_val,shift,width)
%  x = x_val-shift+2  ;
% val =0;
% derv=0;
% if ((x>=.5)&&(x<1))
%     val= val + ((x-.5)/1.5) * (x-.5) *((x-.5)/.5);
%     derv =8;
% elseif((x>=1)&&(x<1.5))
%     val=val+  (x-.5)/1.5  *  (x-.5)  *  ( 1.5 -x ) /.5  + ((x-.5)/1.5)  *  ( 2 - x)*((x-1)/.5)  + (2.00-x)/1.00 *(x-1.00)/1.00 *  (x-1.00)/0.50;
%     derv =-28;
%  elseif((x>=1.5)&&(x<2))
%      val=val + ((x-.5)/1.5) * (2-x)* (( 2-x)/.5) + (2-x) * (x-1)  *( (2-x)/.5) +  (2-x) * ( (2-x)/.5)  *  ((x-1.5)/.5);  
%      derv = 44;
% end
factor = 1/width;
xDiff = x_val-shift ;
xDiff = xDiff * factor;
x = xDiff +5;
val =0;
derv=0;
if ((x>=2)&&(x<3))
    val= val +x^3/6 - x^2 + 2*x - 4/3; % (x-2)*(x-2)*(x-2)/6;|
    derv =1;
elseif((x>=3)&&(x<4))
    val=val+ - (7*x^3)/12 + (23*x^2)/4 - (73*x)/4 + 227/12; %(x-2)*(x-2)*(4-x)/6 + (x-2)*(5-x)*(x-3)/6+(5-x)*(x-3)*(x-3)/4 ;
    derv =-7/2;
 elseif((x>=4)&&(x<5))
     val=val + (11*x^3)/12 - (49*x^2)/4 + (215*x)/4 - 925/12; %(x-2) *(5-x)*(5-x)/6 + (5-x)*(5-x) * (x-3) /4 + (5-x)*(5-x)*(x-4)/2;
     derv = 11/2;
end
derv =derv *factor^3;
 end

     

