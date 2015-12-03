function return=function_spline(x)
return = 0;
if((x<=0) && (x>-2)) %
    if(x<=-1)
        return = 1/6*(2+x)^3;
    else
        return = 1/6*(4-6*x^2-3*x^3);
    end
end

if(x>0 && x<2)
    if(x<=1)
        return = 1/6*(4-6*x^2+3*x^3);
    else
        return = 1/6*(2-x)^3;
    end
end