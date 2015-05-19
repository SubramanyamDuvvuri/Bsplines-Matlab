% fitB_Spline
nSensors = 140;
noise = 0.01;
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
for i=1:xLen
    zVec(i) = dummyCurve(xVec(i));
end
figure(2)
%plot (xVec,yVec,'c')


%plot3(xVec, yVec,zVec,'c','LineWidth',2);      %for 2D plot

 
hold on;

% create noisy measurements
xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = sort(xSensors);
ySensors = NaN(nSensors,1);

for i=1:nSensors
    ySensors(i)=dummyCurve(xSensors(i)) + noise*randn();
end
for i=1:nSensors
    zSensors(i)=dummyCurve(xSensors(i)) + noise*randn();
end

%plot (xSensors,ySensors,'rd')


%plot3(xSensors, ySensors,zSensors ,'rd');          % for 2D Plot

% creating table with influence of knots
nKnots = length(knots);
fprintf('Smoothing with %i knots \n',nKnots);

BS = NaN(nKnots,nSensors);
for k=1:nKnots
    xk = knots(k);
    for s=1:nSensors
        xs = xSensors(s);
        BS(k,s) = bSpline3(xs-xk);
    end
end

% now get the weights by Penrose Pseudo Inverse
weights = BS'\ySensors;

% now plotting the result
spanSpline = 4; % of 3rd order B-Spline


%xLen = xGrid*(xMax-xMin)+1;
yFit = zeros(xLen,1);
zFit = zeros (xLen,1);

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
        indexY = xIndex+i-1
        if(indexY>0 && indexY<=xLen)
            yFit(indexY)=yFit(indexY)+ weights(k)*y
        end
    end
    var=weights(k)*ySpline;
    %plot(xSpline, var, 'g');
    %plot(xMin,0,'b'); % dummy for legend
    
   for i = 1 : length (var)
       z(i)= bSpline3(xSpline(i)).*bSpline3(var(i));
      plot3 (xSpline(i),z(i),var(i),'r','Linewidth',5);
   end
     
   
    hold on;
   % hold on;
   % yFit(xIndex:xIndex+xPoints-1) = yFit(xIndex:xIndex+xPoints-1) + weights(k)*ySpline;
end



%plot(xVec,yFit,'b');
%legend('Clean Data','Noisy Measurements','Spines','Fit');
hold off;




