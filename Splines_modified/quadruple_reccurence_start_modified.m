function [val,derv]= quadruple_reccurence_start_modified(x_val,shift,width)
% 
% x = x_val-shift  ;
% val =0;
% derv=0;
% if ((x>0) &&( x <=.5))
%     val =    ((.5-x)/.5)^3;
%     derv =-48;
% end
factor = 1/width;
xDiff = x_val-shift ;
xDiff = xDiff * factor;
x = xDiff ;
val = 0 ;
derv=0;
if ((x>=0) &&( x <1))
    val =    (1-x)*(1-x)*(1-x);% - x^3 + 3*x^2 - 3*x + 1;   %;||3rd derivative =
    derv =-6;
end
derv =derv *factor^3;
end

