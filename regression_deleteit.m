clear
clc
xLin = -3:.5:3;
lenx=length(xLin);
y = NaN(lenx,1);

for i = 1:lenx
    aa= cc_delete(xLin(i));
    a(i)=aa;
     
end

plot (xLin , a,'LineWidth',1.5)

axis([-3 3 0 4])
xlabel(['\fontsize{13}Knots---->']);
ylabel(['\fontsize{13}Weights---->'])
title(['\fontsize{15}Uniform B-Spline 0th  order ']);
