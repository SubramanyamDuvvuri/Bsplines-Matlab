clc
clear
nSensors = 140;
noise = 0.1;
knots = -5:8;
xMin = -5;
xMax =  8;
xGrid = 10;
xVec= xMin:1/xGrid:xMax;
xLen = length(xVec);
yVec = NaN(xLen,1);

for i=1:xLen
    yVec(i) = dummyCurve(xVec(i));
end

figure(2)
    plot(xVec, yVec,'c','LineWidth',2);
hold on;
xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = sort(xSensors);
ySensors = NaN(nSensors,1);

for i=1:nSensors
    ySensors(i)=dummyCurve(xSensors(i)) + noise*randn();
end

plot(xSensors, ySensors, 'rd');

% creating table with influence of knots
nKnots = length(knots);

BS = NaN(nKnots+3,nSensors);
for k=1:nKnots
    xk = knots(k);
    for s=1:nSensors
        xs = xSensors(s);
        diff(s)=xs-xk;
        BS(1,s) =quadruple_reccurence_start(diff(s),-5);
        BS(2,s)=triple_reccurence_start(diff(s),-5);
        BS(3,s)=Double_reccurence_start(diff(s),-5);
        BS(4,s)=Basic_Spline_start(diff(s),-5);
        BS(5,s)=Basic_Spline_start(diff(s),-4);
        BS(6,s)=Basic_Spline_start(diff(s),-3);
        BS(7,s)=Basic_Spline_start(diff(s),-2);
        BS(8,s)=Basic_Spline_start(diff(s),-1);
        BS(9,s)=Basic_Spline_start(diff(s),0);
        BS(10,s)=Basic_Spline_start(diff(s),1);
        BS(11,s)=Basic_Spline_start(diff(s),2);
        BS(12,s)=Basic_Spline_start(diff(s),3);
         BS(13,s)=Basic_Spline_start(diff(s),4);
        BS(14,s)=Basic_Spline_end(diff(s),5);
        BS(15,s)=Double_reccurence_end(diff(s),5);
         BS(16,s)=triple_reccurence_end(diff(s),5);
         BS(17,s) =quadruple_reccurence_end(diff(s),5);
        
     
    end
end

% now get the weights by Penrose Pseudo Inverse
weights = BS'\ySensors;

% now plotting the result
spanSpline = 2; % of 3rd order B-Spline


%xLen = xGrid*(xMax-xMin)+1;
yFit = zeros(xLen,1);

for i = 1:xLen
    aa= quadruple_reccurence_start(xVec(i),-5);
    a(i)=aa*weights(1);
     
end
for i = 1:xLen
    bb=triple_reccurence_start(xVec(i),-5);
    b(i)=bb*weights(2);
end
 for i = 1:xLen
     cc= Double_reccurence_start(xVec(i),-5);
     c(i)=cc*weights(3);
 end

 basicspline=[-5:3];
 k=4;
 for j =1:length(basicspline)
     for i= 1:xLen
           dd =Basic_Spline_start(xVec(i),basicspline(j));
           d(i,j)=dd;
           
     end
     hold on
     plot (xVec,d*weights(k+1));
      hold on
 end

for i = 1:xLen
ee=Basic_Spline_end(xVec(i),4);
     e(i)=ee*weights(4);
    ff=Double_reccurence_end(xVec(i),4);
    f(i)=ff*weights(15);
end 

for i = 1:xLen
    gg=triple_reccurence_end(xVec(i),4);
    g(i)=gg*weights(16);
end 

for i = 1:xLen
    hh=quadruple_reccurence_end(xVec(i),4);
    h(i)=hh*weights(17);      
end

 plot (xVec,a,'b',xVec,b,'r',xVec,c,'b',xVec,e,xVec,f,xVec,g,xVec,h )
 hold on
plot(xVec,a)
       add=a+b+c+e+f+g+h;


