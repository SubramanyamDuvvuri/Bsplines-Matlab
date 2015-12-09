% fitB_Spline
clear all
clc
nSensors = 100;
noise = 0.1;
knots = -5:6;
nKnots = length(knots);
xMin = -5;
xMax =  6;
xGrid = 10;
xVec= xMin:1/xGrid:xMax;
xLen = length(xVec);
yVec = NaN(xLen,1);
yVec = xMin:1/xGrid:xMax;
firstKnot =knots(1);
lastKnot =knots(end);
knotspan =1;
hold on;
[Xvec,Yvec] = meshgrid(xVec ,yVec);
Zvec = NaN(length(Xvec),length(Yvec));
for i = 1:length(Xvec)
    for j = 1:length (Yvec)
        x =Xvec(i,j);
         y = Yvec(i,j);
        Zvec(i,j) = dummyCurve ( x ,1) *dummyCurve (y,1);
    end
end
%figure (3);
%plot3(Xvec,Yvec,Zvec);
 
xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = sort(xSensors);
ySensors = NaN(nSensors,1);
ySensors= xMin + (xMax-xMin)*rand(nSensors,1);


%taking the matrix of sensors
[XSENSORS,YSENSORS] = meshgrid ( xSensors , ySensors);
zSensors = NaN(nSensors,1);
for i = 1:nSensors
zSensors(i)= dummyCurve(xSensors(i) ,1) * dummyCurve(ySensors(i),1 ) +noise*randn();
end
hold on
plot3(xSensors,ySensors, zSensors,'y*');
surf (Xvec,Yvec,Zvec);
hold off


p =0;
for  i = 1:nKnots
    for j= 1:nKnots
         p=p+1;
        for q= 1:nSensors
            xs = xSensors (q);
            ys =ySensors(q);
            %BS(p,q) = bSpline3(xs-knots(i)) * bSpline3(ys-knots(j));
            value(1,q)=quadruple_reccurence_start_modified(xs,firstKnot,knotspan)*quadruple_reccurence_start_modified(xs,firstKnot,knotspan);
            value(2,q)=triple_reccurence_start_modified(xs,firstKnot,knotspan)*triple_reccurence_start_modified(xs,firstKnot,knotspan);
            value(3,q)=Double_reccurence_start_modified(xs,firstKnot,knotspan)*Double_reccurence_start_modified(xs,firstKnot,knotspan);
            for k=1:nKnots-4
                for l = 1:nKnots -4
                    [value(3+k+p,q)]=Basis_Spline_modified(xs,knots(k),knotspan)*Basis_Spline_modified(xs,knots(l),knotspan);
                end
            end
            value(nKnots,q)=Double_reccurence_end_modified(xs,lastKnot,knotspan)*Double_reccurence_end_modified(xs,lastKnot,knotspan);
            value(nKnots+1+p,q)=triple_reccurence_end_modified(xs,lastKnot,knotspan)*triple_reccurence_end_modified(xs,lastKnot,knotspan);
            value(nKnots+2+p,q)=quadruple_reccurence_end_modified(xs,lastKnot,knotspan)*quadruple_reccurence_end_modified(xs,lastKnot,knotspan);
        end
    end
end



weights = value'\zSensors;


% 
% 
% 
% for i = length(XSENSORS)
%     for j = length(YSENSORS)
%         for p = 1:nknots
%             for q = 1:nknots
%         
%                 xs= XSENSORS (i,j);
%                 [value(1,j), derv(1,j) ]=quadruple_reccurence_start_modified(xs,firstKnot,knotspan);
%                 [value(2,j), derv(2,j) ]=triple_reccurence_start_modified(xs,firstKnot,knotspan);
%                 [value(3,j), derv(3,j) ]=Double_reccurence_start_modified(xs,firstKnot,knotspan);        
%                 for k=1:nknots-4;
%                     [value(3+k,j), derv(3+k,j) ]=Basis_Spline_modified(xs,knots(k),knotspan);
%                 end
%                 [value(nknots,j), derv(nknots,j) ]=Double_reccurence_end_modified(xs,lastKnot,knotspan);
%                 [value(nknots+1,j), derv(nknots+1,j)] =triple_reccurence_end_modified(xs,lastKnot,knotspan);
%                 [value(nknots+2,j), derv(nknots+2,j)] =quadruple_reccurence_end_modified(xs,lastKnot,knotspan);
%             end
%         
%         end
%    end
% end

% add1 = NaN(length( xVec), length (yVec));
% add2 = NaN(length( xVec), length (yVec));
% add3 = NaN(length( xVec), length (yVec));
% add4 = NaN(length( xVec), length (yVec));
% add5 = NaN(length( xVec), length (yVec));
% for i = 1:length(xVec)
%     for j = 1:length (yVec)
%         x_temp=X(i,j);
%         y_temp = Y(i,j);
%         
%          quadruple_start1=0;
%          quadruple_start2=0;
%          triple_start1 = 0;
%          triple_start2 = 0;
%          double_start1 = 0;
%          double_start2 = 0;
%          quadruple_end1=0;
%          quadruple_end2=0;
%          triple_end1 = 0;
%          triple_end2 = 0;
%          double_end1 = 0;
%          double_end2 = 0;
%          basic_start2=0;
%          basic_start3  =0;
%          basic_start4 =0;
%        for a =0:.66:nknots-5
%                %STARTING SPLINES
%               quadruple_start1 = quadruple_start1   + quadruple_reccurence_start_modified(x_temp,xMin+a,knotspan)   *  quadruple_reccurence_start_modified(y_temp,xMin,knotspan);
%               quadruple_start2 = quadruple_start2   + quadruple_reccurence_start_modified(x_temp,xMin,knotspan)  *   quadruple_reccurence_start_modified(y_temp,xMin+a,knotspan);              
%               triple_start1    = triple_start1      + triple_reccurence_start_modified(x_temp,xMin+a,knotspan)      *   triple_reccurence_start_modified(y_temp,xMin,knotspan);
%               triple_start2    = triple_start2      + triple_reccurence_start_modified(x_temp,xMin,knotspan)        *   triple_reccurence_start_modified(y_temp,xMin+a,knotspan);              
%               double_start1    = double_start1      + Double_reccurence_start_modified(x_temp,xMin+a,knotspan)      *   Double_reccurence_start_modified(y_temp,xMin,knotspan);
%               double_start2    = double_start2      + Double_reccurence_start_modified(x_temp,xMin,knotspan)        *   Double_reccurence_start_modified(y_temp, xMin+a,knotspan);                            
%               %ENDING SPLINES
%               quadruple_end1 = quadruple_end1  + quadruple_reccurence_end_modified(x_temp,xMax-a,knotspan)    *   quadruple_reccurence_end_modified(y_temp,xMax,knotspan);
%               quadruple_end2 = quadruple_end2   + quadruple_reccurence_end_modified(x_temp,xMax,knotspan)     *   quadruple_reccurence_end_modified(y_temp,xMax-a,knotspan);
%               triple_end1    = triple_end1     + triple_reccurence_end_modified(x_temp,xMax-a,knotspan)       *   triple_reccurence_end_modified(y_temp,xMax,knotspan);
%               triple_end2    = triple_end2     + triple_reccurence_end_modified(x_temp,xMax,knotspan)         *   triple_reccurence_end_modified(y_temp,xMax-a,knotspan);
%               double_end1    = double_end1     + Double_reccurence_end_modified(x_temp,xMax-a,knotspan)       *   Double_reccurence_end_modified(y_temp,xMax,knotspan);
%               double_end2    = double_end2     + Double_reccurence_end_modified(x_temp,xMax,knotspan)         *   Double_reccurence_end_modified(y_temp, xMax-a,knotspan);                            
%        end 
%               add1 (i,j) = quadruple_start1+ triple_start1+ double_start1;
%             add2 (i,j) = quadruple_start2 + triple_start2 + double_start2;
%             add3 (i,j)=  quadruple_end1+triple_end1+double_end1;
%             add4 (i,j)=  quadruple_end2+triple_end2+double_end2;
% %            add5 (i,j) = basic_start1 + basic_start2+basic_start3;
%     end
% end
% for i = 1:length(xVec)
%     for j = 1:length (yVec)
%         x_temp=X(i,j);
%         y_temp = Y(i,j);
%         basic_start1 = 0;
%       for shiftx= 0:1:nknots-5
%         for shifty= 0:1:nknots-5
%           basic_start1     =  basic_start1+ Basis_Spline_modified(x_temp,xMin+shiftx,knotspan)   * Basis_Spline_modified(y_temp,xMin+shifty,knotspan);               
%         end
%       end
%     add5(i,j) = basic_start1;
%     end
% end
% add_sum =add1 +add2 + add3 +add4+add5;
% surf(add_sum)
% hold off




