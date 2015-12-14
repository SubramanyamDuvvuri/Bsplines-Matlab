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
% for i = 1:lenx
%        add(i)=a(i)+b(i)+c(i)+d1(i)+d2(i)+d3(i)+d4(i)+d5(i)+d6(i)+d7(i)+d8(i)+d9(i)+e(i)+f(i)+g(i)+h(i);
% end
% plot ( xLin,add)
% hold on
 plot (xLin,a,'b',xLin,b,'b',xLin,c,'b',xLin,e,xLin,f,xLin,g,xLin,h )

%plot (xLin,a,'b')
hold on
plot (xLin,d1,'r',xLin,d2,'r',xLin,d3,'r',xLin,d4,'r',xLin,d5,xLin,d6,xLin,d7,xLin,d8,xLin,d9);
for i = 1:lenx
       add_spline(i)=a(i)+b(i)+c(i)+e(i)+f(i)+g(i)+h(i)+add_spline(i);
end
plot ( xLin,add_spline)
hold on

%axis ([-10 10 0 8])










