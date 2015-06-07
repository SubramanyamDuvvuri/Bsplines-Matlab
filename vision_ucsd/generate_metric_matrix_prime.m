function B_metric_prime = generate_metric_matrix_prime(L)
  
  global G_sigma;
  global BS_sigma;
  
  [j,i] = meshgrid(1:4,1:4);
  
  B_metric_prime = spalloc(L+3,L+3,4*(L+3));

  for sigma = 3:L+2,
    P_prime = zeros(4,4);
    P_prime(2:end) = ((j(2:end)-1) ./ (i(2:end)+j(2:end)-2)) .* ...
	((sigma+1).^(i(2:end)+j(2:end)-2) - sigma.^(i(2:end)+j(2:end)-2));
    G = squeeze(G_sigma(:,:,sigma+1));
    B = squeeze(BS_sigma(:,:,sigma+1));
    B_metric_prime = B_metric_prime + sparse(G'*B'*P_prime*B*G);
  end;
