clc
clear
nSensors = 140;
noise = 0.1;
knots = -5:8;
xMin = -5;
xMax =  8;
xGrid = 500;
xVec= xMin:1/xGrid:xMax;
xLen = length(xVec);
yVec = NaN(xLen,1);
add_spline = 0;
add_derv=0;
lamda=0.1;

for i=1:xLen
    yVec(i) = dummyCurve(xVec(i));
end

figure(1)

    plot(xVec, yVec,'g','LineWidth',2);
hold on;
load DataRandom1000;  %randomXpositions  randomYpositions  randomZ   

%xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = xMin + (xMax-xMin)* (0.5 *randomXpositions(5:nSensors+4)+0.5);  % ingore first 4 samples in random list, due to fixed postions
xSensors = sort(xSensors);
ySensors = NaN(nSensors,1);

for i=1:nSensors
    %ySensors(i)=dummyCurve(xSensors(i)) + noise*randn();
    ySensors(i)=dummyCurve(xSensors(i)) + noise*randomZ(i);
end

plot(xSensors, ySensors, 'rd');

% creating table with influence of knots
nKnots = length(knots);
BS = NaN(nKnots+2,nSensors);

firstKnot=knots(1);
lastKnot =knots(end);


for s=1:nSensors
    xs = xSensors(s);
    BS(1,s) =quadruple_reccurence_start(xs,firstKnot);
    BS(2,s)=triple_reccurence_start(xs,firstKnot);
    BS(3,s)=Double_reccurence_start(xs,firstKnot);        
    for k=1:nKnots-4;
        BS(3+k,s)=Basic_Spline_start(xs,knots(k));
    end
     BS(nKnots,s)=Double_reccurence_end(xs,lastKnot);
    BS(nKnots+1,s) =triple_reccurence_end(xs,lastKnot);
    BS(nKnots+2,s) =quadruple_reccurence_end(xs,lastKnot);
    
end


weights = BS'\ySensors;


for i = 1:xLen
    [aaval,aaderv]= quadruple_reccurence_start(xVec(i),firstKnot);
    a_spline(i)=aaval*weights(1);               %spline values
     a_derv(i)=aaderv*weights(1)*lamda;              %third derivative
end
for i = 1:xLen
    [bbval,bbderv]=triple_reccurence_start(xVec(i),firstKnot);
    b_spline(i)=bbval*weights(2);
    b_derv(i)=bbderv*weights(2)*lamda;
end
 for i = 1:xLen
     [ccval,ccderv]= Double_reccurence_start(xVec(i),firstKnot);
     c_spline(i)=ccval*weights(3);
     c_derv(i)=ccderv*weights(3)*lamda;
 end
p=4;
 
for j= 1:nKnots-4
         for i =1:xLen
                  [ddval,ddderv] =Basic_Spline_start(xVec(i),knots(j));
                 d_spline(j,i)=ddval;
                 d_derv(j,i)=ddderv;
         end
        hold on
        if p<nKnots+2
             mul_val =   d_spline(j,:)*weights (p);       % multiplying with the weights
            mul_derv = d_derv(j,:)*weights(p)*lamda;
            plot (xVec,mul_val);                          %plotting splines
            %plot ( xVec, mul_derv);                      %plotting the third derivative
            p=p+1;
        end
        add_spline = add_spline + mul_val;
        add_derv= add_derv+mul_derv;
      hold on
 end

for i = 1:xLen
    [ffval,ffderv]=Double_reccurence_end(xVec(i),lastKnot);
    f_spline(i)=ffval*weights(14);
    f_derv(i)=ffderv*weights(14)*lamda;
end 

for i = 1:xLen
    [ggval,ggderv]=triple_reccurence_end(xVec(i),lastKnot);
    g_spline(i)=ggval*weights(15);
    g_derv(i)=ggderv*weights(15)*lamda;
end 

for i = 1:xLen
    [hhval,hhderv]=quadruple_reccurence_end(xVec(i),lastKnot);
    h_spline(i)=hhval*weights(16);   
    h_derv(i)=hhderv*weights(16)*lamda; 
end
%plotiing the splines
 plot (xVec,a_spline,'b',xVec,b_spline,'b',xVec,c_spline,'b',xVec,f_spline,'b',xVec,g_spline,'b',xVec,h_spline,'b')%Plotting Splines
 hold on
add_spline = a_spline+b_spline+c_spline+f_spline+g_spline+h_spline+add_spline;
plot (xVec,add_spline,'k');
hold on
legend('Clean Data','Noisy Measurements','Spines','Fit');
%plotting the derivatives
 

 add_derv = a_derv+b_derv+c_derv+f_derv+g_derv+h_derv+add_derv;
 %plot (xVec,a_derv,'r',xVec,b_derv,'r',xVec,c_derv,'r',xVec,f_derv,'b',xVec,g_derv,'g',xVec,h_derv,'g');
 plot (xVec,add_derv,'r');
axis([-5.5 8.5 -1 3]);
hold off




