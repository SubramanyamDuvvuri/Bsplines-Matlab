
ww = 0;
for  i = 1 : length(xxVec)
    x = xxVec(i);
 ww(i)=  find(abs (xxVec-x)<10^-4);
end