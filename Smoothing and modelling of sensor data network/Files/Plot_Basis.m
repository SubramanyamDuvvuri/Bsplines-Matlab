function [  BS_Val, BS_Hori, BS_Verti] = Plot_Basis( splinesPerAxis,knotsPerAxis,vector,xyMin,xyMax)

vector_length = length(vector);

p=0;

BS_Hori = NaN(vector_length, vector_length);
BS_Verti = NaN(vector_length, vector_length);
BS_Val = NaN(vector_length, vector_length);

for splineNumberHorizontal= 1:splinesPerAxis
    for splineNumberVertical= 1:splinesPerAxis
        p=p+1;
        q=0;
        for m= 1:vector_length
            x = vector (m);
             [horizontal,HorDerv] = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal);
            for n = 1:vector_length
                q=q+1;
                y = vector (n);
                [vertical,VerDerv] = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumberVertical);
                BS_Val(p,q) =horizontal*vertical ;
                BS_Hori(p,q)= vertical*HorDerv;  %%%%%%%%%% Little Change RJ %%%%% [product rule -->(f.g)' = f'.g + g'+f  ]
                BS_Verti(p,q)= horizontal*VerDerv;
                
            end
        end
    end
end


end

