function val = norm_bSpline1(x,knots)

if (( knots <= x )&& (x> knots+1))
    val = 1;
else
    val = 0;
end

