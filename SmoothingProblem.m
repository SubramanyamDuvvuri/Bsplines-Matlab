function [] = SmoothingProblem ();
N=10;
x =  rand(N,1);
% sin (2*pi*2*x.^2) + 0.2*randn(N ,1);
y = sin (2*pi*2*x.^2) + 0.2*randn(N ,1);
figure;
%FigureSet(1,'LTX');
h = plot(x,y,'r.');
set(h,'MarkerSize',6);
xlabel('Input x');
ylabel('Output y');
title('Motorcycle Data Set');
set(gca ,'Box','Off');
grid on;
ymin = min(y);
ymax = max(y);
yrng = ymax -ymin;
ymin = ymin - 0.05*yrng;
ymax = ymax + 0.05*yrng;
axis ([min(x) max(x) ymin ymax ]);
%AxisSet (8);
%print -depsc Test;
print -depsc SmoothingProblem;

return;