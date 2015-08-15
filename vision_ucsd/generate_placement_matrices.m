function G = generate_placement_matrices(L)

G = zeros(4,L+3,L+3);
for sigma = 3:L+2,
  G(sub2ind([4,L+3,L+3],1:4,sigma-2:sigma+1,sigma+ones(1,4))) = 1;
end;