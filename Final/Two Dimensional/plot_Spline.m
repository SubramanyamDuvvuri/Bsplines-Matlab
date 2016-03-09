function  sumZZ  = plot_Spline( splinesPerAxis,knotsPerAxis, xVec,yVec,xyMin,xyMax,weights_matrix)

xLen = length(xVec);
yLen = length(yVec);
zVec = NaN (xLen,yLen);
sumZZ = zeros(xLen,yLen);
for splineNumberHorizontal = 1:splinesPerAxis
    for splineNumbervertical = 1:splinesPerAxis
        for i=1:xLen
            x = xVec(i);
            horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
            for j=1:yLen
                y = yVec(j);
                vertical = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumbervertical );
                zVec(i,j) = horizontal*vertical *weights_matrix(splineNumberHorizontal,splineNumbervertical)  ;
                
                
            end
        end
        
        sumZZ = sumZZ + zVec;
    end
end


end

