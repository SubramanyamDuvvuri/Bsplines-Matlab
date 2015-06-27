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
%     plot(xVec, yVec,'c','LineWidth',2);
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

BS = NaN(nKnots,nSensors);
for k=1:nKnots
    xk = knots(k);
    for s=1:nSensors
        xs = xSensors(s);
        diff(s)=xs-xk;
        BS(1,s) =quadruple_reccurence_start(.5,0);
    end
end

% now get the weights by Penrose Pseudo Inverse
weights = BS'\ySensors;

% now plotting the result
spanSpline = 2; % of 3rd order B-Spline


%xLen = xGrid*(xMax-xMin)+1;
yFit = zeros(xLen,1);

for i = 1:xLen
    aa= quadruple_reccurence_start(xVec(i),4);
    a(i)=aa*weights(1);
     
end
for i = 1:xLen
    bb=triple_reccurence_start(xVec(i),4);
    b(i)=bb*weights(2);
end
 for i = 1:xLen
     cc= Double_reccurence_start(xVec(i),4);
     c(i)=cc*weights(3);
 end

 for i = 1:xLen
     dd1= Basic_Spline_start(xVec(i),4);
     d1(i)=dd1*weights(4);
dd2= Basic_Spline_start(xVec(i),3);
     d2(i)=dd2*weights(5);
dd3= Basic_Spline_start(xVec(i),2);
     d3(i)=dd3*weights(6);
dd4=Basic_Spline_start(xVec(i),1);
     d4(i)=dd4*weights(7);
dd5= Basic_Spline_start(xVec(i),0);
     d5(i)=dd5*weights(8);
dd6= Basic_Spline_start(xVec(i),-1);
     d6(i)=dd6*weights(9);
dd7= Basic_Spline_start(xVec(i),-2);
     d7(i)=dd7*weights(10);
dd8= Basic_Spline_start(xVec(i),-3);
     d8(i)=dd8*weights(11);
dd9= Basic_Spline_start(xVec(i),-4);
     d9(i)=dd9*weights(12);
  dd10= Basic_Spline_start(xVec(i),-5);
     d10(i)=dd10*weights(13);
 end 
%     ee=Spline_12345(xVec(i),-3);
%      e(i)=ee;
for i = 1:xLen
ee=Basic_Spline_end(xVec(i),-6);
     e(i)=ee*weights(4);
    ff=Double_reccurence_end(xVec(i),-7);
    f(i)=ff*weights(3);
end 

for i = 1:xLen
    gg=triple_reccurence_end(xVec(i),-8);
    g(i)=gg*weights(2);
end 

for i = 1:xLen
    hh=quadruple_reccurence_end(xVec(i),-9);
    h(i)=hh*weights(1);      
end

 plot (xVec,a,'b',xVec,b,'r',xVec,c,'b',xVec,e,xVec,f,xVec,g,xVec,h )
 hold on
plot (xVec,d1,'r',xVec,d2,'r',xVec,d3,'r',xVec,d4,'r',xVec,d5,xVec,d6,xVec,d7,xVec,d8,xVec,d9,xVec,d10);

for i = 1:xLen
       add(i)=a(i)+b(i)+c(i)+d1(i)+d2(i)+d3(i)+d4(i)+d5(i)+d6(i)+d7(i)+d8(i)+d9(i)+d10(i)+e(i)+f(i)+g(i)+h(i);
end

plot ( xVec,add,'b')
