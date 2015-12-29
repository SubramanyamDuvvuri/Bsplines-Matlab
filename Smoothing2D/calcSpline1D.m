function sumVal= calcSpline1D(xy, knotsPerAxis, xyMin, xyMax, number)
knotspan=(xyMax-xyMin)/(knotsPerAxis-5);
%vector=xy;
%vector_length=length(vector);
nknots = knotsPerAxis;
firstKnot = xyMin;
lastKnot = xyMax;
%value = NaN(nknots+2,vector_length);
%derv = NaN(nknots+2,vector_length);
sumVal = 0;
sumDerv = 0;
       [value, derv ]=quadruple_reccurence_start_modified(xy,firstKnot,knotspan);
       sumVal = sumVal + value;
        [value derv ]=triple_reccurence_start_modified(xy,firstKnot,knotspan);
        sumVal = sumVal + value;
        [value, derv ]=Double_reccurence_start_modified(xy,firstKnot,knotspan);   
        sumVal = sumVal + value;
%         for k=1:knotsPerAxis-4;
%             [value(3+k), derv(3+k) ]=Basis_Spline_modified(xs,xy,knotspan);
%             sumVal = sumVal + value;
%         end
        [value ,derv ]=Double_reccurence_end_modified(xy,lastKnot,knotspan);
        sumVal = sumVal + value;
        [value, derv] =triple_reccurence_end_modified(xy,lastKnot,knotspan);
        sumVal = sumVal + value;
        [value, derv] =quadruple_reccurence_end_modified(xy,lastKnot,knotspan);
        sumVal = sumVal + value;
 





