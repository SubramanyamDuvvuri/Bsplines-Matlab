function BS = Calculate_BS( s,xs , firstKnot , lastKnot , knotspan ,nknots , knots)
BS(1,s) =quadruple_reccurence_start_modified(xs,firstKnot,knotspan);
    BS(2,s)=triple_reccurence_start_modified(xs,firstKnot,knotspan);
    BS(3,s)=Double_reccurence_start_modified(xs,firstKnot,knotspan);        
    for k=1:nknots-4;
            BS(3+k,s)=Basis_Spline_modified(xs,knots(k),knotspan);
    end
     BS(nknots,s)=Double_reccurence_end_modified(xs,lastKnot,knotspan);
    BS(nknots+1,s) =triple_reccurence_end_modified(xs,lastKnot,knotspan);
    BS(nknots+2,s) =quadruple_reccurence_end_modified(xs,lastKnot,knotspan);

end
