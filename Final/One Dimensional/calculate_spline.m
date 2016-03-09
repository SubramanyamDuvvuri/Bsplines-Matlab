
function [value , derv]  = calculate_spline ( knotspan , knots , vector_length , vector )
nknots = length(knots);
firstKnot = knots (1);
lastKnot = knots (end );
value = NaN(nknots+2,vector_length);
derv = NaN(nknots+2,vector_length);

    for s = 1: vector_length 
        xs= vector (s);
       [value(1,s), derv(1,s) ]=quadruple_reccurence_start_modified(xs,firstKnot,knotspan);
        [value(2,s), derv(2,s) ]=triple_reccurence_start_modified(xs,firstKnot,knotspan);
        [value(3,s), derv(3,s) ]=Double_reccurence_start_modified(xs,firstKnot,knotspan);        
        for k=1:nknots-4;
            [value(3+k,s), derv(3+k,s) ]=Basis_Spline_modified(xs,knots(k),knotspan);
        end
        [value(nknots,s), derv(nknots,s) ]=Double_reccurence_end_modified(xs,lastKnot,knotspan);
        [value(nknots+1,s), derv(nknots+1,s)] =triple_reccurence_end_modified(xs,lastKnot,knotspan);
        [value(nknots+2,s), derv(nknots+2,s)] =quadruple_reccurence_end_modified(xs,lastKnot,knotspan);
    end
end
        
    