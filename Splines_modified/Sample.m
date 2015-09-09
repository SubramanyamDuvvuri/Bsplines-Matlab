clear
clc
hold off
xLin = -10:.1:20;
lenx=length(xLin);
y = NaN(lenx,1);

for i = 1:lenx
    aa= quadruple_reccurence_start_modified(xLin(i),0);
    a(i)=aa;
     
end
for i = 1:lenx
    bb= triple_reccurence_start_modified(xLin(i),0);
    b(i)=bb;
end
 for i = 1:lenx
     cc= Double_reccurence_start_modified(xLin(i),0);
     c(i)=cc;
 end
 
basicspline=[0:2];
 for j =1:length(basicspline)
     for i= 1:lenx
           dd =Basic_Spline_modified(xLin(i),basicspline(j));
           d(i,j)=dd;
           
     end
     hold on
      plot (xLin,d);
      hold on
 end

for i = 1:lenx
ee=Basic_Spline_end(xLin(i),2);
     e(i)=ee;
    ff=Double_reccurence_end_modified(xLin(i),2);
    f(i)=ff;
end 

for i = 1:lenx
    gg=triple_reccurence_end_modified(xLin(i),2);
    g(i)=gg;
end 

for i = 1:lenx
    hh=quadruple_reccurence_end_modified(xLin(i),2);
    h(i)=hh;  
    
end

 plot (xLin,a,'b',xLin,b,'b',xLin,c,'b',xLin,e,xLin,f,xLin,g,xLin,h )
hold on
for i = 1:lenx
       add(i)=a(i)+b(i)+c(i)+e(i)+f(i)+g(i)+h(i);
end
%plot ( xLin,add)
hold on