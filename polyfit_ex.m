clear;
x = [ 0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 ]
y  =[ .453 .458 .486 .63 .21 .68 .66 .73 .77 .79 .85 .87 .89 .95 .96 .97 ]


plot (x,y ,'b+')
hold on
p=polyfit(x,y,10);
pp=polyval ( p , x)
plot (x,pp)