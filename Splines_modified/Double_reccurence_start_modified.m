function [val,derv] = Double_reccurence_start_modified(x_val,shift,width)
% x = x_val-shift  ;
% val =0;
% derv=0;
% if ((x> 0) &&( x <.5))
%     val =val +  (x-0.00)/1.00 * (x-0.00)/0.50 * (0.50-x)/0.50 + (x-0.00)/1.00 * (1.00-x)/1.00 * (x-0.00)/0.50 + (1.50-x)/1.50 * (x-0.00)/1.00 * (x-0.00)/0.50 ;
%     derv =-44;
% elseif ((x>=.5)&&(x<1))
%     val = val +  (x-0.00)/1.00*(1.00-x)/1.00* (1.00-x)/0.50 +  (1.50-x)/1.50 * (x-0.00)/1.00 * (1.00-x)/0.50+ (1.50-x)/1.50 *(1.50-x)/1.00* (x-0.50)/0.50 ;
%     derv =28;
%     elseif ((x>=1)&&(x<1.5))
%         val = val + (1.50-x)/1.50 *  (1.50-x)/1.00* (1.50-x)/0.50;
%         derv = -8;
factor = 1/width;
xDiff = x_val-shift ;
xDiff = xDiff * factor;
x = xDiff ;
val = 0 ;
derv=0;
if ((x>= 0) &&( x <1))
    val = - (11*x^3)/12 + (3*x^2)/2;%(x^2)*(1-x)/2+(3-x)*(x^2)/6+(x^2)*(2-x)/4;||
    derv =-11/2;
elseif ((x>=1)&&(x<2))
    val= (7*x^3)/12 - 3*x^2 + (9*x)/2 - 3/2;%(x)*((2-x)^2)/4+(3-x)*(2-x)*x/6+(3-x)^2*(x-1)/6;||
    derv =7/2;
 elseif ((x>=2)&&(x<3))
       val =- x^3/6 + (3*x^2)/2 - (9*x)/2 + 9/2;%((3-x)^3)/6||
        derv = -1;
end
derv =derv *factor^3;
end