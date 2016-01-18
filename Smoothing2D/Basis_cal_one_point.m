function [  M_Splines ] = Basis_cal_one_point ( splinesPerAxis,knotsPerAxis,xCal,yCal,xyMin,xyMax)
p=0; 
for splineNumberHorizontal= 1:splinesPerAxis
                for splineNumberVertical= 1:splinesPerAxis
                    p = p+1;
                    q=1;
                    x = xCal;
                    y = yCal;
                    [horizontal,HorDerv] = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal);
                    [vertical,VerDerv] = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumberVertical);
                    M_Splines(p,q) =horizontal*vertical ;
                    
                end
            end


end

