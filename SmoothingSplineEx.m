
% close all;
% %A = load('MotorCycle.txt ');
% A = zeros(N,N);
% for cnt = 1: size(A,2),
% A(:,cnt) = x.^(cnt -1);
% end;
% w = pinv(A)*y;
% At = zeros(length(xt),N);
% for cnt = 1: size(A,2),
% At(:,cnt) = xt.^(cnt -1);
% end;
% yh = At*w;
% figure;
% %FigureSet(1,'LTX');
% h = plot(xt ,yh ,'b',x,y,'r.');
% set(h,'MarkerSize',8);
% set(h,'LineWidth',1.2);
% xlabel('Input x');
% ylabel('Output y');
% title('Chirp Polynomial Interpolation ');
% set(gca ,'Box','Off');
% grid on;
% axis ([0 1 -2 2]);
% %AxisSet (8);
% print -depsc InterpolationPolynomial;



x = unique(xr);
y = zeros(size(x));
for cnt = 1: length(x),
y(cnt) = mean(yr(xr==x(cnt )));
end;
N = size(A ,1); % No. data set points
xt = ( -10:0.2:70)';
NT = length(xt); % No. test points
NS = 3; % No. of different splines
yh = zeros(NT ,NS);
yh(:,3) = csaps(x',y',0,xt')';
yh(:,2) = csaps(x',y',0.5 ,xt')';
yh(:,1) = csaps(x',y',1.0 ,xt')';
%FigureSet(1,'LTX');
h = plot(xt ,yh ,x,y,'k.');
set(h,'MarkerSize' ,8);
set(h,'LineWidth',1.2);
xlabel('Input x');
ylabel('Output y');
title('Motorcycle Data Smoothing Spline Regression ');
set(gca ,'Box','Off');
grid on;
axis ([-10 70 -150 90]);
%AxisSet (8);
legend('\alpha = 1.0','\alpha = 0.5','\alpha = 0.0' ,4);
print -depsc SmoothingSplineEx;
L = [0 .0001 0.001 0.01 0.2 0.5 0.9 0.99];
for cnt = 1: length(L),
alpha = L(cnt);
figure;
%FigureSet (1,'LTX');
yh = csaps(x',y',alpha ,xt')';
h = plot(xt ,yh ,x,y,'k.');
set(h,'MarkerSize' ,8);
set(h,'LineWidth',1.2);
xlabel('Input x');
ylabel('Output y');
st = sprintf('Motorcycle Data Smoothing Spline Regression \\ alpha =%6 .4f',alpha );
title(st);
set(gca ,'Box','Off');
grid on;
axis ([-10 70 -150 90]);
%AxisSet (8);
st = sprintf('print -depsc SmoothingSplineEx %04d;',round(alpha *10000));
%eval(st);
end;

x = A(: ,1);
y = A(: ,2);
figure;

h = plot(x,y,'r.');
set(h,'MarkerSize' ,6);
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
%axis ([min(x) max(x) ymin ymax ]);
%print -depsc Test;
print -depsc SmoothingProblem;

%================================================
% Linear
%================================================
figure;
%FigureSet (1,4.5 ,2.8);
A = [ones(N,1) x];
w = pinv(A)*y;
yh = [ones(size(xt)) xt]*w;
h = plot(xt ,yh ,'b',x,y,'r.');
set(h,'MarkerSize' ,8);
set(h,'LineWidth',1.2);
xlabel('Input x');
ylabel('Output y');
title('Chirp Linear Least Squares ');
set(gca ,'Box','Off');
grid on;
ymin = min(y);
ymax = max(y);
yrng = ymax -ymin;
ymin = ymin - 0.05*yrng;
ymax = ymax + 0.05*yrng;
%axis ([min(x) max(x) ymin ymax ]);
print -depsc LinearLeastSquares;