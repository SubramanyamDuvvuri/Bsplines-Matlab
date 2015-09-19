function knots = quantileknots01(x,nknots) ;

%	Create knots at sample quantiles. 
%	
%		INPUT (required)
%	x = independent variable.  (The knots are at sample quantiles of the
%	unique x values.)
%	nknots = number of knots
%
%	USAGE: knots = quantileknots01(x,nknots,) ;
%
%
%	Last edit: 9/16/20
%

x = unique(x) ;
n = length(x) ;
xsort = sort(x) ;   
loc = n*(1:nknots)' ./ (nknots+1) ;
knots=xsort(round(loc)) ;

