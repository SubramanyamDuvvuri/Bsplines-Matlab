clear 
clc
%Two dimentional reccurance%
knots = -4 : 8;
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
         
         
         basic1 = 0;
         basic2 = 0;
         
        for a = 1:.1:4
            for b =1
                
             %%STARTING SPLINES
                
             quadruple_start1 = quadruple_start1  + quadruple_reccurence_start(x_temp,xMin+a)  *   quadruple_reccurence_start(y_temp,xMin+1);
             quadruple_start2 = quadruple_start2   + quadruple_reccurence_start(x_temp,xMin+1)  *   quadruple_reccurence_start(y_temp,xMin+a);
             
             triple_start1    = triple_start1     + triple_reccurence_start(x_temp,xMin+a)     *   triple_reccurence_start(y_temp,xMin+1);
             triple_start2    = triple_start2     + triple_reccurence_start(x_temp,xMin+1)     *   triple_reccurence_start(y_temp,xMin+a);
             
             double_start1    = double_start1     + Double_reccurence_start(x_temp,xMin+a)     *   Double_reccurence_start(y_temp,xMin+1);
             double_start2    = double_start2     + Double_reccurence_start(x_temp,xMin+1)     *   Double_reccurence_start(y_temp, xMin+a);
             
             
             %%ENDING SPLINES
             
              quadruple_end1 = quadruple_end1  + quadruple_reccurence_end(x_temp,xMax-a)  *   quadruple_reccurence_end(y_temp,xMax-1);
             quadruple_end2 = quadruple_end2   + quadruple_reccurence_end(x_temp,xMax-1)  *   quadruple_reccurence_end(y_temp,xMax-a);
             
             triple_end1    = triple_end1     + triple_reccurence_end(x_temp,xMax-a)     *   triple_reccurence_end(y_temp,xMax-1);
             triple_end2    = triple_end2     + triple_reccurence_end(x_temp,xMax-1)     *   triple_reccurence_end(y_temp,xMax-a);
             
             double_end1    = double_end1     + Double_reccurence_end(x_temp,xMax-a)     *   Double_reccurence_end(y_temp,xMax-1);
             double_end2    = double_end2     + Double_reccurence_end(x_temp,xMax-1)     *   Double_reccurence_end(y_temp, xMax-a);
             
             
             
           %  basic1     = basic1     + Basic_Spline_start(x_temp,xMin+a)*Basic_Spline_start(y_temp,xMin+2);
            % basic2     = basic2     + Basic_Spline_start ( x_temp,xMin+2) * Basic_Spline_start(y_temp,xMin+a+1);
            end 
        end
         add1 (i,j) = quadruple_start1 + triple_start1 + double_start1+basic1;
        add2 (i,j) = quadruple_start2 + triple_start2 + double_start2+basic2;
        
        add3(i,j)=  quadruple_end1+triple_end1+double_end1;
        add4(i,j)=  quadruple_end2+triple_end2+double_end2;
    
    end
end
add = add1 + add2+  add3 + add4;


%surf ( X,Y,add1);
%hold on
%surf (X,Y,add2);


%figure (2)
surf (X,Y , add)
%hold off
