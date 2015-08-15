function U = compute_curve_metric_matrix

global B_metric;
zero = zeros(size(B_metric));
U = [B_metric,zero,
     zero,B_metric];