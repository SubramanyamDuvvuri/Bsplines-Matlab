%Satellite project
 
%G -->Universal Gravitational Constant
G=6.6730*10^-11;
%Re-->Radius of earth
Re=6378135;%meters
%Rs-->radius of orbit
Rs=2000000;%meters
%Rs=4000000;
 
%Rt-->total radius
Rt=Re+Rs;
%Mu-->Standard gravitational parameter
%Mu=G*Me;
 
 
%Me-->Mass of Earth
Me=5.9742*10^24;
%Ms-->Mass of satellite
Ms=561;%kilogram
 
%T-->Orbital period
%T=(2*pi)*sqrt(((Rs+Re)^3)/Mu);%In seconds
%coordinates of Bremen Latitude: 53°04?30? N    Longitude: 8°48?27? E   
 
Bremen_Latitude=53.04;
Bremen_Longitude=8.48;
 
 
%Mu-->Standard gravitational parameter
Mu=G*Me;
 
 
 
%T-->Orbital period
T=((2*pi)*sqrt(((Rt)^3)/Mu));%In seconds
 
%V--> Orbital velocity
V=sqrt(Mu/(Rs+Re));
 
Theta=deg2rad(360);
 
%Angular_Velovity_Earth
Angular_Velovity_Earth=2*pi/86400;
%Angular_Velocity_Satellite--->Angular Velocity
Angular_Velocity_Satellite=Theta/T;
 
 
Mean_motion=2*pi/T;
Circum_Earth=2*pi*Re;
Circum_Orbit=2*pi*Rt;
 
Linear_Velocity=Rt*Angular_Velocity_Satellite;
inclination=85;
 b = 0.3;
load('topo.mat','topo','topomap1');
timer=0;
%%%%%%%%%%%%%%%%%%%%%%%
%CALCULATING MEAN ANOMALY
%%%%%%%%%%%%%%%%%%%%%%%%% 
for t=0:50:10*T 
timer = timer+1; 
Mean_anomaly(timer)=(2*pi*t)/T;    
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DETERMINATION OF LATITUDE AND LONGITUDE AS A FUNCTION OF TIME%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
timer=0;
 for t=0:50:10*T
     timer=timer+1;
Angular_Velocity_Earth=2*pi/86400;
 
%Longitude Determination
Longitude(timer)=atan(tan(Mean_anomaly(timer))*cosd(inclination))-(Angular_Velocity_Earth/Mean_motion)*Mean_anomaly(timer);
%Latitude Determination
Latitude(timer)=asin(sind(inclination)*sin(Mean_anomaly(timer)));
end
 
for a = 2:length(Longitude) 
if(Longitude(a-1) > Longitude(a)+ b) 
for j = a:length(Longitude) 
 Longitude(j) = Longitude(j) + pi; 
end 
end 
end 
 
Longitude = mod(Longitude*360/(2*pi) + 180, 360) - 180; 
Latitude = mod(Latitude*360/(2*pi) + 90,360) - 90; 
 
Angular_Velocity_Satellite=0;
 
 
counter=0; 
for t=0:50:10*T 
counter=counter+1; 
Time(counter)=t; 
end 
 
 
figure(1) 
plot(Time,Longitude, 'r') 
hold on 
plot(Time,Latitude, 'b') 
title('Latitude and longitude of satellite as a function of time') 
legend('Longitude','Latitude') 
xlabel('Time-->');
ylabel('Latitude and Longitude');
axis([0 8*T -180 180]) 
hold off
 
figure(2)
ax=worldmap([-89 89],[-179 179]); 
load coast 
land = shaperead('landareas', 'UseGeoCoords', true); 
geoshow(ax, land, 'FaceColor', [0.5 0.7 0.5]) 
geoshow(lat, long) 
hold on
plotm(53,8.8,'ok','MarkerFaceColor','k');
hold on
 
geoshow(Latitude,Longitude,'markersize',5);
hold on
xlabel('LONGITUDE-->');
ylabel('LATITUDE-->');
title('SATELLITE GROUND TRACK-->');
box on;
%....................Azimuth and Elevation
hold off
timer=0;
for t=0:50:10*T
timer=timer+1;
%Length(i)=sqrt((Longitude(i)-Bremen_Longitude).^2);
Length(timer)=((Bremen_Longitude-Longitude(timer)));
cosphy(timer)=cosd(Length(timer))*cosd(Latitude(timer))*cosd(Bremen_Latitude)+(sind(Latitude(timer))*sind(Bremen_Latitude));
%Distance of observer and satellite
%Distance_observer_satellite(i)= sqrt(Re^2+Rt^2-(2*Re*Rt*cosphy(i)));
sinphy(timer)=sqrt(1-(cosphy(timer))^2);
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculating Azimuth, Elevation, and Distance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
timer=0;
for t=0:50:10*T
timer=timer+1;
Distance_observer_satellite(timer)=sqrt(Re^2+Rt^2-2*cosphy(timer)*Re*Rt);
Elevation(timer)=atand((cosphy(timer)-(Re/Rt))/sinphy(timer));
Azimuth(timer)=asind((sind(Length(timer)*cosd(Latitude(timer))/sinphy(timer)))); 
if (Bremen_Longitude>Longitude(timer) && Bremen_Latitude<Latitude(timer)) 
Azimuth_new(timer)=360-Azimuth(timer); ..................% For North-West 
end
if (Bremen_Longitude<Longitude(timer) && Bremen_Latitude<Latitude(timer)) 
Azimuth_new(timer)=-Azimuth(timer);......................% For North-East  
end 
if (Bremen_Longitude<Longitude(timer) && Bremen_Latitude>Latitude(timer)) 
Azimuth_new(timer)=180+Azimuth(timer);.................% For South-East 
end 
 if (Bremen_Longitude>Longitude(timer) && Bremen_Latitude>Latitude(timer)) 
Azimuth_new(timer)=180+Azimuth(timer);.................% For South-West 
 end
 
% Selecting the visible slots
if (Elevation(timer)>0) 
Ezimuth_visible(timer)= Elevation(timer);
Azimuth_visible(timer)=Azimuth_new(timer);
Distance_observer_satellite_visible(timer)=Distance_observer_satellite(timer); 
Visible_Time(timer)=timer;
Latitude_visible_Range(timer)=Latitude(timer);
Longitude_visible_Range(timer)=Longitude(timer);
else 
Ezimuth_visible(timer)=0;
Azimuth_visible(timer)=0;
Distance_observer_satellite_visible(timer)=0;    
Elevation_visible(timer)=NaN; 
Visible_Time(timer)=0;
Latitude_visible_Range(timer)=0;
Longitude_visible_Range(timer)=0;
end 
end
 
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plotting Azimuth and Elevation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure (3)
grid on
plot(Time,Azimuth_new);
hold on
grid off
plot(Time,Elevation,'k');
hold on
legend('Azimuth','Elevation');
xlabel('TIME IN SECONDS-->');
ylabel('AZIMUTH AND ELEVATION-->');
title('AZIMUTH AND ELEVATION');
figure (5)
grid on
 
plot (Time,Distance_observer_satellite);
title('DISTANCE OF OBSERVER FROM SATELITE');
xlabel('TIME IN SECONDS-->');
ylabel('DISTANCE IN METERS-->');
grid on
hold off
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plotting Distance for visible ranges
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
figure(6);
plot(Visible_Time,Distance_observer_satellite_visible,'.');
xlabel('TIME IN SECONDS-->');
ylabel('DISTANCE IN METERS-->');
title('DISTANCE IN VISIBLE RANGES');
hold on;
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PLOTTING LATITUDE AND LONGITUDE FOR VISIBLE RANGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(10)
ax=worldmap([-89 89],[-179 179]); 
load coast 
land = shaperead('landareas', 'UseGeoCoords', true); 
geoshow(ax, land, 'FaceColor', [0.5 0.7 0.5]) 
geoshow(lat, long) ;
hold on;
 
plotm(Latitude_visible_Range,Longitude_visible_Range,'.r');
hold on
plotm(53,8.8,'ok','MarkerFaceColor','k');
 
 
 
 
 
 
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FOR ONE EXPLERARY PASS OF SATELLITE%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
timer=0;
 
for t=165:195             %%%%pre- defined
 timer=timer+1;
 Distance_one_pass(timer)=Distance_observer_satellite(t);
 Elevetion_one_pass(timer)=Elevation(t);
 Azimuth_one_pass(timer)=Azimuth(t);
 Time_2(timer)=t;
 Latitude_visible_onepass(timer)=Latitude(t);
 Longitude_visible_onepass(timer)=Longitude(t);
end
 
 
figure (7)
hold on
plot(Time_2,Distance_one_pass);
xlabel('Time in seconds * 50');
ylabel('Distance in meters');
title('Distance from observer for one pass');
 
figure (8)
 
hold on
plot(Time_2, Elevetion_one_pass,'k');
hold on
plot(Time_2, Azimuth_one_pass,'r');
legend('Elevation','Azimuth');
xlabel('Time in seconds *50');
ylabel('Elevation and Azimuth');
title('Azimuth and elevation for one pass');
 
figure(9);
 
ax=worldmap([-89 89],[-179 179]); 
load coast 
land = shaperead('landareas', 'UseGeoCoords', true); 
geoshow(ax, land, 'FaceColor', [0.5 0.7 0.5]) 
geoshow(lat, long) ;
 
hold on
plotm(Latitude_visible_onepass,Longitude_visible_onepass);
hold on
plotm(53,8.8,'ok','MarkerFaceColor','k');


