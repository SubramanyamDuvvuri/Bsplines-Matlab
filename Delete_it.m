clear
clc
count =1;
grid = 1;
for j = 1:5
    count =0;
  for i = 1 :grid: 10
    fprintf ('%f\n',grid);
    count = count +1 ;
    if count == 4
        grid = grid /10;
        break;
    end
  end
end