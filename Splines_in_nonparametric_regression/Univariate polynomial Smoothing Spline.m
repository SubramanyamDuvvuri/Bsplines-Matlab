%Example from Splines in nonparametric regression%
clc
clear
knots = -5:3;
xMin= knots(1);
xMax = knots(end);
xVec = xMin:.1:xMax;
nknots = length(knots);


for i = 1:length(xVec)
    yVec = 4.26 * (exp(-i)-4 * exp (-2*i) +3 * exp (-3 *i));
end

plot (xVec,yVec);
    








