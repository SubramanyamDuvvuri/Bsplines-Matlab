
nSensors = 140;
noise = 0.01;
knots = -5:8;

xMin = -5;
xMax =  8;
xGrid = 10;



x= xMin:1/xGrid:xMax;
xLen = length(x);
y = NaN(xLen,1);
for i=1:xLen
    y(i) = dummyCurve(x(i));
end
xt = (0:0.0001 :1)'
figure;
%FigureSet(1,'LTX');
yh = interp1(x,y,xt ,'linear ');
plot(xt ,yh ,'b',x,'r.');
axis ([0 1 -2 2]);


figure;
%FigureSet(1,'LTX');
yh = interp1(x,y,xt ,'linear ');
h = plot(xt ,yh ,'b',x,y,'r.');
set(h,'MarkerSize' ,8);
set(h,'LineWidth',1.2);
xlabel('Input x');
ylabel('Output y');
title('Chirp Linear Interpolation ');
set(gca ,'Box','Off');
grid on;
axis ([0 1 -2 2]);
%axisset (8);
print -depsc InterpolationLinear;

%function [] = Interpolation ();
close all;
N = 15;
%rand('state' ,2);
x = rand(N ,1);
y = sin (2*pi*2*x.^2) + 0.2*randn(N ,1);
xt = (0:0.0001 :1)'; % Test inputs


