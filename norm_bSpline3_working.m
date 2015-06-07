%working with first degree normalised b spline curve:norm_bSpline1

xLin = -5:.1:5;
lenx=length(xLin);
knots = [1 2];

y = NaN(lenx,1);


for i = 1:lenx

    yy= norm_bSpline1(xLin(i),knots)
    y(i)=yy;
end




plot (xLin,y)
axis ([-5 5 0 2 ])