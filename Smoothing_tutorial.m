%%Smoothing example%%

x = linspace(0,2*pi,51);
noisy_y = cos(x) + .2*(rand(size(x))-.5);
plot (x,noisy_y,'x')

% hold on
% cs = csapi(x,noisy_y);
% fnplt(cs ,2)
% 
% csp= csape (x, noisy_y);
% fnplt (csp,'g',2)
% 
% sp=spapi ( 3,x,noisy_y);
% fnplt(sp,2,'r')


hold on
fnplt( csapi(x, noisy_y) )
hold off
tol = .015
hold on
fnplt( spaps(x, noisy_y,tol), 'r', 2)
hold off

noisy_y([1 end]) = mean( noisy_y([1 end]) );
lx = length(x);
lx2 = round(lx/2);
range = [lx2:lx 2:lx 2:lx2];
sps = spaps([x(lx2:lx)-2*pi x(2:lx) x(2:lx2)+2*pi],noisy_y(range),2*tol);
hold on
fnplt(sps, [0 2*pi], 'k', 2)
hold off


x = 0:4;
y = -2:2;
R = 4;
r = 2;
v = zeros(3,5,5);
v(3,:,:) = [0 (R-r)/2 0 (r-R)/2 0].'*[1 1 1 1 1];
v(2,:,:) = [R (r+R)/2 r (r+R)/2 R].'*[0 1 0 -1 0];
v(1,:,:) = [R (r+R)/2 r (r+R)/2 R].'*[1 0 -1 0 1];
dough0 = csape({x,y},v,'periodic');
fnplt(dough0)
axis equal, 