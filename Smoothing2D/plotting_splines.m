%plotting the splines
%Continuation for finding weights
for splineNumberHorizontal = 1:splinesPerAxis
    for splineNumbervertical = 1:splinesPerAxis
        for i=1:xLen
            for j=1:yLen
                x = xVec(i);
                y = yVec(j);
                horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
                vertical = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumbervertical );
                zVec(i,j) = horizontal*vertical*weights_matrix(splinesPerAxis,splinesPerAxis) ;
            end
         end

            sumZ = sumZ + zVec;
    end
end
figure(1)
sumZ=round(sumZ);
surf(xVec,yVec, sumZ);
hold off;
axis([xyMin-0.1 xyMax+0.1 -0.1 1.1]);
