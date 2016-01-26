z=0;
weights1;
zz=NaN(length(xClean),length(yClean));
for xi=1:length(xClean)
    for yi=1:length(yClean)
        x = xClean(xi);
        y = yClean(yi);
        z=0;
       for i= 1:knotsPerAxis
            for k= 1:knotsPerAxis
                horizontal= bSpline3(x-knots(i));%*bSpline3(y-knots(yOffset));%W(xOffset,yOffset) ;
                vertical =bSpline3(y-knots(k));
                splineproduct(i,k) =horizontal *vertical*weights1(i,k); 
                z = z+ splineproduct(i,k);
            end
        end
        zz(xi,yi)=z;
    end
end
figure (7)
for i=1:nSensors
    x = xSensor(i);   
    y = ySensor(i);
    z = zMess(i);
    c = zClean(i);
    plot3([x x], [y y], [c z],'k');
    plot3(x,y, c,'ro'); 
    hold on;
   plot3(x,y,z,'k*'); % plot of clean data with sensors
end

surf(xClean,yClean,zz)
hold off
