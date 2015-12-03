%ExampleMesh to add 2D splines


xLin = -5:0.1:5;
yLin = -5:0.1:5;

[xx,yy ] = meshgrid(xLin,yLin);

lenX = length(xLin);
lenY = length(yLin);

zz = NaN(lenX, lenY);

for xi=1:lenX
    for yi=1:lenY
        x = xx(xi,yi);
        y = yy(xi,yi);
        
        z=0;
        
        for xOffset = -3:3
            for yOffset = -3:3
                z = z+bSpline3(x-xOffset)*bSpline3(y-yOffset);
            end
        end
        zz(xi,yi)=z;
    end
end

figure(3);
surf(xx,yy,zz');
