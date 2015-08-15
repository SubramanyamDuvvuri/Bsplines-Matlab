
t=linspace(-1,1);
x=sin(t);
y=cos(t);
[x,y]=meshgrid(x,y);

z=(x.^2);

tri=delaunay(x,y);
trimesh(tri,x,y,z)

