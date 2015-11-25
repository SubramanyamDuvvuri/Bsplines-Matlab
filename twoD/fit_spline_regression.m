% fitB_Spline

nSensors = 100;
noise = 0.1;
knots = -5:8;
nKnots = length(knots);
xMin = -5;
xMax =  8;
xGrid = 10;
xVec= xMin:1/xGrid:xMax;
xLen = length(xVec);
yVec = NaN(xLen,1);
yVec = xMin:1/xGrid:xMax;
hold on;
[Xvec,Yvec] = meshgrid(xVec ,yVec);
Zvec = NaN(length(Xvec),length(Yvec));
for i = 1:length(Xvec)
    for j = 1:length (Yvec)
        x =Xvec(i,j);
         y = Yvec(i,j);
        Zvec(i,j) = dummyCurve ( x ,1) *dummyCurve (y,1);
    end
end
figure (3);
surf(Xvec,Yvec,Zvec);
 
% create noisy measurements
xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = sort(xSensors);
ySensors = NaN(nSensors,1);
ySensors=xSensors;


%taking the matrix of sensors
[XSENSORS,YSENSORS] = meshgrid ( xSensors , ySensors);

 for i=1:nSensors
     for j =1:nSensors
    ZSENSORS(i,j)=dummyCurve(XSENSORS(i,j),1)*dummyCurve(YSENSORS(i,j),1) + noise*randn();
     end
 end

 surf(XSENSORS,YSENSORS,ZSENSORS);
 
 
% plot(xSensors, ySensors, 'rd');
% 
% % creating table with influence of knots
%nKnots = length(knots);
%fprintf('Smoothing with %i knots \n',nKnots);

% KNOTS = meshgrid(knots);
% for  i = 1:length(KNOTS)
%     for j=1:length(KNOTS)
%         for k = 1:nSensors
%             for l = 1 : nSensors
%                 BS(k,l) = bSpline3(XSENSORS(k,l) - KNOTS(i,j) ) *  bSpline3(YSENSORS(k,l) - KNOTS(i,j) );
%             end
%         end
%     end
% end



% BS = NaN(nKnots,nSensors);
% for i = 1:nKnots
% for k=1:nKnots
%     for s=1:nSensors
%         BS(k,s,i) = bSpline3( xSensors(s)-knots(k));
%     end
% end
% % now get the weights by Penrose Pseudo Inverse
% weights1(:,:,i) = BS(:,:,i)'\ySensors;
% end

%  %weights=weights1(:,:,1);
% weights =weights2;
% % now plotting the result
% spanSpline = 2; % of 3rd order B-Spline
% 
% 
% %xLen = xGrid*(xMax-xMin)+1;
% yFit = zeros(xLen,1);
% 
% 
% for k=1:nKnots
%     xStart = knots(k)-spanSpline;
%     xEnd = knots(k)+spanSpline;
%     xPoints = 2*spanSpline*xGrid+1;
%     xIndex = (xStart-xMin)*xGrid+1;
%     ySpline = NaN(xPoints,1);
%     xSpline = xStart:1/xGrid:xEnd;
%     
%     for i=1:xPoints
%         x=-spanSpline+(i-1)/xGrid;
%         y = bSpline3(x);
%         ySpline(i)=y;
%         indexY = xIndex+i-1;
%         if(indexY>0 && indexY<=xLen)
%             yFit(indexY)=yFit(indexY)+ weights(k)*y;
%         end
%     end
%     plot(xSpline, weights(k)*ySpline, 'g');
%     plot(xMin,0,'b'); % dummy for legend
%     %hold on;
%     %yFit(xIndex:xIndex+xPoints-1) = yFit(xIndex:xIndex+xPoints-1) + weights(k)*ySpline;
% end
% 
% 
% 
% plot(xVec,yFit,'b');
% legend('Clean Data','Noisy Measurements','Spines','Fit');
% hold off;
% 
% 
% for i=1:nKnots
%     fprintf('Spline height %3.3f at postion %3.3f \n',weights(i),knots(i));
% end
% 
% 
% % % figure(3)
% % % plot(xVec, yVec,'g:');
% % % hold on;
% % % plot(xSensors, ySensors);
% % % %cs = csapi ( xSensors, ySensors);  %Cubic spline interpolation 
% % % %fnplt (cs,1,'r-')
% % % cs = fit( xSensors, ySensors,'smoothingspline');
% % % plot(cs,xSensors, ySensors);
% hold off;
% 
