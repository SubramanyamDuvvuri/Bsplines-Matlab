clear;

nSensors = 140;
noise = 0.1;
xMin = -5;
xMax =  8;
xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = sort(xSensors);
%xSensors=linspace(xMin,xMax,nSensors); % only for testing

knots = -5:8;
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
    BS(nKnots+1,s) =Double_reccurence_end(xs,lastKnot);
    BS(nKnots+2,s) =triple_reccurence_end(xs,lastKnot);
    BS(nKnots+3,s) =quadruple_reccurence_end(xs,lastKnot);
end

figure(1);
plot(xSensors,BS);
