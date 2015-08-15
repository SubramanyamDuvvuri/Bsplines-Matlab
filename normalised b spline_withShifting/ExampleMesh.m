%ExampleMesh to add 2D splines
clear

xLin = -10:0.1:10;
yLin = -10:0.1:10;

[xx,yy ] = meshgrid(xLin,yLin);

lenX = length(xLin);
lenY = length(yLin);

zz = NaN(lenX, lenY);


for xi=1:lenX
    for yi=1:lenY
        x = xx(xi,yi);
        y = yy(xi,yi);
        
         z_00001=0;
         z_00012=0;
         z_00123=0;
         z_01234=0;
         z_12345=0;
         z_23455=0;
         z_34555=0;
         z_45555=0;
         
        for xOffset = 0:3
            for yOffset = 0:3
 %              z_00001 =  z_00001+Spline_00001(x-xOffset )*Spline_00001(y-yOffset);
%                 z_00012= z_00012+Spline_00012(x)*Spline_00012(y);
%                 z_00123=  z_00123+Spline_00123(x-xOffset)*Spline_00123(y-yOffset);
                   z_01234= z_01234+Spline_01234(x-xOffset)*Spline_01234(y-yOffset);
                  z_12345=z_12345+Spline_12345(x-xOffset)*Spline_12345(y-yOffset);
                 z_23455= z_23455+Spline_23455(x-xOffset)*Spline_23455(y-yOffset);
 %                  z_34555=z_34555+Spline_34555(x-xOffset)*Spline_34555(y-yOffset);
     %            z_45555= z_45555+Spline_45555(x-5)*Spline_45555(y-5);
            end
        end
         zz_12345(xi,yi)=z_12345;
         zz_23455(xi,yi)= z_23455;
         zz_01234(xi,yi)= z_01234;
        sum(xi,yi)=z_00001+z_00012+ z_00123+z_01234+ z_12345+z_23455+ z_34555+z_45555;
    end
end

figure(3);
surf(xx,yy, zz_12345);
hold on
surf(xx,yy, zz_01234)
hold on 
surf(xx,yy, zz_23455)

