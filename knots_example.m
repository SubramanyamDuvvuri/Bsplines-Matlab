%knots = [1 2 3 4];
clear 
clc
knots = [ 1 1 1 1 1.5];
syms x;

for i = 1:length (knots)-2
 
xPlus = knots(1);
xMinus = knots(end);
dividerPlus = knots(end-1)-knots(1);
dividerMinus = knots(end)-knots(2);
knotsPlus = knots(1:end-1);
knotsMinus = knots(2:end);


f(i)= (x-xPlus)/dividerPlus;

fprintf('%s = (x-%3.2f)/%3.2f * B%s ', vec2Text(knots), xPlus, dividerPlus, vec2Text(knotsPlus));
fprintf('+ (%3.2f-x)/%3.2f * B%s \n \n \n',                xMinus, dividerMinus, vec2Text(knotsMinus));

knots =  knotsPlus;






end 