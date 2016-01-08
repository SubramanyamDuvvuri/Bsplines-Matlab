%finding_Weights
%COntinuation of testSplines1D_b_new
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

  weights = BS'\zMess;
  weights =round(weights);
count =0;
for i =1: splinesPerAxis
    for j =1:splinesPerAxis
        count=count+1;
        weights_matrix(i,j) = weights(count);
    end
end
weights_matrix =round(weights_matrix);
