clc
clear
N = 140;
x = rand(N ,1);
y = cos (2*pi*2*x.^2) + 0.2*randn(N ,1);

Xt = (0:0.0001 :1)'; % Test inputs
XX = zeros(N,N);
for i = 1: size(XX,2),
XX(:,i) = x.^(i -1);
end;
mat = pinv(XX)*y;
M = zeros(length(Xt),N);
for j = 1: size(XX,2),
M(:,j) = Xt.^(j -1);
end;
Yh = M*mat;
figure;
plot(Xt ,Yh ,'r',x,y,'b*');
axis ([0 1 -2 2]);
surf ( XX,M)

