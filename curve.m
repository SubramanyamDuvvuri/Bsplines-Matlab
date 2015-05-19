%  x=[0 0 0 0 ;
%     0 0 0 1 ;
%     0 0 0 0  ];
% surf (x)
% x=magic(20)
% surf (x)
% figure;
% contour (x);

% 
% hold on;
% 
% y = magic (20);
% %surf (y);
% 
% z = peaks(100);
% plot z
% zmin = floor(min(Z(:)));
% zmax = ceil(max(Z(:)));
% zinc = (zmax - zmin) / 40;
% zlevs = zmin:zinc:zmax;
% contour(Z,zlevs)

x = -2:0.2:2;
y = -2:0.2:3;
[X,Y] = meshgrid(x,y);
Z = X.*exp(-X.^2-Y.^2);

figure
contourf(X,Y,Z,'ShowText','on')