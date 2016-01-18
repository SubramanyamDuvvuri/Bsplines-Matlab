function [ BS ] =  myfun(s,xs,knots,firstKnot,lastKnot,nknots)
     BS(1,s) =quadruple_reccurence_start(xs,firstKnot);
    BS(2,s)=triple_reccurence_start(xs,firstKnot);
    BS(3,s)=Double_reccurence_start(xs,firstKnot); 
    %myfun(BS,s,xs,knots);
    
    
    
    for k=1:nknots-4;
        BS(3+k,s)=Basic_Spline_start(xs,knots(k));
    end
     BS(nknots,s)=Double_reccurence_end(xs,lastKnot);
    BS(nknots+1,s) =triple_reccurence_end(xs,lastKnot);
    BS(nknots+2,s) =quadruple_reccurence_end(xs,lastKnot);
end


