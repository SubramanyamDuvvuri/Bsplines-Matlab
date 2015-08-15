x = linspace(1,10);
y = randperm(15,5);
plot (x,y,'*')


hold on
p=polyfit (x,y,3);
pp=polyval (p,x);

plot (x,pp,'r')