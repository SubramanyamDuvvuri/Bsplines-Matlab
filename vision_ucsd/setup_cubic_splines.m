% script to precompute the matrices needed for quick evaluation of
% cubic splines.  

global L;
global B_metric;
global B_metric_prime;
global U_metric;
global BS_sigma;
global G_sigma;

BS_sigma = generate_span_matrices(L);
G_sigma = generate_placement_matrices(L);
B_metric = generate_metric_matrix(L);
B_metric_prime = generate_metric_matrix_prime(L);
U_metric = compute_curve_metric_matrix;