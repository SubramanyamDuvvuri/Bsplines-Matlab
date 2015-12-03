
clear
clc
%Adding dimensions to a matrix
g = NaN(20,100,10);

sum =0;
for i = 1:10
 for j=1:20
   for k =1:100
        sum =bSpline3(k)*bSpline3(j);
       c(j,k) = sum;
   end  
 end
 g(:,:,i) =c;
end
% surf ( g(:,:,1))
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

