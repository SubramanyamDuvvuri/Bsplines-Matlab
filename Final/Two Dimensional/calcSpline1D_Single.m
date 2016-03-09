function [value, derv]= calcSpline1D_Single(xy, knotsPerAxis, xyMin, xyMax, splineNumber)
%knotspan=(xyMax-xyMin)/(knotsPerAxis-5);
knotspan=(xyMax-xyMin)/(knotsPerAxis-1);
firstknot = xyMin;
lastknot=xyMax;
%Defining knot positions
knots = linspace(xyMin,xyMax, knotsPerAxis);

switch(splineNumber)
    case 1
        [value, derv ]=quadruple_reccurence_start_modified(xy,firstknot,knotspan);
    case 2
        [value ,derv ]=triple_reccurence_start_modified(xy,firstknot,knotspan);
    case 3
        [value, derv ]=Double_reccurence_start_modified(xy,firstknot,knotspan);
        
    case knotsPerAxis
        [value ,derv ]=Double_reccurence_end_modified(xy,lastknot,knotspan);
    case knotsPerAxis+1
        [value, derv] =triple_reccurence_end_modified(xy,lastknot ,knotspan);
    case knotsPerAxis+2
        [value, derv] =quadruple_reccurence_end_modified(xy,lastknot ,knotspan);
        
    otherwise
        [value, derv ]=Basis_Spline_modified(xy, knots(splineNumber-3),knotspan);
end


