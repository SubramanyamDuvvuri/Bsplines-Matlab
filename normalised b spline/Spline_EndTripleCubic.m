function val = Spline_EndTripleCubic(x5)  % previously Spline_34555
x = x5+5;
val = 0 ;
if ((x>=3)&&(x<=4))
    val= val + (x-3)*(x-3)*(x-3)/4;
elseif((x>=4)&&(x<=5))
    val=val+  (x-3)*(x-3)*(5-x)/4 + (x-3)*(5-x)*(x-4)/2 + (5-x)*(x-4)*(x-4);   % Clean up please
    %val = val + ...*x^3 + ...*x^2 + ...*x + ...;
end