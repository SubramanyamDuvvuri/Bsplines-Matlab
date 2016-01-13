<<<<<<< HEAD
clear
clc
xyMin = -1;
xyMax = 1;
nSensors =200;
knotsPerAxis = 11;
splinesPerAxis = knotsPerAxis+2;
knotspan = (xyMax-xyMin)/(knotsPerAxis-1);

splineNumber = 3;

figure(1);
xVec = xyMin:0.02:xyMax;
xLen = length(xVec);
zVec = NaN(xLen,1);
sumZ = zeros(xLen,1);
colors = 'rgbmcykkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk';
for splineNumberHorizontal = 1:splinesPerAxis
    for i=1:xLen
        x = xVec(i);
        horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
        zVec(i) = horizontal;
    end
    plot(xVec, zVec, colors(splineNumberHorizontal));
    hold on
    sumZ = sumZ + zVec;
end
plot(xVec, sumZ, 'b:');
hold off;
axis([xyMin-0.1 xyMax+0.1 -0.1 1.1]);
stop


knots =linspace(xyMin,xyMax,knotsPerAxis);
cleanLen= 51;
xClean= linspace(xyMin,xyMax,cleanLen);
yClean= linspace(xyMin,xyMax,cleanLen);
yClean=yClean';
knots = linspace(xyMin,xyMax, knotsPerAxis);
zzClean = NaN(cleanLen, cleanLen);
FunctionType =1;
[xx,yy] = meshgrid(xClean, yClean);
z=0;

%Basic Spline plot
for xi=1:length(xClean)
    for yi=1:length(yClean)
        x = xClean(xi);
        y = yClean(yi);
        z=0;
       for i= 1:knotsPerAxis
            for k= 1:knotsPerAxis
               horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,i );
                vertical = calcSpline1D(y, knotsPerAxis, xyMin, xyMax, k);
                splineproduct(i,k) =horizontal *vertical;%*weights(i,k) ;
                z = z+ splineproduct(i,k);
            end
        end
        zz(xi,yi)=z;
    end
end
figure (7)
%plot3(xSensors,ySensors, zSensors,'m*');
hold on
surf(xClean,yClean,zz)

for i=1:cleanLen
    for k=1:cleanLen
        zzClean(i,k)=getHiddenSpatialFunction(xClean(i),yClean(k), FunctionType);
    end
end
%figure (1)
%surf(xx,yy,zzClean','EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.6);
hold on
load DataSensors2D;
for i=1:nSensors
    x = xSensor(i);   
    y = ySensor(i);
    z = zMess(i);
    c = zClean(i);
    plot3([x x], [y y], [c z],'k');
    plot3(x,y, c,'ro'); 
    hold on;
   % plot3(x,y,z,'k*'); % plot of clean data with sensors
end
%calculating weights
p=0;
for  i = 1:knotsPerAxis
    for j= 1:knotsPerAxis
         p=p+1;
        for q= 1:nSensors
            xs = xSensor (q);
            ys =ySensor(q);
             horizontal = calcSpline1D(xs, knotsPerAxis, xyMin, xyMax,i );
            vertical = calcSpline1D(ys, knotsPerAxis, xyMin, xyMax, j);
           BS(p,q) =horizontal *vertical;%*weights(i,k) ;
        end
    end
end
weights = BS'\zMess;
%converting weight vector into matrix
count =0;
for i =1: knotsPerAxis
    for j =1:knotsPerAxis
        count=count+1;
        weights_matrix(i,j) = weights (count);
    end
end
%Plotting the splines
for xi=1:length(xClean)
    for yi=1:length(yClean)
        x = xClean(xi);
        y = yClean(yi);
        z=0;
       for i= 1:knotsPerAxis
            for k= 1:knotsPerAxis
               [horizontalval,horizontalderv] = calcSpline1D(x, knotsPerAxis, xyMin, xyMax,i );
               [ verticalval,verticalderv] = calcSpline1D(y, knotsPerAxis, xyMin, xyMax, k);
                splineproductval(i,k) =horizontalval *verticalval*weights_matrix(i,k) ;
                splineprductderv(i,k) = horizontalderv*verticalderv*weights_matrix(i,k);
            end
        end
        zz(xi,yi)=z;
    end
end

%Calculating smoothing spline

add_derv_opt=0;
M_Derivatives =NaN(knotsPerAxis-1,knotsPerAxis+2);
M_splines = zeros (knotsPerAxis-1,knotsPerAxis+2);
%vector=xMin:Grid_opt:xMax;
vector = xyMin+knotspan/2:knotspan:xyMax; %########### less extra equations #####
vector_length =length(vector);
[M_splines ,M_Derivatives] = calculate_spline(knotspan,knots,vector_length, vector);
opt = [BS_value,M_Derivatives*lambda];
zSensors_opt = [zSensors ;zeros(size(M_Derivatives',1),1) ];
weights_opt = opt'\zSensors_opt;                   %calculating the optimised weights













=======
clear
clc
xyMin = -1;
xyMax = 1;
nSensors =200;
knotsPerAxis = 11;
splinesPerAxis = knotsPerAxis+2;
knotspan = (xyMax-xyMin)/(knotsPerAxis-1);

splineNumber = 3;

figure(1);
xVec = xyMin:0.02:xyMax;
xLen = length(xVec);
zVec = NaN(xLen,1);
sumZ = zeros(xLen,1);
colors = 'rgbmcykkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk';
for splineNumberHorizontal = 1:splinesPerAxis
    for i=1:xLen
        x = xVec(i);
        horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
        zVec(i) = horizontal;
    end
    plot(xVec, zVec, colors(splineNumberHorizontal));
    hold on
    sumZ = sumZ + zVec;
end
plot(xVec, sumZ, 'b:');
hold off;
axis([xyMin-0.1 xyMax+0.1 -0.1 1.1]);
stop


knots =linspace(xyMin,xyMax,knotsPerAxis);
cleanLen= 51;
xClean= linspace(xyMin,xyMax,cleanLen);
yClean= linspace(xyMin,xyMax,cleanLen);
yClean=yClean';
knots = linspace(xyMin,xyMax, knotsPerAxis);
zzClean = NaN(cleanLen, cleanLen);
FunctionType =1;
[xx,yy] = meshgrid(xClean, yClean);
z=0;

%Basic Spline plot
for xi=1:length(xClean)
    for yi=1:length(yClean)
        x = xClean(xi);
        y = yClean(yi);
        z=0;
       for i= 1:knotsPerAxis
            for k= 1:knotsPerAxis
               horizontal = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,i );
                vertical = calcSpline1D(y, knotsPerAxis, xyMin, xyMax, k);
                splineproduct(i,k) =horizontal *vertical;%*weights(i,k) ;
                z = z+ splineproduct(i,k);
            end
        end
        zz(xi,yi)=z;
    end
end
figure (7)
%plot3(xSensors,ySensors, zSensors,'m*');
hold on
surf(xClean,yClean,zz)

for i=1:cleanLen
    for k=1:cleanLen
        zzClean(i,k)=getHiddenSpatialFunction(xClean(i),yClean(k), FunctionType);
    end
end
%figure (1)
%surf(xx,yy,zzClean','EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.6);
hold on
load DataSensors2D;
for i=1:nSensors
    x = xSensor(i);   
    y = ySensor(i);
    z = zMess(i);
    c = zClean(i);
    plot3([x x], [y y], [c z],'k');
    plot3(x,y, c,'ro'); 
    hold on;
   % plot3(x,y,z,'k*'); % plot of clean data with sensors
end
%calculating weights
p=0;
for  i = 1:knotsPerAxis
    for j= 1:knotsPerAxis
         p=p+1;
        for q= 1:nSensors
            xs = xSensor (q);
            ys =ySensor(q);
             horizontal = calcSpline1D(xs, knotsPerAxis, xyMin, xyMax,i );
            vertical = calcSpline1D(ys, knotsPerAxis, xyMin, xyMax, j);
           BS(p,q) =horizontal *vertical;%*weights(i,k) ;
        end
    end
end
weights = BS'\zMess;
%converting weight vector into matrix
count =0;
for i =1: knotsPerAxis
    for j =1:knotsPerAxis
        count=count+1;
        weights_matrix(i,j) = weights (count);
    end
end
%Plotting the splines
for xi=1:length(xClean)
    for yi=1:length(yClean)
        x = xClean(xi);
        y = yClean(yi);
        z=0;
       for i= 1:knotsPerAxis
            for k= 1:knotsPerAxis
               [horizontalval,horizontalderv] = calcSpline1D(x, knotsPerAxis, xyMin, xyMax,i );
               [ verticalval,verticalderv] = calcSpline1D(y, knotsPerAxis, xyMin, xyMax, k);
                splineproductval(i,k) =horizontalval *verticalval*weights_matrix(i,k) ;
                splineprductderv(i,k) = horizontalderv*verticalderv*weights_matrix(i,k);
            end
        end
        zz(xi,yi)=z;
    end
end

%Calculating smoothing spline

add_derv_opt=0;
M_Derivatives =NaN(knotsPerAxis-1,knotsPerAxis+2);
M_splines = zeros (knotsPerAxis-1,knotsPerAxis+2);
%vector=xMin:Grid_opt:xMax;
vector = xyMin+knotspan/2:knotspan:xyMax; %########### less extra equations #####
vector_length =length(vector);
[M_splines ,M_Derivatives] = calculate_spline(knotspan,knots,vector_length, vector);
opt = [BS_value,M_Derivatives*lambda];
zSensors_opt = [zSensors ;zeros(size(M_Derivatives',1),1) ];
weights_opt = opt'\zSensors_opt;                   %calculating the optimised weights













>>>>>>> 410345bf7f4fd21d271ae561c5b3c00333b6358e
