function B_metric = generate_metric_matrix(L)
  
  global G_sigma;
  global BS_sigma;
  
  [j,i] = meshgrid(1:4,1:4);
  
  B_metric = spalloc(L+3,L+3,4*(L+3));

  for sigma = 3:L+2,
    P = 1 ./ (i+j-1) .* ((sigma + 1).^(i+j-1) - sigma.^(i+j-1));
    G = squeeze(G_sigma(:,:,sigma+1));
    B = squeeze(BS_sigma(:,:,sigma+1));
    B_metric = B_metric + sparse(G'*B'*P*B*G);
  end;

B_metric = B_metric / L;