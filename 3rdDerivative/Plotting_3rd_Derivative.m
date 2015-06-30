clear
clc
hold off
xLin = -10:.1:20;
lenx=length(xLin);
y = NaN(lenx,1);
add =0;

for i = 1:lenx
    aa= quadruple_reccurence_start(xLin(i),-5);
    a(i)=aa;
     
end
for i = 1:lenx
    bb= triple_reccurence_start(xLin(i),-5);
    b(i)=bb;
end
 for i = 1:lenx
     cc= Double_reccurence_start(xLin(i),-5);
     c(i)=cc;
 end
 
basicspline=[-5:3];
 for j =1:length(basicspline)
     for i= 1:lenx
        
           dd =Basic_Spline_start(xLin(i),basicspline(j));
           d(i,j)=dd;
       
     end
     hold on
     add = add + d(:,j)
     %plot (xLin,d(:,j));
      
      hold on
 end

for i = 1:lenx
ee=Basic_Spline_end(xLin(i),3);
     e(i)=ee;
    ff=Double_reccurence_end(xLin(i),3);
    f(i)=ff;
end 

for i = 1:lenx
    gg=triple_reccurence_end(xLin(i),3);
    g(i)=gg;
end 

for i = 1:lenx
    hh=quadruple_reccurence_end(xLin(i),3);
    h(i)=hh;  
    
end

 %plot (xLin,a,'b',xLin,b,'b',xLin,c,'b',xLin,e,xLin,f,xLin,g,xLin,h )

hold on
add = add'
add = a+b+c+e+f+g+h+add;
plot ( xLin,add,'r')
hold on