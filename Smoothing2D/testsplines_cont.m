%testSplines2D_cont
%Basic Spline plot
for xi=1:length(xClean)
    for yi=1:length(yClean)
        x = xClean(xi);
        y = yClean(yi);
        z=0;
       for i= 1:knotsPerAxis
            for k= 1:knotsPerAxis
               horizontal = calcSpline1D(-1, knotsPerAxis, xyMin, xyMax,i );
                vertical = calcSpline1D(y, knotsPerAxis, xyMin, xyMax, k);
                splineproduct(i,k) =horizontal *vertical;%*weights(i,k) ;
                z = z+ splineproduct(i,k);
            end
        end
        zz(xi,yi)=z;
    end
end
figure (7)
%plot3(xSensors,ySensors, zSensors,'m*');
hold on
surf(xClean,yClean,zz)