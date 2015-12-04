% fitB_Spline
clear 
clc
nSensors = 100;
noise = 0.1;
knots = -5:8;
xMin = -5;
xMax =  8;
xGrid = 10;
xVec= xMin:1/xGrid:xMax;
xLen = length(xVec);
yVec = NaN(xLen,1);

for i=1:xLen
    yVec(i) = dummyCurve(xVec(i),1);
end
[XVEC,YVEC] = meshgrid (xVec,yVec);
figure(2)
plot(xVec, yVec,'c','LineWidth',2);
hold on;

% create noisy measurements
xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = sort(xSensors);
ySensors = xSensors;

% for i=1:nSensors
%     ySensors(i)=dummyCurve(xSensors(i),1) + noise*randn();
% end

[XSENSORS,YSENSORS] = meshgrid(xSensors,ySensors);


for i = 1:nSensors
    for j = 1:nSensors
        z(i,j)=dummyCurve(XSENSORS(i,j),1)*dummyCurve(YSENSORS(i,j),1)+noise*randn();
    end
end 
% plot(xSensors, ySensors, 'rd');

%surf (XSENSORS,YSENSORS,z);

% creating table with influence of knots
nKnots = length(knots);
fprintf('Smoothing with %i knots \n',nKnots);

BS = NaN(nKnots,nSensors);


for k=1:nKnots
    for s=1:nSensors
        xs = xSensors(s);
        BS(k,s) = bSpline3(xs-knots(k)) + bSpline3(xs + knots(k));
    end
end
BS = rand (14,100);
% now get the weights by Penrose Pseudo Inverse
%weights = BS'\z;
weights= [0.471754249840517;0.140398341671294;0.0954779735393232;0.417093101340756;0.174241617401870;0.530346325531030;1.83584248824306;2.68085237911362;1.79970246159349;0.919967560560143;0.560973010605567;0.766442458473065;0.810477172046388;1.01944042981340];

W=meshgrid(weights);
W=W';
% now plotting the result
spanSpline = 2; % of 3rd order B-Spline


%xLen = xGrid*(xMax-xMin)+1;
yFit = zeros(xLen,1);


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
    plot(xSpline, weights(k)*ySpline, 'g');
    plot(xMin,0,'b'); % dummy for legend
    %hold on;
    %yFit(xIndex:xIndex+xPoints-1) = yFit(xIndex:xIndex+xPoints-1) + weights(k)*ySpline;
end



plot(xVec,yFit,'b');
legend('Clean Data','Noisy Measurements','Spines','Fit');
hold off;


for i=1:nKnots
    fprintf('Spline height %3.3f at postion %3.3f \n',weights(i),knots(i));
end


% % figure(3)
% % plot(xVec, yVec,'g:');
% % hold on;
% % plot(xSensors, ySensors);
% % %cs = csapi ( xSensors, ySensors);  %Cubic spline interpolation 
% % %fnplt (cs,1,'r-')
% % cs = fit( xSensors, ySensors,'smoothingspline');
% % plot(cs,xSensors, ySensors);
hold off;
%surf (BS)
for xi=1:length(XVEC)
    for yi=1:length(YVEC)
        x = XVEC(xi,yi);
        y = YVEC(xi,yi);
        
        z=0;
        
        for xOffset = 1:nKnots
            for yOffset = 1:nKnots
                z =z+ bSpline3(x-knots(xOffset))*bSpline3(y-knots(yOffset))*W(xOffset,yOffset) ;
            end
        end
        zz(xi,yi)=z;
    end
end

surf (XVEC,YVEC,zz);