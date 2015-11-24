function y = dummyCurve(x,option)
     if option == 1
        y = 2*exp(-0.4*(x-2)^2) + 5/(x+10) + 0.1*x -0.2;
     elseif option ==2
       y = 3^x- 2^x + exp(-5*x) + exp (-20 * (x-.5)^2);
     elseif option ==3
       y  = 4.26 * (exp(-x)-4 * exp (-2*x) +3 * exp (-3 *x)); % (0 ,4 )
     elseif option ==4 
      y= sin(0.83.*pi.*X) .* cos(1.25.*pi.*x); 

        end
end
%y=exp(-x^2);
%y = 1/(x^2+1)+1;
%y = 0.2*x;
%y =1;