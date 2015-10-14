function position = find_position( data , element )

for i = 1 : length (data)
    %if ( (data (i))== (element) )
      if isequal (data(i)*1000000000000000,element*10000000000000000)
        position = i;
    end
end
end


