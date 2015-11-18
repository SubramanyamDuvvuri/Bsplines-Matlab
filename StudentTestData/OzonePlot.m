%OzonePlot

clear
run('OzoneData');
[nSamples, nVar] = size(data);
fprintf('%i Variables for %i Samples read from file\n', nVar, nSamples);
%ozone	vh	wind	humidity	temp	ibh	dpg	ibt	vis	doy
ozone = data(:,1);
timeDays = data(:,10);
fahrenheit = data(:,5);
wind = data(:,3);

temperature = (fahrenheit - 32) * 5/9; 
figure(1);
plot(timeDays,ozone);
hold on;
plot(timeDays,temperature,'r');
legend('Ozone','Temperature');
xlabel('Time in Days');
ylabel('Ozone / Temperature ');
hold off;

figure(2);
plot(temperature,ozone,'d');
xlabel('Temperature');
ylabel('Ozone');

figure(3);
plot3(wind,temperature,ozone,'bd');
hold on;
for i=1:nSamples
    plot3([wind(i) wind(i)],[temperature(i) temperature(i)],[0 ozone(i)],'r');
end
xlabel('Wind');
ylabel('Temperature');
zlabel('Ozone');
axis([0 13 -5 35 0 40]);
