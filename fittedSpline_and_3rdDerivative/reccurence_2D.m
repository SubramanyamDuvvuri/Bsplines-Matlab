clear 
clc
%Two dimentional reccurance%
knots = -3 : 5;
nknots = length(knots);
xMin= knots(1);
xMax= knots(end);

xVec = xMin:.1:xMax;
x = 1:length(xVec);
yVec = xMin:.1:xMax;
[X,Y]=meshgrid(xVec,yVec);

add1 = NaN(length( xVec), length (yVec));
add2 = NaN(length( xVec), length (yVec));
for i = 1:length(xVec)
    for j = 1:length (yVec)
        x_temp=X(i,j);
        y_temp = Y(i,j);
        
         quadruple_start1=0;
         quadruple_start2=0;
         triple_start1 = 0;
         triple_start2 = 0;
         double_start1 = 0;
         double_start2 = 0;
         
         quadruple_end1=0;
         quadruple_end2=0;
         triple_end1 = 0;
         triple_end2 = 0;
         double_end1 = 0;
         double_end2 = 0;
         
         
         basic_start1 = 0;

         basic_start2=0;
          basic_start3  =0;
          basic_spline4 =0;
         
        for a =0:.1:nknots-1
             for b =0
                
            %STARTING SPLINES
                
            quadruple_start1 = quadruple_start1   + quadruple_reccurence_start(-x_temp,xMin+a)   *  quadruple_reccurence_start(y_temp,xMin);
%             quadruple_start2 = quadruple_start2   + quadruple_reccurence_start(x_temp,xMin)    *   quadruple_reccurence_start(y_temp,xMin+a);
% %              
%              triple_start1    = triple_start1      + triple_reccurence_start(x_temp,xMin+a) *   triple_reccurence_start(y_temp,xMin);
%              triple_start2    = triple_start2      + triple_reccurence_start(x_temp,xMin)       *   triple_reccurence_start(y_temp,xMin+a);
% %              
%              double_start1    = double_start1      + Double_reccurence_start(x_temp,xMin+a) *   Double_reccurence_start(y_temp,xMin);
%              double_start2    = double_start2      + Double_reccurence_start(x_temp,xMin)       *   Double_reccurence_start(y_temp, xMin+a);
% %              
% %              
% %              %%ENDING SPLINES
% %               
%               quadruple_end1 = quadruple_end1  + quadruple_reccurence_end(x_temp,xMax-a)  *   quadruple_reccurence_end(y_temp,xMax);
%               quadruple_end2 = quadruple_end2   + quadruple_reccurence_end(x_temp,xMax)  *   quadruple_reccurence_end(y_temp,xMax-a);
%               
%                triple_end1    = triple_end1     + triple_reccurence_end(x_temp,xMax-a)     *   triple_reccurence_end(y_temp,xMax);
%                triple_end2    = triple_end2     + triple_reccurence_end(x_temp,xMax)     *   triple_reccurence_end(y_temp,xMax-a);
%               
%                double_end1    = double_end1     + Double_reccurence_end(x_temp,xMax-a)     *   Double_reccurence_end(y_temp,xMax);
%              double_end2    = double_end2     + Double_reccurence_end(x_temp,xMax)     *   Double_reccurence_end(y_temp, xMax-a);
%               
%              
%              for shiftx= 0:.9:nknots-1
%                   for shifty= 1:.9:nknots-1
%                           basic_start1     = basic_start1     + Basic_Spline_start(x_temp,xMin+shiftx)   * Basic_Spline_start(y_temp,xMin);
%                           basic_start2     = basic_start2     + Basic_Spline_start(x_temp,xMin)   * Basic_Spline_start(y_temp,xMin+shifty);
%                           basic_start3     = basic_start3     + Basic_Spline_start(x_temp,xMin)    * Basic_Spline_start(y_temp,xMin+shiftx);   
%                   end
             end
       end 
         
            add1 (i,j) =    double_start1+quadruple_start1+ triple_start1;
            add2 (i,j) = quadruple_start2 + triple_start2 + double_start2;
         
            add3(i,j)=  quadruple_end1+triple_end1+double_end1;
            add4(i,j)=  quadruple_end2+triple_end2+double_end2;
           add5(i,j) = basic_start1 + basic_start2+basic_start3;
          
    end
end
%add = add1 + add2;%+  add3 + add4;

 
        
surf (X,Y,add1);
hold on
surf (X,Y,add3);
hold on
surf ( X,Y,add2);
hold on 
surf (X,Y,add4);

hold on
surf ( X,Y,add5);
%figure (2)
%surf (X,Y , add)
%hold off
