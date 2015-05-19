for t = 1:5:100
    
    timera(t)=t;
end 

for c=1:5:100
    beamera(c) = 4;
    creamera(c) = 5;
end

figure(2);

plot (timera,beamera, 'xr');
xlabel('hello');
ylabel('hi');
legend('azimuth','elevation');