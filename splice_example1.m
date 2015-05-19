x=[1 3 5 7];y=[20 17 23 19];xi=[2 4 6];
 yi=interp1(x,y,xi);
 yi=interp1(x,y,xi,'spline');
 xp=linspace(1,7,100);yp=interp1(x,y,xp,'spline');
 plot(xp,yp,'k',x,y,'ko',xi,yi,'kv') 
xlabel('x-values'),ylabel('y-values'), 
legend('interpolated graph','given data','interpolated data') 
axis([1 7 15 24]) 