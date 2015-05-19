clear all;

%%for_loop tutorial
x = 1:3;
x =meshgrid (x) ;
for i =1 : size(x,1)
    
    for j = 1:size(x,2)
    if mod (x(i,j),2)== 0
        fprintf ('the number is even\n');
    elseif mod (x(i,j),2) == 1
        fprintf ('the number is odd\n');
      
    end     
           y(i,j)= x(i,j);
    end 
end
y

for i= 1:size(x,1)
    for j = 1:size(x,2)
            
            z(i,j)=x(i,j).*y(i,j);
        
    end
end
z
plot3(x,y,z)
plot (x,y)
mesh(x,y)
mesh (x,y,z)



