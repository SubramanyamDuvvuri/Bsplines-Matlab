% fitB_Spline
clear 
clc
nSensors = 120;
noise = 0.1;
knots = -5:7;
nKnots = length(knots);
xMin = -5;
xMax =  7;
xGrid = 10;
xVec= xMin:1/xGrid:xMax;
xLen = length(xVec);
yVec = NaN(xLen,1);
for i=1:xLen
    yVec(i) = dummyCurve(xVec(i),1);
end

figure(2)
plot(xVec, yVec,'k--','LineWidth',2);
hold on;

% create noisy measurements
xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = sort(xSensors);
ySensors = NaN(nSensors,1);

for i=1:nSensors
    ySensors(i)=dummyCurve(xSensors(i),1) + noise*randn();
end

plot(xSensors, ySensors, 'rd','LineWidth',1.3);

% creating table with influence of knots
nKnots = length(knots);
fprintf('Smoothing with %i knots \n',nKnots);

BS = NaN(nKnots,nSensors);


    for k=1:nKnots
        for s =1:nSensors
        xs = xSensors(s);
        BS(k,s) = bSpline3(xs-knots(k)) ;
    end
end

% now get the weights by Penrose Pseudo Inverse
%weights = BS'\ySensors;
weights = mldivide (BS',ySensors);
% now plotting the result
spanSpline = 2; % of 3rd order B-Spline


%xLen = xGrid*(xMax-xMin)+1;
yFit = zeros(xLen,1);

for k = 1:nKnots
       for s = 1:xLen
           xs= xVec(s);
           gg(k,s)= bSpline3(xs-knots(k));
       end
end

for k=1:nKnots
    xStart = knots(k)-spanSpline;
    xEnd = knots(k)+spanSpline;
    xPoints = 2*spanSpline*xGrid+1;
    xIndex = (xStart-xMin)*xGrid+1;
    ySpline = NaN(xPoints,1);
    xSpline = xStart:1/xGrid:xEnd;
    
    for i=1:xPoints
        x=-spanSpline+(i-1)/xGrid;
        y = bSpline3(x);
        ySpline(i)=y;
        indexY = xIndex+i-1;
        if(indexY>0 && indexY<=xLen)
            yFit(indexY)=yFit(indexY)+ weights(k)*y;
        end
    end
    plot(xSpline, weights(k)*ySpline, 'g','LineWidth',1.3);
    plot(xMin,0,'b'); % dummy for legend
    %hold on;
    %yFit(xIndex:xIndex+xPoints-1) = yFit(xIndex:xIndex+xPoints-1) + weights(k)*ySpline;
end


plot(xVec,yFit,'b','LineWidth',1.5);
legend('Clean Data','Noisy Measurements','Spines','Fit');
print_pos=max(ySensors-1);
box on
text(xMin+1,print_pos+.4,sprintf('Sensors =%g', nSensors));
text(xMin+1, print_pos+.3,sprintf('Number of knots= %g', nKnots ));
text(xMin+1,print_pos+.2,sprintf('First Value=%g,Last value=%g ',xMin, xMax));
text(xMin+1,print_pos+.1,sprintf('Noise= %g ',noise));
box off
xlabel(['\fontsize{13}Knots---->']);
ylabel(['\fontsize{13}Weights---->']);
title(['\fontsize{14}Regression Spline Uniform B-Spline fit']);
hold off;


for i=1:nKnots
    fprintf('Spline height %3.3f at postion %3.3f \n',weights(i),knots(i));
end




