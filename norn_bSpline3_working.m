%working with first degree normalised b spline curve:norm_bSpline1

xLin = -5:.1:5;
lenx=length(xLin);
knots = [1];

y = NaN(lenx,1);

% for j =1:length(knots)
% for i = 1:lenx
% 
%     yy= norm_bSpline1(xLin(i),knots(j));
%     y(i)=yy;
% end
% figure (1)
% plot (xLin,y)
% hold on;
% axis ([-20 20 0 2])
% end


figure(2)
for j =1:length(knots)
    yy=0;
 for i = 1:lenx
    yy= norm_bSpline3(xLin(i),knots(j));
    y(i)=yy;
end
plot (xLin,y)
hold on;
end

