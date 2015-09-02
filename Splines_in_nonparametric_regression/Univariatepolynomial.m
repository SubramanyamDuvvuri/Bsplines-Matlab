%Example from Splines in nonparametric regression%
clc
clear
noise = .02;
knots = -10:2;
xMin= knots(1);
xMax = knots(end);
xVec = xMin:.1:xMax;
nknots = length(knots);


for i = 1:length(xVec)
    yVec(i) = 4.26 * (exp(-i)-4 * exp (-2*i) +3 * exp (-3 *i))+noise*randn();
end

plot (xVec,yVec);
    








