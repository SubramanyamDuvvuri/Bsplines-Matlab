clear
%Plotting Parametric equations
  t= linspace (-30,-1.6);
    X= ((3*t)/(1+t.^3));
    Y= ((3*t.^2)/(1+t.^3));
    
    for i = 1:length (t)
        X= ((3*t(i))/(1+t(i).^3));
        Y= ((3*t(i).^2)/(1+t(i).^3));
    contour (X)
    hold on
    end
    
    figure
 t = 0:.01:5;
x = t.^4 -1;
y = t.^3 + 1;
 plot(x,y);
plot3(x,y,t)
