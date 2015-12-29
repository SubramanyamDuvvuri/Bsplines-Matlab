function Z=setSpatialField(X, Y, FunctionType)
%Z = sin(0.83.*pi.*X) .* cos(1.25.*pi.*Y); 

len = length(X);
Z = NaN(len,1);
for i=1:len
    x = X(i);
    y = Y(i);
    dist1 = (x+0.2)^2 + 1.5*(y+0.3)^2;
    z1 = 1-1.6/(1.7*dist1+1);
    
    dist2 = (x+0.5)^2 + (y-0.3)^2;
    z2 = 1.3*exp(-4*dist2);
 
    dist3 = (x-0.7)^2 + (y+0.3)^2;
    z3 = 0.8*exp(-3*dist3);
    
    z4 = 0.1*x*y;
    z = z1 + z2 + z3 + z4 -0.6; 
    %z = z2;


    if(FunctionType==2)
        if(y>-0.2 && y<0.2)
            if(x>-0.6 && x<-0.2)
                z=z+0.5;
            end
        end
    end

    if(FunctionType==3)  % bit shifted for 2D
        if(y>-0.2 && y<0.2)
            if(x>-0.2 && x<0.2)
                z=z+0.5;
            end
        end
    end    
    Z(i) = z;
    
    if(FunctionType>10)
        xxx
    end
end