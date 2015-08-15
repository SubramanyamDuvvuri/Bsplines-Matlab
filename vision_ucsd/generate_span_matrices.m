% Returns the L + 3 span matrices for a cubic spline define over [3,L+3)
%
% [B_{sigma - 3}(s) B_{sigma - 2}(s) B_{sigma - 1}(s) B_{sigma}(s)]
% = [B0(s - (sigma - 3)) B0(s - (sigma - 2)) B0(s - (sigma - 1)) B0(s - sigma)]
% = [R3(s - (sigma - 3) - 3) R2(s - (sigma - 2) - 2) R1(s - (sigma - 1) - 1) R0(s - sigma) 
% = [1 s s^2 s^3] * BS_sigma
function B = generate_span_matrices(L)

% Returns the L + 3 span matrices for a cubic spline define over [3,L+3)
  
B = zeros(4,4,L+3);
sigma = reshape(0:L+2,[1,1,L+3]);
one = ones(size(sigma));

% [B_{sigma - 3}(s) B_{sigma - 2}(s) B_{sigma - 1}(s) B_{sigma}(s)]
% = [B0(s - (sigma - 3)) B0(s - (sigma - 2)) B0(s - (sigma - 1)) B0(s - sigma)]
% = [R3(s - (sigma - 3) - 3) R2(s - (sigma - 2) - 2) R1(s - (sigma - 1) - 1) R0(s - sigma) 
% = [1 s s^2 s^3] * BS_sigma

% R3(s - sigma)
B(:,1,:) = [1/6*sigma.^3 + 1/2*sigma.^2 + 1/2*sigma + 1/6
	    -1/2*sigma.^2 - sigma - 1/2
	    1/2*sigma + 1/2
	    -1/6*one];

% R2(s - sigma)
B(:,2,:) = [-1/2*sigma.^3 - sigma.^2 + 2/3
	    3/2*sigma.^2+2*sigma
	    -3/2*sigma-1
	    1/2*one];

% R1(s - sigma)
B(:,3,:) = [1/2*sigma.^3 + 1/2*sigma.^2 - 1/2*sigma + 1/6
	    -3/2*sigma.^2 - sigma + 1/2
	    3/2*sigma + 1/2
	    -1/2*one];

% R0(s - sigma)
B(:,4,:) = [-1/6*sigma.^3
	    1/2*sigma.^2
	    -1/2*sigma
	    1/6*one];