%Normalised bSpline of Degree 3

function val = norm_bSpline3 (t)
val =0;

for i = [0] 
if ((t>=0)& (t<1))
    val = ((t-i)^2)/2
    
elseif((t>=1)&(t<2))
    val = (-3 + 6*(t-i)-2*(t-i)^2)/2
    
elseif((t>=2)&(t<3))
    val=((3-(t-i))^2)/2
    
else
    val =0;
end
end
        




