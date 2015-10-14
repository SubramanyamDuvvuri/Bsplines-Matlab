x = -10:1:10;
for  i = 1:length(x)
    y(i) = triple_reccurence_start_modified (x(i),4);
end

plot ( x,y)

