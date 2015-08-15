%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [x,y] = evaluate_spline_curve(coefs,s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function, for all i, evaluates B-spline i, defined by
% coefs(:,:,i) at, for all j, s(j,i) in spline parameter space.  
%
% Input:
% coefs: The B-spline coefficients defining the N splines (2 x
% (L+3) x N matrix).  
% s: The points at which to evaluate the splines (ns x N matrix).  
%
% No global variables required.  
%
% Output: 
% [x,y]: (x,y)-coordinates of the points s on the splines defined
% by coefs -- each is a ns x N matrix.  
%
% No global variables set.
%
% This function goes through each curve piece of the spline, and
% finds points in s on that piece.  It calls evaluate_spline_sigma
% to find the (x,y)-coordinates of these points on the current
% pieces of the curves.  
%
% Functions called by this function:
% evaluate_spline_sigma
%
function [x,y] = evaluate_spline_curve(coefs,s)

% Number of curve pieces
L = size(coefs,2)-3;

% number of points, number of splines
[ns,N] = size(s);

% coordinates
x = nan*ones(size(s));
y = nan*ones(size(s));

% s is cyclic within 3 and L+3
s = mod(s-3,L)+3;

% B-spline coefficients
coefsx = permute(coefs(1,:,:),[3,2,1]);
coefsy = permute(coefs(2,:,:),[3,2,1]);

% Go through each piece of the curve
for sigma = 3:L+2,
  
  % Find points that lie on the current piece of the curve
  [sinds,Ninds] = find((s >= sigma) & (s < sigma+1));
  if ~isempty(Ninds),
    inds = sub2ind([ns,N],sinds,Ninds);
    
    % Evaluate the curve piece
    x(inds) = evaluate_spline_sigma(coefsx(Ninds,:),s(inds));
    y(inds) = evaluate_spline_sigma(coefsy(Ninds,:),s(inds));
  end;
end;
