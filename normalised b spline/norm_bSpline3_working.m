%working with 0 degree normalised b spline curve:norm_bSpline1
clear
clc
hold off
xLin = -10:.1:20;
lenx=length(xLin);
y = NaN(lenx,1);

for i = 1:lenx
    aa= Spline_00001(xLin(i),5);
    a(i)=aa;
     
end
for i = 1:lenx
    bb= Spline_00012(xLin(i),5);
    b(i)=bb;
end
 for i = 1:lenx
     cc= Spline_00123(xLin(i),5);
     c(i)=cc;
 end

 for i = 1:lenx
     dd1= Spline_01234(xLin(i),5);
     d1(i)=dd1;
dd2= Spline_01234(xLin(i),4);
     d2(i)=dd2;
dd3= Spline_01234(xLin(i),3);
     d3(i)=dd3;
dd4= Spline_01234(xLin(i),2);
     d4(i)=dd4;
dd5= Spline_01234(xLin(i),1);
     d5(i)=dd5;
dd6= Spline_01234(xLin(i),0);
     d6(i)=dd6;
dd7= Spline_01234(xLin(i),-1);
     d7(i)=dd7;
dd8= Spline_01234(xLin(i),-2);
     d8(i)=dd8;
dd9= Spline_01234(xLin(i),-3);
     d9(i)=dd9;
 end 
%     ee=Spline_12345(xLin(i),-3);
%      e(i)=ee;
for i = 1:lenx
ee=Spline_12345(xLin(i),-3);
     e(i)=ee;
    ff=Spline_23455(xLin(i),-3);
    f(i)=ff;
end 

for i = 1:lenx
    gg=Spline_34555(xLin(i),-3);
    g(i)=gg;
end 

for i = 1:lenx
    hh=Spline_45555(xLin(i),-3);
    h(i)=hh;  
    
end
 for i = 1:lenx
        add(i)=d1(i)+d2(i)+d3(i)+d4(i)+d5(i)+d6(i)+d7(i)+d8(i)+d9(i)
end
% plot ( xLin,add)
% hold on

for i = 1:lenx
       add(i)=a(i)+b(i)+c(i)+e(i)+f(i)+g(i)+h(i)+add(i);
end
 plot (xLin,a,'m',xLin,b,'k',xLin,c,'r',xLin,e,'b','LineWidth',1.4);
 hold on
 plot ( xLin,add,'k--','LineWidth',1.7)
  legend ('quadraple','triple','double','basic','Fit');
 plot(xLin,f,'r',xLin,g,'k',xLin,h,'m' )
 plot (xLin,d1,'b',xLin,d2,'b',xLin,d3,'b',xLin,d4,'b',xLin,d5,'b',xLin,d6,'b',xLin,d7,'b',xLin,d8,'b',xLin,d9,'b');
xlabel(['\fontsize{13}Knots---->']);
ylabel(['\fontsize{13}Weights---->'])
 title(['\fontsize{15}Open Uniform B-Spline fit']);
hold off

%axis ([-10 10 0 8])










