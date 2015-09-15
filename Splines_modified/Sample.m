clear
clc
hold off
xLin = 0:.001:4;
lenx=length(xLin);
y = NaN(lenx,1);
firstknot = xLin (1);
lastknot =xLin(end);
add = NaN(1,length(xLin));
for i = 1:lenx
    aa= quadruple_reccurence_start_modified(xLin(i),firstknot);
    a(i)=aa;
     
end
plot (xLin , a)
for i = 1:lenx
    bb= triple_reccurence_start_modified(xLin(i),firstknot);
    b(i)=bb;
end
 for i = 1:lenx
     cc= Double_reccurence_start_modified(xLin(i),firstknot);
     c(i)=cc;
 end
 
basicspline=[0:.5:2];
 for j =1:length(basicspline)
     for i= 1:lenx
           dd =Basis_Spline_modified(xLin(i),basicspline(j));
           d(i,j)=dd;
           
     end
     hold on
      plot (xLin,d);
      add = add + d;
      hold on
 end

for i = 1:lenx

    ff=Double_reccurence_end_modified(xLin(i),lastknot);
    f(i)=ff;
end 

for i = 1:lenx
    gg=triple_reccurence_end_modified(xLin(i),lastknot);
    g(i)=gg;
end 

for i = 1:lenx
    hh=quadruple_reccurence_end_modified(xLin(i),lastknot);
    h(i)=hh;  
    
end

 plot (xLin,a,'b',xLin,b,xLin,c,xLin ,f,xLin,g,xLin,h)
hold on


add = add+a +b+c+f+g+h+d;

plot ( xLin,add,'+')
hold on