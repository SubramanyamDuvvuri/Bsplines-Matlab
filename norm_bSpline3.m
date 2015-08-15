%Normalised bSpline of Degree 3

function val = norm_bSpline3 (t,knots)
val =0;
for i = [knots]
if ((t>=i)& (t<i+1))
    val = ((t-i)^2)/2;
    
elseif((t>=i+1)&(t<i+2))
    val = (-3 + 6*(t-i)-2*(t-i)^2)/2;
    
elseif((t>=i+2)&(t<i+3))
    val=((3-(t-i))^2)/2;
    
else
    val =0;
end
end
        




