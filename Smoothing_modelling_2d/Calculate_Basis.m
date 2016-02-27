function [ BS_val] = Calculate_Basis(splinesPerAxis,knotsPerAxis,xSensor,ySensor,nSensors ,xyMin,xyMax  )
p=0;
BS_val=NaN(splinesPerAxis*splinesPerAxis,nSensors);
for splineNumberHorizontal= 1:splinesPerAxis
    for splineNumberVertical= 1:splinesPerAxis
        p=p+1;
        for q= 1:nSensors
            x = xSensor (q);
            y = ySensor (q);
            [horizontal] = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal);
            [vertical] = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumberVertical);
            BS_val(p,q) =horizontal*vertical;
        end
    end
end


end

