55655555555function spline_sum= get_spline( weights , knotsPerAxis ,knotspan,knots , xMin , xMax,xVec,yVec,X,Y )
%[X,Y] = meshgrid(xVec, yVec);
add1 = NaN(length( xVec), length (yVec));
add2 = NaN(length( xVec), length (yVec));
add3 = NaN(length( xVec), length (yVec));
add4 = NaN(length( xVec), length (yVec));

for i = 1:length(xVec)
    for j = 1:length (yVec)
        x_temp=X(i,j);
        y_temp = Y(i,j);
        
         quadruple_start1=0;
         quadruple_start2=0;
         triple_start1  = 0;
         triple_start2  = 0;
         double_start1  = 0;                                       
         double_start2  = 0;
         quadruple_end1 = 0;
         quadruple_end2 = 0;
         triple_end1    = 0;
         triple_end2  = 0;
         double_end1  = 0;
         double_end2  = 0;
         basic_start1 = 0;
         basic_start2 =0;
         basic_start3=0;
         basic_start4 =0;
       
%                  %STARTING SPLINES
                     quadruple_start1 = quadruple_start1   + quadruple_reccurence_start_modified(x_temp,xMin,knotspan)        *  quadruple_reccurence_start_modified(y_temp,xMin,knotspan);%+ quadruple_reccurence_start_modified(y_temp,xMin,knotspan)        *  quadruple_reccurence_start_modified(x_temp,xMin,knotspan);
                    quadruple_start2 =  quadruple_start2   + quadruple_reccurence_start_modified(x_temp,xMin,knotspan)       *  quadruple_reccurence_end_modified(y_temp,xMax,knotspan) ;%+  quadruple_reccurence_start_modified(y_temp,xMin,knotspan)       *  quadruple_reccurence_end_modified(x_temp,xMax,knotspan);
                    quadruple_end1 = quadruple_end1       + quadruple_reccurence_end_modified(x_temp,xMax,knotspan)       *  quadruple_reccurence_end_modified(y_temp,xMax,knotspan) ;%+quadruple_reccurence_end_modified(y_temp,xMax,knotspan)       *  quadruple_reccurence_end_modified(x_temp,xMax,knotspan); 
                    quadruple_end2 = quadruple_end2       + quadruple_reccurence_end_modified(x_temp,xMax,knotspan)       *  quadruple_reccurence_start_modified(y_temp,xMin,knotspan);%+quadruple_reccurence_end_modified(y_temp,xMax,knotspan)       *  quadruple_reccurence_start_modified(x_temp,xMin,knotspan);                
% % % % % %  ------------------------------------------------------------------                 
                   triple_start1    = triple_start1      + triple_reccurence_start_modified(x_temp,xMin ,knotspan)      *   quadruple_reccurence_start_modified(y_temp,xMin,knotspan)+ triple_reccurence_start_modified(y_temp,xMin ,knotspan)      *   quadruple_reccurence_start_modified(x_temp,xMin,knotspan);
                   triple_start2    = triple_start2      + triple_reccurence_start_modified(x_temp,xMin,knotspan)        *  quadruple_reccurence_end_modified(y_temp,xMax,knotspan)+ triple_reccurence_start_modified(y_temp,xMin,knotspan)        *  quadruple_reccurence_end_modified(x_temp,xMax,knotspan);
                   triple_end1    = triple_end1      + triple_reccurence_end_modified(x_temp,xMax ,knotspan)       *  quadruple_reccurence_end_modified(y_temp,xMax,knotspan)+ triple_reccurence_end_modified(y_temp,xMax ,knotspan)       *  quadruple_reccurence_end_modified(x_temp,xMax,knotspan);  
                   triple_end2    = triple_end2      + triple_reccurence_end_modified(x_temp,xMax,knotspan)         *  quadruple_reccurence_start_modified(y_temp,xMin,knotspan)+triple_reccurence_end_modified(y_temp,xMax,knotspan)         *  quadruple_reccurence_start_modified(x_temp,xMin,knotspan);
%                   
%                   
% % % % % %  --------------------------------------------------------------------                 
                   double_start1    = double_start1      + Double_reccurence_start_modified(x_temp,xMin ,knotspan)      *   quadruple_reccurence_start_modified(y_temp,xMin,knotspan)+ Double_reccurence_start_modified(y_temp,xMin ,knotspan)      *   quadruple_reccurence_start_modified(x_temp,xMin,knotspan);
                   double_start2    = double_start2      + Double_reccurence_start_modified(x_temp,xMin,knotspan)        *   quadruple_reccurence_end_modified(y_temp,xMax,knotspan)+Double_reccurence_start_modified(y_temp,xMin,knotspan)        *   quadruple_reccurence_end_modified(x_temp,xMax,knotspan);                            
                   double_end1    = double_end1      + Double_reccurence_end_modified(x_temp,xMax ,knotspan)       *   quadruple_reccurence_end_modified(y_temp,xMax,knotspan)+Double_reccurence_end_modified(y_temp,xMax ,knotspan)       *   quadruple_reccurence_end_modified(x_temp,xMax,knotspan); 
                   double_end2    = double_end2      + Double_reccurence_end_modified(x_temp,xMax,knotspan)         *  quadruple_reccurence_start_modified(y_temp,xMin,knotspan)+Double_reccurence_end_modified(y_temp,xMax,knotspan)         *  quadruple_reccurence_start_modified(x_temp,xMin,knotspan);
% % % % % ---------------------------------------------------------------------    
                    
%                    basic_start1= basic_start1 +    Basis_Spline_modified(x_temp,xMin,knotspan)  *quadruple_reccurence_start_modified(y_temp,xMin,knotspan)+Basis_Spline_modified(y_temp,xMin,knotspan) *quadruple_reccurence_start_modified(x_temp,xMin,knotspan);
%                    basic_start2= basic_start2 +    Basis_Spline_modified(x_temp,xMin,knotspan)  *quadruple_reccurence_end_modified(y_temp,xMax,knotspan) +Basis_Spline_modified(y_temp,xMin,knotspan) *quadruple_reccurence_end_modified(x_temp,xMax,knotspan) ;
%                    
%                    basic_start3= basic_start3 +    Basis_Spline_modified(y_temp,xMax-knots(end)+knotspan,knotspan) *quadruple_reccurence_end_modified(x_temp,xMax-knots(end)+knotspan*5,knotspan)+ Basis_Spline_modified(x_temp,xMax-knots(end)+knotspan,knotspan)*quadruple_reccurence_end_modified(y_temp,xMax-knots(end)+knotspan*5,knotspan);
%                    basic_start4= basic_start4 +   Basis_Spline_modified(x_temp,xMax-knots(end)+knotspan,knotspan)  *quadruple_reccurence_start_modified(y_temp,xMin,knotspan)+Basis_Spline_modified(y_temp,xMax-knots(end)+knotspan,knotspan)*quadruple_reccurence_start_modified(x_temp,xMin,knotspan);
                   zz= 0;
                   for m = 3:knotsPerAxis
                        for n =3:knotsPerAxis
                  % basic_start1= basic_start1 +    Basis_Spline_modified(x_temp,xMin-knots(m),knotspan) * Basis_Spline_modified(y_temp,xMin-knots(n),knotspan);
                             zz = zz + Basis_Spline_modified(x_temp,xMin+knotspan*2+knots(n),knotspan) *Basis_Spline_modified(y_temp,xMin+knotspan*2+knots(m),knotspan)   ;
                        end
                   end
                   z(i,j) = zz;
             add1 (i,j) = quadruple_start1+ quadruple_start2+ quadruple_end1+quadruple_end2;
            add2 (i,j) =  triple_start1 + triple_start2 + triple_end1+triple_end2 ;
            add3(i,j) = double_start1+double_start2+double_end1+double_end2;
            add4(i,j)=basic_start1+basic_start2+basic_start3+basic_start4;
           dd(i,j)=basic_start3;
    end         
end
spline_sum = add1+add2+add3+add4+z;

