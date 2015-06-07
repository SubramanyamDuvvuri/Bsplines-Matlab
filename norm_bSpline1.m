function val = norm_bSpline1(x,knots)
val =0;
for i = 1:length(knots)
    
    if ((x>=knots(i))&(x<knots(end)))
        val =1;
    end
end

