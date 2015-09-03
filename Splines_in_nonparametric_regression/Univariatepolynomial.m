%Example from Splines in nonparametric regression%
clc
clear
noise = .0;
knots = 0:10;
xMin= knots(1);
xMax = knots(end);
xVec = xMin:.01:xMax;
nknots = length(knots);
nSensors = 100;

for i = 1:length(xVec)
    yVec(i)= example_curve(xVec (i));
    %yVec (i) = 3^i-2^i+exp(-5*i) +exp (-20 * (i-.5)^2)+noise*randn();
end

plot (xVec,yVec);
hold on   
load DataRandom1000;  %randomXpositions  randomYpositions  randomZ   

%xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = xMin + (xMax-xMin)* (0.5 *randomXpositions(5:nSensors+4)+0.5);  % ingore first 4 samples in random list, due to fixed postions
xSensors = sort(xSensors);
ySensors = NaN(nSensors,1);

for i=1:nSensors
    %ySensors(i)=dummyCurve(xSensors(i)) + noise*randn();
    ySensors(i)=example_curve(xSensors(i)) + noise*randomZ(i);
end

plot(xSensors, ySensors,'+');

BS = NaN(nknots+2,nSensors);

firstKnot=knots(1);
lastKnot =knots(end);


for s=1:nSensors
    xs = xSensors(s);
    BS(1,s) =quadruple_reccurence_start(xs,firstKnot);
    BS(2,s)=triple_reccurence_start(xs,firstKnot);
    BS(3,s)=Double_reccurence_start(xs,firstKnot);        
    for k=1:nknots-4;
        BS(3+k,s)=Basic_Spline_start(xs,knots(k));
    end
     BS(nknots,s)=Double_reccurence_end(xs,lastKnot);
    BS(nknots+1,s) =triple_reccurence_end(xs,lastKnot);
    BS(nknots+2,s) =quadruple_reccurence_end(xs,lastKnot);
    
end
weigths = BS'






