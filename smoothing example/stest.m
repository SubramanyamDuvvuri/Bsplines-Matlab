% stest.m - spline smoothing example 
% 
% Fred J. Frigo 
% Dec 13, 2001 

vsize = 20; 
w=linspace(0,2*pi, vsize); 

sig = 2.3*cos(3.0*w) + 1.2*sin(4.5*w) + cos(1.92*w); 
sig = sig + rand(1,vsize); 
figure(1); 
subplot(2,1,1); 
plot(w, sig); 
title('Sample input to spline smoothing'); 

smooth_factor = .999999999; 
sig_mag = abs(sig); 
ln_raw = -0.25*log(sig_mag); 
dy = exp(ln_raw); 

% Spline smoothing (DeBoor) 
spline_sig = smooth_spline( sig, dy, vsize, smooth_factor); 
subplot(2,1,2); 
plot(w, spline_sig); 
title('SPLINE SMOOTH smoothed output'); 
