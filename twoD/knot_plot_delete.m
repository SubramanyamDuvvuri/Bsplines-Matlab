
x = 1:100;
 y= 1:100;
 [X, Y]=meshgrid (x,y);
 z = NaN (100,100);
nSensors =100;
 p=0;
 
 for i = 1:5
     for j = 1:9
         plot3 ( x(i) , y(j),1,'r*');
         hold on
     end
 end
 
% for i = 9
%         p=p+1;
%         for k=1:nSensors
%              %BS(p,k)=k;  
%               plot3(BS(4,k),i,1);
%               hold on
%              
%         
%     end
% end


