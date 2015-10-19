<<<<<<< HEAD:adding_functions/Calculate_BS.m
function BS = Calculate_BS( s,xs , firstKnot , lastKnot , knotspan ,nknots , knots)
=======
%the name of the file is Calculate_Splines_DELETEIT
%Correct the file name to the function name , if this file need to be used

function BS = Calculate_Splines( knotspan ,nknots , knots , nSensors,xSensors)
firstKnot = knots (1);
lastKnot = knots(end);
for s= 1: nSensors
    xs = xSensors(s);
>>>>>>> d6568f2cad6d98b0b5cde30cb302a3f36009f141:SmoothingSpline/Calculate_Splines_DELETEIT.m
    BS(1,s) =quadruple_reccurence_start_modified(xs,firstKnot,knotspan);
    BS(2,s)=triple_reccurence_start_modified(xs,firstKnot,knotspan);
    BS(3,s) =Double_reccurence_start_modified(xs,firstKnot,knotspan);        
    for k=1:nknots-4;
            BS(3+k,s)=Basis_Spline_modified(xs,knots(k),knotspan);
    end
<<<<<<< HEAD:adding_functions/Calculate_BS.m
    BS(nknots,s)  = Double_reccurence_end_modified(xs,lastKnot,knotspan);
    BS(nknots+1,s)=triple_reccurence_end_modified(xs,lastKnot,knotspan);
    BS(nknots+2,s)=quadruple_reccurence_end_modified(xs,lastKnot,knotspan);

=======
     BS(nknots,s)=Double_reccurence_end_modified(xs,lastKnot,knotspan);
    BS(nknots+1,s) =triple_reccurence_end_modified(xs,lastKnot,knotspan);
    BS(nknots+2,s) =quadruple_reccurence_end_modified(xs,lastKnot,knotspan);
end
>>>>>>> d6568f2cad6d98b0b5cde30cb302a3f36009f141:SmoothingSpline/Calculate_Splines_DELETEIT.m
end
