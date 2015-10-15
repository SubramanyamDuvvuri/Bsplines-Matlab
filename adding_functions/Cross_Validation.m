clc
clear
nSensors = 100;
noise = 0.1;
Start_point =-6;
End_point = 7;
knotspan=knot_calculation (nSensors,Start_point,End_point); %Automatic Claculation of Knot Span --> Rupert Extimation min(n/4,40)
knots = Start_point:knotspan:End_point;
xMin = knots(1);
xMax =  knots(end);
xGrid = 10;
nknots = length(knots);
xVec= xMin:1/xGrid:xMax;
xLen = length(xVec);
yVec = NaN(xLen,1);
add_spline = 0;
add_derv=0;
lamda=[.001,1];
%lamda=[.1];
sum_Error= 0;
Grid_opt =.1;
RMS = 0;


for i=1:xLen
    yVec(i) = dummyCurve(xVec(i));
    %yVec (i) = example_curve (xVec(i));
    %yVec (i) = example_curve_2 (xVec(i)); %knot value should be 0:1    
end

figure(8)          

plot(xVec, yVec,'g--','LineWidth',3);
legend ('nknots');
hold on;
load DataRandom1000;  %randomXpositions  randomYpositions  randomZ   

%xSensors = xMin + (xMax-xMin)*rand(nSensors,1);
xSensors = xMin + (xMax-xMin)* (0.5 *randomXpositions(5:nSensors+4)+0.5);  % ignore first 4 samples in random list, due to fixed postions
xSensors = sort(xSensors);
ySensors = NaN(nSensors,1);




for i=1:nSensors
      ySensors(i)=dummyCurve(xSensors(i)) + noise*randomZ(i);
      %ySensors(i)=example_curve(xSensors(i)) + noise*randn();
     %ySensors(i)=example_curve(xSensors(i)) + noise*randn();
end
%plot(xSensors, ySensors, 'mo','MarkerFaceColor',[.10 1 .63]);
%For loop to calculate the cross validation


 leftout_point =0; % put 0 to include all the values
nSensors = nSensors -1;
for lamda_counter = 1:length(lamda)
    xleftout = 0;
    yleftout = 0;
    leftout_point = 0;
    sum_Error= 0;
for i = 1 : nSensors+1
     add_spline_opt = 0;
     add_spline =0;
    leftout_point =leftout_point +1;% comment this incase only one point  or no point needs to be left out
    if isequal (leftout_point,0)
         xleftout = [xSensors(1:nSensors+1) ];
        yleftout =  [ySensors(1:nSensors+1) ];
        nSensors = nSensors +1;
        break;
    end
    if isequal(leftout_point,1)
        xleftout = [xSensors(leftout_point +1:nSensors+1) ];
        yleftout =  [ySensors(leftout_point +1:nSensors+1) ];
    elseif isequal(leftout_point ,nSensors+1)
        xleftout = [xSensors(1:nSensors) ];
        yleftout =  [ySensors(1:nSensors) ];
    else
        xleftout = [xSensors(1:leftout_point-1) ; xSensors(leftout_point+1:nSensors+1)];
        yleftout =  [ySensors(1:leftout_point-1) ; ySensors(leftout_point+1:nSensors+1)];
    end


 
%nSensors = nSensors -1;
%plot (xleftout,yleftout, 'mo','MarkerFaceColor',[.10 1 .63]);
% creating table with influence of knots
BS = NaN(nknots+2,nSensors);
firstKnot=knots(1);
lastKnot =knots(end);


for s=1:nSensors
    xs = xleftout(s);
    BS(1,s) =quadruple_reccurence_start_modified(xs,firstKnot,knotspan);
    BS(2,s)=triple_reccurence_start_modified(xs,firstKnot,knotspan);
    BS(3,s)=Double_reccurence_start_modified(xs,firstKnot,knotspan);        
    for k=1:nknots-4;
     BS(3+k,s)=Basis_Spline_modified(xs,knots(k),knotspan);
    end
     BS(nknots,s)=Double_reccurence_end_modified(xs,lastKnot,knotspan);
    BS(nknots+1,s) =triple_reccurence_end_modified(xs,lastKnot,knotspan);
    BS(nknots+2,s) =quadruple_reccurence_end_modified(xs,lastKnot,knotspan);
    
end

weights = BS'\yleftout;
%weights = ones (16,1);

for i = 1:xLen
    [aaval,aaderv]= quadruple_reccurence_start_modified(xVec(i),firstKnot,knotspan);
    a_spline(i)=aaval*weights(1);               %spline values
    a_derv(i)=aaderv*weights(1)*lamda(lamda_counter);              %third derivative
end

for i = 1:xLen
    [bbval,bbderv]=triple_reccurence_start_modified(xVec(i),firstKnot,knotspan);
    b_spline(i)=bbval*weights(2);
    b_derv(i)=bbderv*weights(2)*lamda(lamda_counter);
end


 for i = 1:xLen
     [ccval,ccderv]= Double_reccurence_start_modified(xVec(i),firstKnot,knotspan);
     c_spline(i)=ccval*weights(3);
     c_derv(i)=ccderv*weights(3)*lamda(lamda_counter);
 end
 
p=4;
 
for j= 1:nknots-4
         for i =1:xLen
                  [ddval,ddderv] = Basis_Spline_modified(xVec(i),knots(j),knotspan);
                 d_spline(j,i)=ddval;
                 d_derv(j,i)=ddderv;
         end
        hold on
        if p<nknots+2
             mul_val =   d_spline(j,:)*weights (p);       % multiplying with the weights
            mul_derv = d_derv(j,:)*weights(p)*lamda(lamda_counter);
            %plot (xVec,mul_val);                          %plotting splines
            %plot ( xVec,mul_derv);                      %plotting the third derivative
            p=p+1;
        end
        add_spline = add_spline + mul_val;
        add_derv= add_derv+mul_derv;
      hold on
 end

for i = 1:xLen
    [ffval,ffderv]=Double_reccurence_end_modified(xVec(i),lastKnot,knotspan);
    f_spline(i)=ffval*weights(nknots);
    f_derv(i)=ffderv*weights(nknots)*lamda(lamda_counter);
end 

for i = 1:xLen
    [ggval,ggderv]=triple_reccurence_end_modified(xVec(i),lastKnot,knotspan);
    g_spline(i)=ggval*weights(nknots+1);
    g_derv(i)=ggderv*weights(nknots+1)*lamda(lamda_counter);
end 

for i = 1:xLen
    [hhval,hhderv]=quadruple_reccurence_end_modified(xVec(i),lastKnot,knotspan);
    h_spline(i)=hhval*weights(nknots+2);   
    h_derv(i)=hhderv*weights(nknots+2)*lamda(lamda_counter); 
end
%ploting the splines
 %plot (xVec,a_spline,'b',xVec,b_spline,'b',xVec,c_spline,'b',xVec,f_spline,'b',xVec,g_spline,'b',xVec,h_spline,'b','LineWidth',1.4)%Plotting Splines
 hold on
add_spline = a_spline+b_spline+c_spline+f_spline+g_spline+h_spline+add_spline;
plot (xVec,add_spline,'k','LineWidth',1.6);
hold on
legend('Clean Data','Noisy Measurements','Spines');

%plotting the derivatives
hold off

 add_derv = a_derv+b_derv+c_derv+f_derv+g_derv+h_derv+add_derv;
 %plot (xVec,a_derv,'r',xVec,b_derv,'r',xVec,c_derv,'r',xVec,f_derv,'b',xVec,g_derv,'g',xVec,h_derv,'g');
 %plot (xVec,add_derv,'r');
text(xMin+2, 2.7,sprintf('Number of knots: %g', nknots +2));

text(xMin+2,2.5,sprintf(' First Value %g,Last value %g ',xMin, xMax));

hold off
hold on
if (leftout_point~=0)
  %plot (xSensors (leftout_point),ySensors (leftout_point), 'r+');
end
hold off
   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%PLOTTING THE SMOOTHING SPLINE%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hold on;

add_derv_opt=0;
M_Derivatives =NaN(nknots-1,nknots+2);
M_splines = zeros (nknots-1,nknots+2);
count=0; 
%%Finding M_Derivatives
for x = xMin:Grid_opt :xMax
    
    count=count+1;
    xx(count)=x;
    [aaval,aaderv]= quadruple_reccurence_start_modified(x,firstKnot,knotspan);
    M_Derivatives(count,1)=aaderv;
    
    [bbval,bbderv]= triple_reccurence_start_modified(x,firstKnot,knotspan);
    M_Derivatives(count,2)=bbderv;
    
    [ccval,ccderv]= Double_reccurence_start_modified(x,firstKnot,knotspan);
    M_Derivatives(count,3)=ccderv;
    
    for j= 1:nknots-4
        [ddval,ddderv] =Basis_Spline_modified(x,knots(j),knotspan);
         M_Derivatives(count,j+3)=ddderv;
    end  
    [ffval,ffderv]=Double_reccurence_end_modified(x,lastKnot,knotspan);
     M_Derivatives(count,nknots)=ffderv;
    
    [ggval,ggderv]=triple_reccurence_end_modified(x,lastKnot,knotspan);
     M_Derivatives(count,nknots+1)=ggderv;
    
    [hhval,hhderv]=quadruple_reccurence_end_modified(x,lastKnot,knotspan);
    M_Derivatives(count,nknots+2)=hhderv;
    
end

opt = [BS,M_Derivatives'*lamda(lamda_counter)];
ySensors_opt = [yleftout ;zeros(size(M_Derivatives,1),1) ];
weights_opt = opt'\ySensors_opt;                   %Finding the weights

%%%%%%%
%SPLINES 
%%%%%%%
count=0;
 for x = xMin:Grid_opt:xMax 
     count=count+1;
     xxVec(count)=x;
     [aaval,aaderv]= quadruple_reccurence_start_modified(x,firstKnot,knotspan);
     M_splines(count,1) = aaval*weights_opt(1);    
     [bbval,bbderv]= triple_reccurence_start_modified(x,firstKnot,knotspan);
     M_splines(count,2) = bbval*weights_opt(2);     
     [ccval,ccderv]= Double_reccurence_start_modified(x,firstKnot,knotspan);
     M_splines(count,3) = ccval*weights_opt(3);
     for j= 1:nknots-4
         [ddval,ddderv] =Basis_Spline_modified(x,knots(j),knotspan);
          M_splines(count,j+3) = ddval*weights_opt(j+3);
     end  
     [ffval,ffderv]=Double_reccurence_end_modified(x,lastKnot,knotspan);
     M_splines(count,nknots) = ffval*weights_opt(nknots);
     
       [ggval,ggderv]=triple_reccurence_end_modified(x,lastKnot,knotspan);
      M_splines(count,nknots+1) = ggval*weights_opt(nknots+1);     
     [hhval,hhderv]=quadruple_reccurence_end_modified(x,lastKnot,knotspan);
      M_splines(count,nknots+2) = hhval*weights_opt(nknots+2);     
 end  
hold off
%figure (14);
xxLen =length (xxVec);
yyVec = NaN(xxLen,1);
for i=1:xxLen
    %yyVec(i) = example_curve(xx(i));
    yyVec(i) = dummyCurve(xxVec(i));
end
%plot ( xx , yyVec, 'r--');
 %plot(xx, yyVec,'g--','LineWidth',3);
hold on
add_opt = 0;
add_spline_opt = 0;

%%%%%%%%%%%
%%%Calculating the fitting Curve
%%%%%%%%%%%%

for i = 1:nknots+2
        add_opt = add_opt + M_Derivatives ( :,i)';
        add_spline_opt = add_spline_opt + M_splines( :,i)';
end
PUC = xSensors(i);
position = find(abs (xxVec-x)<10^-4);
sum_Error = sum_Error + (ySensors(i)- add_spline_opt(position))^2;
%RMS(lamda_counter,leftout_point) = RMSE_calculate (ySensors(i) , add_spline_opt(position) );
end
RMS(lamda_counter)= sqrt(sum_Error/length(ySensors));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Using automated lamda
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pos2 = find(RMS ==min(RMS));
lamda_new=lamda(pos2);
BS = NaN(nknots+2,nSensors);
firstKnot=knots(1);
lastKnot =knots(end);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % for s=1:nSensors
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     xs = xleftout(s);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     BS(1,s) =quadruple_reccurence_start_modified(xs,firstKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     BS(2,s)=triple_reccurence_start_modified(xs,firstKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     BS(3,s)=Double_reccurence_start_modified(xs,firstKnot,knotspan);        
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     for k=1:nknots-4;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      BS(3+k,s)=Basis_Spline_modified(xs,knots(k),knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      BS(nknots,s)=Double_reccurence_end_modified(xs,lastKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     BS(nknots+1,s) =triple_reccurence_end_modified(xs,lastKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     BS(nknots+2,s) =quadruple_reccurence_end_modified(xs,lastKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % weights = BS'\yleftout;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %weights = ones (16,1);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % for i = 1:xLen
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     [aaval,aaderv]= quadruple_reccurence_start_modified(xVec(i),firstKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     a_spline(i)=aaval*weights(1);               %spline values
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     a_derv(i)=aaderv*weights(1)*lamda_new;              %third derivative
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % for i = 1:xLen
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     [bbval,bbderv]=triple_reccurence_start_modified(xVec(i),firstKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     b_spline(i)=bbval*weights(2);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     b_derv(i)=bbderv*weights(2)*lamda_new;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  for i = 1:xLen
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      [ccval,ccderv]= Double_reccurence_start_modified(xVec(i),firstKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      c_spline(i)=ccval*weights(3);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      c_derv(i)=ccderv*weights(3)*lamda_new;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % p=4;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % for j= 1:nknots-4
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %          for i =1:xLen
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                   [ddval,ddderv] = Basis_Spline_modified(xVec(i),knots(j),knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                  d_spline(j,i)=ddval;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %                  d_derv(j,i)=ddderv;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %          end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         hold on
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         if p<nknots+2
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %              mul_val =   d_spline(j,:)*weights (p);       % multiplying with the weights
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %             mul_derv = d_derv(j,:)*weights(p)*lamda_new;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %             %plot (xVec,mul_val);                          %plotting splines
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %             %plot ( xVec,mul_derv);                      %plotting the third derivative
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %             p=p+1;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         add_spline = add_spline + mul_val;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         add_derv= add_derv+mul_derv;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %       hold on
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % for i = 1:xLen
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     [ffval,ffderv]=Double_reccurence_end_modified(xVec(i),lastKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     f_spline(i)=ffval*weights(nknots);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     f_derv(i)=ffderv*weights(nknots)*lamda_new;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % end 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % for i = 1:xLen
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     [ggval,ggderv]=triple_reccurence_end_modified(xVec(i),lastKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     g_spline(i)=ggval*weights(nknots+1);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     g_derv(i)=ggderv*weights(nknots+1)*lamda_new;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % end 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % for i = 1:xLen
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     [hhval,hhderv]=quadruple_reccurence_end_modified(xVec(i),lastKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     h_spline(i)=hhval*weights(nknots+2);   
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     h_derv(i)=hhderv*weights(nknots+2)*lamda_new; 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %ploting the splines
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  %plot (xVec,a_spline,'b',xVec,b_spline,'b',xVec,c_spline,'b',xVec,f_spline,'b',xVec,g_spline,'b',xVec,h_spline,'b','LineWidth',1.4)%Plotting Splines
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  hold on
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % add_spline = a_spline+b_spline+c_spline+f_spline+g_spline+h_spline+add_spline;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % plot (xVec,add_spline,'k','LineWidth',1.6);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % hold on
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % legend('Clean Data','Noisy Measurements','Spines');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %plotting the derivatives
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % hold off
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  add_derv = a_derv+b_derv+c_derv+f_derv+g_derv+h_derv+add_derv;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  %plot (xVec,a_derv,'r',xVec,b_derv,'r',xVec,c_derv,'r',xVec,f_derv,'b',xVec,g_derv,'g',xVec,h_derv,'g');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  %plot (xVec,add_derv,'r');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % text(xMin+2, 2.7,sprintf('Number of knots: %g', nknots +2));
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % text(xMin+2,2.5,sprintf(' First Value %g,Last value %g ',xMin, xMax));
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % hold off
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % hold on
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % if (leftout_point~=0)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %   plot (xSensors (leftout_point),ySensors (leftout_point), 'r+');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % hold off
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %    
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %%%PLOTTING THE SMOOTHING SPLINE%%%%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % hold on;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % add_derv_opt=0;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % M_Derivatives =NaN(nknots-1,nknots+2);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % M_splines = zeros (nknots-1,nknots+2);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % count=0; 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %%Finding M_Derivatives
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % for x = xMin:Grid_opt :xMax
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     count=count+1;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     xx(count)=x;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     [aaval,aaderv]= quadruple_reccurence_start_modified(x,firstKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     M_Derivatives(count,1)=aaderv;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     [bbval,bbderv]= triple_reccurence_start_modified(x,firstKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     M_Derivatives(count,2)=bbderv;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     [ccval,ccderv]= Double_reccurence_start_modified(x,firstKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     M_Derivatives(count,3)=ccderv;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     for j= 1:nknots-4
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         [ddval,ddderv] =Basis_Spline_modified(x,knots(j),knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %          M_Derivatives(count,j+3)=ddderv;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     end  
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     [ffval,ffderv]=Double_reccurence_end_modified(x,lastKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      M_Derivatives(count,nknots)=ffderv;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     [ggval,ggderv]=triple_reccurence_end_modified(x,lastKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      M_Derivatives(count,nknots+1)=ggderv;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     [hhval,hhderv]=quadruple_reccurence_end_modified(x,lastKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     M_Derivatives(count,nknots+2)=hhderv;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % opt = [BS,M_Derivatives'*lamda_new];
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % ySensors_opt = [yleftout ;zeros(size(M_Derivatives,1),1) ];
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % weights_opt = opt'\ySensors_opt;                   %Finding the weights
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %%%%%%%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %SPLINES 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %%%%%%%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % count=0;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  for x = xMin:Grid_opt:xMax 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      count=count+1;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      xxVec(count)=x;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      [aaval,aaderv]= quadruple_reccurence_start_modified(x,firstKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      M_splines(count,1) = aaval*weights_opt(1);    
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      [bbval,bbderv]= triple_reccurence_start_modified(x,firstKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      M_splines(count,2) = bbval*weights_opt(2);     
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      [ccval,ccderv]= Double_reccurence_start_modified(x,firstKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      M_splines(count,3) = ccval*weights_opt(3);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      for j= 1:nknots-4
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %          [ddval,ddderv] =Basis_Spline_modified(x,knots(j),knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %           M_splines(count,j+3) = ddval*weights_opt(j+3);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      end  
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      [ffval,ffderv]=Double_reccurence_end_modified(x,lastKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      M_splines(count,nknots) = ffval*weights_opt(nknots);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %        [ggval,ggderv]=triple_reccurence_end_modified(x,lastKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %       M_splines(count,nknots+1) = ggval*weights_opt(nknots+1);     
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      [hhval,hhderv]=quadruple_reccurence_end_modified(x,lastKnot,knotspan);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %       M_splines(count,nknots+2) = hhval*weights_opt(nknots+2);     
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  end  
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % hold off
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % xxLen =length (xxVec);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % yyVec = NaN(xxLen,1);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % for i=1:xxLen
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     %yyVec(i) = example_curve(xx(i));
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     yyVec(i) = dummyCurve(xxVec(i));
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %plot ( xx , yyVec, 'r--');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %  plot(xx, yyVec,'g--','LineWidth',3);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % hold on
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % add_opt = 0;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % add_spline_opt1 = 0;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %%%%%%%%%%%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %%%Calculating the fitting Curve
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %%%%%%%%%%%%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % for i = 1:nknots+2
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         add_opt = add_opt + M_Derivatives ( :,i)';
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         add_spline_opt1 = add_spline_opt1 + M_splines( :,i)';
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     figure (20)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     plot (xxVec,M_splines,'b','LineWidth',1.3)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     hold on
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      plot (xxVec, add_spline_opt1, 'k-','LineWidth',1.6)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %       legend('Clean Data','Spines');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %       print_pos=max(ySensors);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %       text(xMin+1,print_pos+.4,sprintf('       Sensors =>%g', nSensors));
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %       text(xMin+1,print_pos+.3,sprintf('Lambda =>%g', lamda));
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %       text(xMin+1, print_pos+.2,sprintf('Number of knots=> %g', nknots +2));
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %       text(xMin+1,print_pos+.1,sprintf(' First Value=> %g    Last value= %g ',xMin, xMax));
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %       text(xMin+1,print_pos+0,sprintf(' Knotspan=> %g ',knotspan));
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %       title('After Optimisation')
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %       plot(xleftout, yleftout, 'mo','MarkerFaceColor',[.10 1 .63]);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %       hold off
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %    hold on
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %   if (leftout_point~=0)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         plot (xSensors (leftout_point),ySensors (leftout_point), 'r*');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %   end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %   hold off
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %   plot(xVec, yVec,'g--','LineWidth',3);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % legend ('nknots');
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % hold on;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %   plot (xleftout,yleftout, 'mo','MarkerFaceColor',[.10 1 .63]);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      plot (xxVec,M_splines,'b','LineWidth',1.3)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     hold on
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %      plot (xxVec, add_spline_opt1, 'k-','LineWidth',1.6)


   
   
   
   
   
   
   
   
   
   
 
