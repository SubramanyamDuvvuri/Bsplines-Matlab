%function [] = Interpolation ();
close all;
N = 140;
%rand('state' ,2);
x = rand(N ,1);
y = cos (2*pi*2*x.^2) + 0.2*randn(N ,1);
xt = (0:0.0001 :1)'; % Test inputs
%================================================
% Linear Interpolation
%================================================
figure;
%FigureSet(1,'LTX');
yh = interp1(x,y,xt ,'linear ');
h = plot(xt ,yh ,'b',x,y,'r.');
set(h,'MarkerSize' ,8);
set(h,'LineWidth',2);
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
%================================================
% Linear Interpolation
%================================================
figure;
%FigureSet(1,'LTX');
yh = interp1(x,y,xt ,'linear ');
h = plot(xt ,yh ,'b',x,y,'r.');
set(h,'MarkerSize',8);
set(h,'LineWidth',1.2);
xlabel('Input x');
ylabel('Output y');
title('Chirp Linear Interpolation ');
set(gca ,'Box','Off');
grid on;
axis ([0 1 -2 2]);
%AxisSet (8);
print -depsc InterpolationLinear;
%================================================
% Nearest Neighbor Interpolation
%================================================
figure;
%FigureSet(1,'LTX');
yh = interp1(x,y,xt ,'nearest ');
h = plot(xt ,yh ,'b',x,y,'r.');
set(h,'MarkerSize',8);
set(h,'LineWidth',1.2);
xlabel('Input x');
ylabel('Output y');
title('Chirp Nearest Neighbor Interpolation ');
set(gca ,'Box','Off');
grid on;
axis ([0 1 -2 2]);
%AxisSet (8);
print -depsc InterpolationNearestNeighbor;
%================================================
% Polynomial Interpolation
%================================================
A = zeros(N,N);
for cnt = 1: size(A,2),
A(:,cnt) = x.^(cnt -1);
end;
w = pinv(A)*y;
At = zeros(length(xt),N);
for cnt = 1: size(A,2),
At(:,cnt) = xt.^(cnt -1);
end;
yh = At*w;
figure;
%FigureSet(1,'LTX');
h = plot(xt ,yh ,'b',x,y,'r.');
set(h,'MarkerSize',8);
set(h,'LineWidth',1.2);
xlabel('Input x');
ylabel('Output y');
title('Chirp Polynomial Interpolation ');
set(gca ,'Box','Off');
grid on;
axis ([0 1 -2 2]);
%AxisSet (8);
print -depsc InterpolationPolynomial;
%================================================
% Cubic Spline Interpolation
%================================================
figure;
%FigureSet(1,'LTX');
yh = spline(x,y,xt);
h = plot(xt ,yh ,'b',x,y,'r.');
set(h,'MarkerSize',8);
set(h,'LineWidth',1.2);
xlabel('Input x');
ylabel('Output y');
title('Chirp Cubic Spline Interpolation ');
set(gca ,'Box','Off');
grid on;
axis ([0 1 -2 2]);
%AxisSet (8);
print -depsc InterpolationCubicSpline;
%================================================
% Cubic Spline Interpolation
%================================================
figure;
%FigureSet(1,'LTX');
yt = sin (2*pi*2* xt.^2);
h = plot(xt ,yt ,'b',x,y,'r.');
set(h,'MarkerSize',8);
set(h,'LineWidth',1.2);
xlabel('Input x');
ylabel('Output y');
title('Chirp Optimal Model ');
set(gca ,'Box','Off');
grid on;
axis ([0 1 -2 2]);
%AxisSet (8);
print -depsc InterpolationOptimalModel

