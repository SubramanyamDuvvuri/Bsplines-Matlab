function a =bezier(x1,y1,x2,y2,x3,y3)
plot (x1,y1,'s')
hold on
plot (x2,y2,'s')
hold on
plot(x3,y3,'s')
hold on
for t=0:.05:1
%     x=((1-t^3)*x1) +(3*t*((1-t^2))*x2) + (3*t^2*(1-t)*x3);
%     y=((1-t^3)*y1) +(3*t*((1-t^2))*y2) + (3*t^2*(1-t)*y3);
     x=((1-t^3)*x1) ;%+(3*t*((1-t^2))*x2) + (3*t^2*(1-t)*x3);
    y=((1-t^3)*y1) ;%;+(3*t*((1-t^2))*y2) + (3*t^2*(1-t)*y3);
    plot (x,y,'o--');
    hold on
    grid off
end