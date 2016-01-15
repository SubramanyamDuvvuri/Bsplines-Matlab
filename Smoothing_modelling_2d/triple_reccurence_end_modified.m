function [val,derv] = triple_reccurence_end_modified(x_val,shift,width)
% x = x_val-shift+2  ;
% val =0;
% derv=0;
% if ((x>=1)&&(x<1.5))
%     val=  val + (x-1) * (x-1) * ((x-1)/.5);
%     derv =12;
% elseif((x>=1.5)&&(x<2))
%     val =val +  (x-1.00)/1.00 *  (x-1.00)/1.00 *  (2.00-x)/0.50 +  (x-1.00)/1.00* (2.00-x)/0.50* (x-1.50)/0.50 +  (2.00-x)/0.50* (x-1.50)/0.50* (x-1.50)/0.50;
%     derv =-84    ;

factor = 1/width;
xDiff = x_val-shift ;
xDiff = xDiff * factor;
x = xDiff +5 ;
val = 0 ;
derv=0;
if ((x>=3)&&(x<4))
    val=  x^3/4 - (9*x^2)/4 + (27*x)/4 - 27/4;%(x-3)*(x-3)*(x-3)/4||
    derv =3/2;
elseif((x>=4)&&(x<5))
   val= - (7*x^3)/4 + (87*x^2)/4 - (357*x)/4 + 485/4; % (x-3)*(x-3)*(5-x)/4 + (x-3)*(5-x)*(x-4)/2 + (5-x)*(x-4)*(x-4);||
    derv =-21/2    ;
end
derv =derv *factor^3;
end