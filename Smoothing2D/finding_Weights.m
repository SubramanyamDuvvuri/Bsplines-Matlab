%finding_Weights
clear BS;
p=0;
  for splineNumberHorizontal= 1:splinesPerAxis
    for splineNumberVertical= 1:splinesPerAxis
        p=p+1;
        for q= 1:nSensors
            x = xSensor (q);
            y = ySensor (q);
            horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal);
            vertical = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumberVertical);
           BS(p,q) =horizontal*vertical ;%*weights(i,k) ;
        end
   end
  end

% xVec =-1:.01:1;
% for 
% for i = 1:nSensors
%     
%       f(i)=calcSpline1D_Single(xSensor(i), knotsPerAxis, xyMin, xyMax,splineNumberHorizontal);
% end