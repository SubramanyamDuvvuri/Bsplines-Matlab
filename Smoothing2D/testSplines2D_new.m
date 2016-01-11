clear
clc
xyMin = -1;
xyMax = 1;
nSensors =500;
noiseLevel = 0.06;

knotsPerAxis = 7;
splinesPerAxis = knotsPerAxis+2;
knotspan = (xyMax-xyMin)/(knotsPerAxis-1);
cleanLen=30;
%splineNumber = 3;
plotSingleSplines = 0;

xVec = linspace(xyMin,xyMax,cleanLen);
yVec = linspace(xyMin,xyMax,cleanLen);
xLen = length(xVec);
yLen = length(yVec);
zVec = NaN(xLen,yLen);
sumZ = zeros(xLen,yLen);

yVec=yVec';
knots = linspace(xyMin,xyMax, knotsPerAxis);
zzClean = NaN(cleanLen, cleanLen);
FunctionType =1;
doEquispaced = 0;
[xx,yy] = meshgrid(xVec, yVec);
z=0;
for i=1:cleanLen
    for k=1:cleanLen
        zzClean(i,k)=getHiddenSpatialFunction(xVec(i),yVec(k), FunctionType);
    end
end
figure (1)
surf(xx,yy,zzClean','EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.5);
hold on
%load DataSensors2D;
[xSensor, ySensor, zClean, zMess, CleanRef] = generateTestData2D(nSensors, noiseLevel, FunctionType, doEquispaced);

for i=1:nSensors
    x = xSensor(i);
    y = ySensor(i);
    z = zMess(i);
    c = zClean(i);
    plot3([x x], [y y], [c z],'k');
    plot3(x,y, c,'ro');
    hold on;
    plot3(x,y,z,'k*'); % plot of clean data with sensors
end

%calculating Basis of B-SPlines
%matrix  BS represents Basis
%The rows of the matrix represent spline number and the colomns represent sensors

p=0;
BS = NaN(splinesPerAxis^2,nSensors);
for splineNumberHorizontal= 1:splinesPerAxis
    for splineNumberVertical= 1:splinesPerAxis
        p=p+1;
        for q= 1:nSensors
            x = xSensor (q);
            y = ySensor (q);
            [horizontal,dervH] = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal);
            [vertical,dervV] = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumberVertical);
            BS(p,q) =horizontal*vertical ;%*weights(i,k) ;
            bsD(p,q) = dervV*dervV;
        end
    end
end

weights = BS'\zMess; % calculating the weights usi
%converting weight vector into matrix
weights_matrix = NaN(splinesPerAxis, splinesPerAxis);
count =0;
for i =1: splinesPerAxis
    for j =1:splinesPerAxis
        count=count+1;
        weights_matrix(j,i) = weights(count);
    end
end
%Plotting the regression splines using the calculated weights
sumZZ = zeros(xLen,yLen);
sumDerv = zeros(xLen,yLen);
for splineNumberHorizontal = 1:splinesPerAxis
    for splineNumbervertical = 1:splinesPerAxis
        for i=1:xLen
            x = xVec(i);
            [horizontal,HorDerv] = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
            for j=1:yLen
                y = yVec(j);
                [vertical,VerDerv] = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumbervertical );
                zVec(i,j) = horizontal*vertical *weights_matrix(splineNumberHorizontal,splineNumbervertical)  ;
                zVevDerv(i,j)=HorDerv*VerDerv*weights_matrix(splineNumberHorizontal,splineNumbervertical);
                
            end
        end
        sumDerv=sumDerv+zVevDerv;
        sumZZ = sumZZ + zVec;
    end
end


figure(2)
for i=1:nSensors
    x = xSensor(i);
    y = ySensor(i);
    z = zMess(i);
    c = zClean(i);
    plot3([x x], [y y], [c z],'k');
    plot3(x,y, c,'ro');
    hold on;
    plot3(x,y,z,'k*'); % plot of clean data with sensors
end
surf(xx,yy, sumZZ,'EdgeColor',[0.7 0.7 0.7],'FaceAlpha',0.5);
axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -1.1 1.1]);
hold off;

%----------------------------
%Calculating smoothing spline
%----------------------------

vector = xyMin+knotspan/2:knotspan:xyMax;
vector_length =length(vector);
p=0;
q=0;
Derv = NaN(splinesPerAxis^2,nSensors);
for splineNumberHorizontal= 1:splinesPerAxis
    for splineNumberVertical= 1:splinesPerAxis
        p=p+1;
        q=0;
        for m= 1:vector_length
            for n = 1:vector_length
                q=q+1;
                x = vector (m);
                y = vector (n);
                [horizontal,HorDerv] = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal);
                [vertical,VerDerv] = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumberVertical);
                BS_Val(p,q) =horizontal*vertical ;
                BS_Derv(p,q)= HorDerv*HorDerv;
            end
        end
    end
end


lambda = 0.00000009;
opt = [BS,BS_Derv*lambda];
zMess_opt = [zMess ;zeros(size(BS_Derv',1),1) ];
weights_opt = opt'\zMess_opt;

weights_opt_matrix = NaN(splinesPerAxis, splinesPerAxis);
count =0;
for i =1: splinesPerAxis
    for j =1:splinesPerAxis
        count=count+1;
        weights_opt_matrix(j,i) = weights_opt(count);
    end
end

sumZZ_opt = zeros(xLen,yLen);
sumDerv_opt = zeros(xLen,yLen);
for splineNumberHorizontal = 1:splinesPerAxis
    for splineNumbervertical = 1:splinesPerAxis
        for i=1:xLen
            x = xVec(i);
            [horizontal,HorDerv] = calcSpline1D_Single(x, knotsPerAxis, xyMin, xyMax,splineNumberHorizontal );
            for j=1:yLen
                y = yVec(j);
                [vertical,VerDerv] = calcSpline1D_Single(y, knotsPerAxis, xyMin, xyMax,splineNumbervertical );
                zVec(i,j) = horizontal*vertical *weights_opt_matrix(splineNumberHorizontal,splineNumbervertical)  ;
                zVevDerv(i,j)=HorDerv*VerDerv;%*weights_opt_matrix(splineNumberHorizontal,splineNumbervertical);
                
            end
        end
        sumZZ_opt = sumZZ_opt + zVec;
        sumDerv=sumDerv+zVevDerv;
        
    end
end
figure (3)
surf (xx,yy,sumZZ_opt);
%axis([xyMin-0.1 xyMax+0.1 xyMin-0.1 xyMax+0.1 -0.1 1.1]);










