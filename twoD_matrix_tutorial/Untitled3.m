
clear
clc
%Adding dimensions to a matrix
g = NaN(20,20,8);

sum = 100;
for i = 1:8
 for j=1:20
   for k =1:20
       sum =rand (1,1);
       c(j,k) = sum;
   end  
 end
 
 g(:,:,i) =c;
end

figure (1)
add = 0;
for i = 1:8
surf ( g(:,:,i));
add = add +g( :,:,i);
hold on
end
hold off
surf (add);



function_new (g);
%-------------------------------------------

