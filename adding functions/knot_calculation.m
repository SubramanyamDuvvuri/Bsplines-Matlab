function KnotSpan = knot_calculation( nSensors ,Start , End  )
    knots_number = min(nSensors/4 , 40);
    range = [Start : End];
   range_length = length ( range) ;
   KnotSpan = range_length/knots_number;
end

