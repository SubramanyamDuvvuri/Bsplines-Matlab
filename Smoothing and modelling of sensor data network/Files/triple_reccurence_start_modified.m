function [val,derv] =triple_reccurence_start_modified(x_val,shift,width)

% x = x_val-shift  ;
% val =0;
% derv=0;
% if ((x>=0) &&( x <0.5))
%     val =  val  + (x/.5) * ((.5 -x) /.5) ^2+ (1-x) * (x-0.00)/0.50*((.5 -x)/.5) + (1-x ) * (1-x ) * (x/.5); 
%     derv =84;
% elseif ((x>=0.5)&&(x<1))
%    val= val + (1-x ) * (1 -x ) * ((1-x)/.5); 
%     derv =-12;
% end
factor = 1/width;
xDiff = x_val-shift ;
xDiff = xDiff * factor;
x = xDiff ;
val = 0 ;
derv=0;
if ((x>=0) &&( x <1))
    val =   (7*x^3)/4 - (9*x^2)/2 + 3*x;     % x*(1-x)*(1-x) + (2-x)*(x)*(1-x)/2+(2-x)*(x)*(2-x)/4 ;|| 
    derv =21/2;
elseif ((x>=1)&&(x<2))
    val= - x^3/4 + (3*x^2)/2 - 3*x + 2;      %(2-x)*(2-x)*(2-x)/4 ;||
    derv =-3/2;
end
derv =derv *factor^3;
end