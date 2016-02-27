function [sumVal,sumderv]= calcSpline1D(xy, knotsPerAxis, xyMin, xyMax, number)
%knotspan=(xyMax-xyMin)/(knotsPerAxis-5);
knotspan=(xyMax-xyMin)/(knotsPerAxis-5);
firstknot = xyMin;
lastknot=xyMax;
%Defining knot positions
knots = linspace(xyMin,xyMax, knotsPerAxis);
sumVal = 0;
sumderv=0;

[value, derv ]=quadruple_reccurence_start_modified(xy,firstknot,knotspan);
sumVal = sumVal + value;
[value ,derv ]=triple_reccurence_start_modified(xy,firstknot,knotspan);
sumVal = sumVal + value;
sumderv =sumderv+derv;

[value, derv ]=Double_reccurence_start_modified(xy,firstknot,knotspan);
sumVal = sumVal + value;
sumderv =sumderv+derv;
 [value, derv ]=Basis_Spline_modified(xy, firstknot,knotspan);
  sumVal = sumVal + value;

% for k = 1: length(knotsPerAxis)-3
%   [value, derv ]=Basis_Spline_modified(xy, knots (k),knotspan);
%   sumVal = sumVal + value;
% end


[value ,derv ]=Double_reccurence_end_modified(xy,lastknot,knotspan);
sumVal = sumVal + value;
sumderv =sumderv+derv;

[value, derv] =triple_reccurence_end_modified(xy,lastknot ,knotspan);
sumVal = sumVal + value;
sumderv =sumderv+derv;

[value, derv] =quadruple_reccurence_end_modified(xy,lastknot ,knotspan);
sumVal = sumVal + value;
sumderv =sumderv+derv;


end
%  for i = 1:knotsPerAxis-5
%  [value, derv ]=Basis_Spline_modified(xy,number+knotspan,knotspan);
%  sumVal = sumVal + value;
%  end

% 
%                [value, derv ]=Basis_Spline_modified(xy,number+knotspan*5,knotspan);
%               sumVal = sumVal + value;
% 
%            [value, derv ]=Basis_Spline_modified(xy,lastKnot-knotspan*4,knotspan);
%            sumVal = sumVal + value;
% 
% 