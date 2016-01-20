a= rand (10);
b = rand(10);

c = NaN(length (a));
tic
%matlabpool open 2
for i = length(a)
    for j  = length (a)
    c(i,j) =a(i,j) + b(i,j);
    end
end
    
toc

tic
for i = length(a)
    parfor j  = length (a)
    c(i,j) =a(i,j) + b(i,j);
    end
end
    toc
matlabpool  close
