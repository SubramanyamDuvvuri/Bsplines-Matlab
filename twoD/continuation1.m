%continuation of fit_spline_regression
q=0;
%weights1 = ones(nKnots,nKnots);
%weights1(5,4)=40;
z=0;
for xi=1:length(xVec)
    for yi=1:length(xVec)
        x = xVec(xi);
        y = yVec(yi);
        z=0;
       for i= 1:nKnots
            for k= 1:nKnots
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
%plot3(xSensors,ySensors, zSensors,'m*');
hold on
surf(xVec,yVec,zz)
hold off