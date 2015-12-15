clc
clear
fprintf('Enter a function for consideration')
fprintf (['    1-->y = 2*exp(-0.4*(x-2)^2) + 5/(x+10) + 0.1*x -0.2' ...
            '\n  2-->y= 3^i - 2^i + exp(-5*i) + exp (-20 * (i-.5)^2)' , ...
            ' \n 3-->y = 4.26 * (exp(-i)-4 * exp (-2*i) +3 * exp (-3 *i))'...
            '\n 4--> y = cos(x)'...
            '\n 5-->y = cos(x) * sin (x)'...
            '\n 6--> y = sqrt(1-(abs(x)-1)^2), acos((1-abs(x))-pi)'...
            '\n 7 --> y =x*x']);
%option = input ('\n>>');
option = 1;
%[Start_point, End_point ] = choose_location (option);
Start_point = -3;
End_point = 6;

knotsPerAxis = 12;
totalKnots = knotsPerAxis^2;
knotsX = linspace(Start_point, End_point, knotsPerAxis);
knotsY = linspace(Start_point, End_point, knotsPerAxis);

nSensors = 200;
noise = 0.1;
% Start_point =-5;
% End_point = 8;
knotspan=1;%knot_calculation (nSensors,Start_point,End_point); %Automatic Claculation of Knot Span --> Rupert Extimation min(n/4,40)
knots = Start_point:1:End_point;
xMin = knots(1);
xMax =  knots(end);
xGrid = 1;
nKnots = length(knots);
xVec= xMin:1/xGrid:xMax;
xLen = length(xVec);
yVec = NaN(xLen,1);
add_spline = 0;
add_derv=0;
%lambda=.005;
lambda=1;
%lambda=[.1];
sum_Error= 0;
Grid_opt =.01;
RMS = 0;
firstKnot=knots(1);
lastKnot =knots(end);


%-------------------------------


%-------------------------------
[X,Y]=meshgrid(xVec,yVec);
Zvec= NaN (length(X),length(Y));

[Xvec,Yvec] = meshgrid(xVec ,yVec);
Zvec = NaN(length(Xvec),length(Yvec));
for i = 1:length(Xvec)
    for j = 1:length (Yvec)
        x =Xvec(i,j);
         y = Yvec(i,j);
        Zvec(i,j) = dummyCurve ( x ,1) *dummyCurve (y,1);
    end
end
%figure (3);
%plot3(Xvec,Yvec,Zvec);
 
xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = sort(xSensors);
ySensors = NaN(nSensors,1);
ySensors= xMin + (xMax-xMin)*rand(nSensors,1);


%taking the matrix of sensors

zSensors = NaN(nSensors,1);
for i = 1:nSensors
zSensors(i)= dummyCurve(xSensors(i),1) * dummyCurve(ySensors(i),1 )+noise*randn();
end
hold on
plot3(xSensors,ySensors, zSensors,'y*');
surf (Xvec,Yvec,Zvec);
hold off


p =0;
for  i = 1:nKnots
    for j= 1:nKnots
       p=p+1;
        for q= 1:nSensors
            xs = xSensors (q);
            ys = ySensors(q);  
            %%value(p,q) = bSpline3(xs-knots(j)) * bSpline3(ys-knots(i));
            [xvalue,xderv]=quadruple_reccurence_start_modified(xs,firstKnot,knotspan);
            [yvalue,yderv] = quadruple_reccurence_start_modified(ys,firstKnot,knotspan);
            value(p,q)=xvalue*yvalue;
            derv (p,q)=xderv*yderv;
            %---------------------------------
            [xvalue,xderv]=triple_reccurence_start_modified(xs,firstKnot,knotspan);
            [yvalue,yderv] = triple_reccurence_start_modified(ys,firstKnot,knotspan);
            value(p,q)=xvalue*yvalue;
            derv (p,q)=xderv*yderv;
            %---------------------------------
            [xvalue,xderv]=Double_reccurence_start_modified(xs,firstKnot,knotspan);
            [yvalue,yderv] = Double_reccurence_start_modified(ys,firstKnot,knotspan);
            value(p,q)=xvalue*yvalue;
            derv (p,q)=xderv*yderv;
            %---------------------------------
                s=0;
                for k=1:nKnots -4
                 for l = 1
                     s=s+1;
                    [xvalue,xderv]=Basis_Spline_modified(xs,knots(k),knotspan);
                    [yvalue,yderv] =Basis_Spline_modified(ys,knots(l),knotspan);
                    value(4+s+p,q)=xvalue*yvalue;
                    derv (4+s+p,q)=xderv*yderv;
                    %[value(3+k,q)]
                 end
             end
            %---------------------------------
            [xvalue,xderv]=Double_reccurence_end_modified(xs,lastKnot,knotspan);
            [yvalue,yderv] =Double_reccurence_end_modified(xs,lastKnot,knotspan);
            value(nKnots+p,q)=xvalue*yvalue;
            derv (nKnots+p,q)=xderv*yderv;
            %---------------------------------
            [xvalue,xderv]=triple_reccurence_end_modified(xs,lastKnot,knotspan);
            [yvalue,yderv] =triple_reccurence_end_modified(ys,lastKnot,knotspan);
            value(nKnots+1+p,q)=xvalue*yvalue;
            derv (nKnots+1+p,q)=xderv*yderv;
            %---------------------------------
            [xvalue,xderv]=quadruple_reccurence_end_modified(xs,lastKnot,knotspan);
            [yvalue,yderv] =quadruple_reccurence_end_modified(ys,lastKnot,knotspan);
            value(nKnots+2+p,q)=xvalue*yvalue;
            derv (nKnots+2+p,q)=xderv*yderv;

        end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    p=p+1;
    end
end
surf(value)
weights = value'\zSensors;

surf(value)


%----------------------------------------------
%Plotting Smoothing Spline 
%===================
%------------------------------------------------

M_Derivatives =NaN(size(derv,1)-1,size(derv,1)+2);
M_splines = zeros (size(derv,1)-1,size(derv,1)+2);
vector = Start_point+knotspan/2:knotspan:End_point;
vector_length =length(vector);

for  i = 1:nKnots
    for j= 1:nKnots
        p=p+1;
        for q= 1:nSensors
            xs = xSensors (q);
            ys = ySensors(q);  
            %%value(p,q) = bSpline3(xs-knots(j)) * bSpline3(ys-knots(i));
            [xvalue,xderv]=quadruple_reccurence_start_modified(xs,firstKnot,knotspan);
            [yvalue,yderv] = quadruple_reccurence_start_modified(ys,firstKnot,knotspan);
            M_splines(1,q)=xvalue*yvalue;
            M_Derivatives (1,q)=xderv*yderv;
            %---------------------------------
            [xvalue,xderv]=triple_reccurence_start_modified(xs,firstKnot,knotspan);
            [yvalue,yderv] = triple_reccurence_start_modified(ys,firstKnot,knotspan);
            M_splines(2,q)=xvalue*yvalue;
            M_Derivatives (2,q)=xderv*yderv;
            %---------------------------------
            [xvalue,xderv]=Double_reccurence_start_modified(xs,firstKnot,knotspan);
            [yvalue,yderv] = Double_reccurence_start_modified(ys,firstKnot,knotspan);
            M_splines(3,q)=xvalue*yvalue;
            M_Derivatives (3,q)=xderv*yderv;
            %---------------------------------
                s=0;
                for k=1:nKnots -4
                 for l = 1
                     s=s+1;
                    [xvalue,xderv]=Basis_Spline_modified(xs,knots(k),knotspan);
                    [yvalue,yderv] =Basis_Spline_modified(ys,knots(l),knotspan);
                    M_splines(3+s,q)=xvalue*yvalue;
                    M_Derivatives (3+s,q)=xderv*yderv;
                    %[value(3+k,q)]
                 end
             end
            %---------------------------------
            [xvalue,xderv]=Double_reccurence_end_modified(xs,lastKnot,knotspan);
            [yvalue,yderv] =Double_reccurence_end_modified(xs,lastKnot,knotspan);
            M_splines(nKnots,q)=xvalue*yvalue;
            M_Derivatives (nKnots,q)=xderv*yderv;
            %---------------------------------
            [xvalue,xderv]=triple_reccurence_end_modified(xs,lastKnot,knotspan);
            [yvalue,yderv] =triple_reccurence_end_modified(ys,lastKnot,knotspan);
            M_splines(nKnots+1,q)=xvalue*yvalue;
            M_Derivatives (nKnots+1,q)=xderv*yderv;
            %---------------------------------
            [xvalue,xderv]=quadruple_reccurence_end_modified(xs,lastKnot,knotspan);
            [yvalue,yderv] =quadruple_reccurence_end_modified(ys,lastKnot,knotspan);
            M_splines(nKnots+2,q)=xvalue*yvalue;
            M_Derivatives (nKnots+2,q)=xderv*yderv;
            
        end
    end
end

% opt =[value,M_Derivatives*lambda];
% ySensors_opt =[zSensors;zeros(size(M_Derivatives',1),1) ];
% weights_opt = opt'\ySensors_opt;   




% for i =1:nKnots
%     for j =1:nKnots
%         p=p+1;
%         q=0;
%         for m=1:length(xVec)
%             for n = 1:length(yVec)
%                q=q+1;
%                xs = Xvec(m,n);
%                ys= Yvec(m,n);
%                s(p,q)= bSpline3(xs -knots(i))*bSpline3(ys -knots(j))*weights(p);
%             end
%         end
%     end
% end
% figure (2)
% surf(s);

% p =0;
% for m = 1:nKnots
%     for k= 1:xLen
%         for l =1:xLen
%         p=p+1;
%         q=0;
%         z=0;
%         for  i = 1:nKnots
%             for j= 1:nKnots
%                 q=q+1;
%                 xs = Xvec(k,l);
%                 ys = Yvec(k,l);
%                 z =z+bSpline3(xs-knots(j)) * bSpline3(ys-knots(i));
%             end
%         end
%         spline(k,l)=z*weights(m);
%     end
% end
% end
% figure (232)
% surf (spline)

% 
% p=0;
% for i = 1:nKnots
%     for j = 1:nKnots
%         p=p+1;
%         q=0;
%          for m= 1: xLen
%              for n = 1:xLen
%                     xs=Xvec(m,n);
%                     ys=Yvec(m,n);
%                     q=q+1;
%                      spline(p,q) = bSpline3(xs- knots(i))*bSpline3(ys-knots(j))*weights(p);
%              end
%         end
%     end
% end
% surf(spline)
% 
% for i = 1:size(spline,2)
%     ff(i)=sum(spline(:,i));
% end






% q=0;
% 
% for xi=1:length(Xvec)
%     for yi=1:length(Yvec)
%         x = Xvec(xi,yi);
%         y = Yvec(xi,yi);
%         z=0;
%         for xOffset = 1:3
%             for yOffset = 1:3
%                 z =z+ bSpline3(x+knots(xOffset))*bSpline3(y+knots(yOffset)) ;%* weights(k);
%             end
%         end
%         zz(xi,yi)=z;
%     end
% end
% 
% figure (33)
% surf (zz)
% 

