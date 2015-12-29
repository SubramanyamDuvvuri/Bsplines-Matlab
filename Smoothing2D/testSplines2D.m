clear all;
clc
xyMin = -1;
xyMax = 1;
cleanLen= 51;
knotsPerAxis = 12;
x = -1:.2:1;
y = -1:.2:1;
weights = ones(knotsPerAxis,knotsPerAxis);
sumVal = 0;
for m =1:length (x)
    for n = 1:length(y)
        for i=1:knotsPerAxis
            for k=1:knotsPerAxis
                horizontalVal = calcSpline1D(x(m), knotsPerAxis, xyMin, xyMax, i);
                verticalVal = calcSpline1D(y(n), knotsPerAxis, xyMin, xyMax, k);
                SplineProduct(i,k) =  horizontalVal * verticalVal';
                sumVal = sumVal + SplineProduct(i,k);
            end     
        end
    end
end
plot (sumVal);
xClean= linspace(xyMin,xyMax,cleanLen);
yClean= linspace(xyMin,xyMax,cleanLen);
yClean=yClean';
zzClean = NaN(cleanLen, cleanLen);
FunctionType =0;
[xx,yy] = meshgrid(xClean, yClean);