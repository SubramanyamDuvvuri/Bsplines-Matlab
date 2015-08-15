%%Constructing splines
x = 2*pi*[0 1 .1:.2:.9];
y = cos(x);
cs = csapi(x,y);
fnplt(cs,2);
axis([-1 7 -1.2 1.2])
hold on
plot(x,y,'o')
csp = csapi ( x,y);
fnplt (cs ,2 , 'r')

pl =spapi (3,x,y);
fnplt (pl,'g')