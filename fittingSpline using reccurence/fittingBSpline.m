%One more example of the regression spline
%With  the reccurence
clc
clear
nSensors = 140;
noise = 0.1;
knots = -5:15;
xMin = -5;
xMax =  15;
xGrid = 10;
xVec= xMin:1/xGrid:xMax;
xLen = length(xVec);
yVec = NaN(xLen,1);
add = 0;

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

plot(xSensors, ySensors,'mo', 'MarkerFaceColor',[.10 1 .63]);

% creating table with influence of knots
nKnots = length(knots);
BS = NaN(nKnots+2,nSensors);
firstKnot=knots(1);
lastKnot =knots(end);

for s=1:nSensors
    xs = xSensors(s);
    BS(1,s) =quadruple_reccurence_start(xs,firstKnot);
    BS(2,s)=triple_reccurence_start(xs,firstKnot);
    BS(3,s)=Double_reccurence_start(xs,firstKnot);        
    for k=1:nKnots-4;
        BS(3+k,s)=Basic_Spline_start(xs,knots(k));
    end
     BS(nKnots,s)=Double_reccurence_end(xs,lastKnot);
    BS(nKnots+1,s) =triple_reccurence_end(xs,lastKnot);
    BS(nKnots+2,s) =quadruple_reccurence_end(xs,lastKnot);
    %BS(nKnots+3,s) =
end


% now get the weights by Penrose Pseudo Inverse
weights = BS'\ySensors;

% now plotting the result
spanSpline = 2; % of 3rd order B-Spline


%xLen = xGrid*(xMax-xMin)+1;
yFit = zeros(xLen,1);

for i = 1:xLen
    aa= quadruple_reccurence_start(xVec(i),firstKnot);
    a(i)=aa*weights(1);
     
end
for i = 1:xLen
    bb=triple_reccurence_start(xVec(i),firstKnot);
    b(i)=bb*weights(2);
end
 for i = 1:xLen
     cc= Double_reccurence_start(xVec(i),firstKnot);
     c(i)=cc*weights(3);
 end
p=4;
 
     for j= 1:nKnots-4
         for i =1:xLen
           dd =Basic_Spline_start(xVec(i),knots(j));
           d(j,i)=dd;
           
     end
     hold on
      if p<nKnots+2
       mul =   d(j,:)*weights (p);
      plot (xVec,mul);
      p=p+1;
      end
        add = add + mul;
      hold on
 end

for i = 1:xLen
    ff=Double_reccurence_end(xVec(i),lastKnot);
    f(i)=ff*weights(14);
end 

for i = 1:xLen
    gg=triple_reccurence_end(xVec(i),lastKnot);
    g(i)=gg*weights(15);
end 

for i = 1:xLen
    hh=quadruple_reccurence_end(xVec(i),lastKnot);
    h(i)=hh*weights(16);      
end

 %plot (xVec,a,'b',xVec,b,'r',xVec,c,'b',xVec,e,xVec,f,xVec,g,xVec,h )
 hold on
%plot(xVec,a)
      % add=a+b+c+e+f+g+h;
       
       plot (xVec,a,xVec,b,xVec,c,xVec,f,xVec,g,xVec,h)
       
add = a+b+c+f+g+h+add;
plot ( xVec,add,'r')
hold off


