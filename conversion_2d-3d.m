npts = 10;
xy = [randn(1,npts); randn(1,npts)];
plot(xy(1,:),xy(2,:),'ro','LineWidth',2);
text(xy(1,:), xy(2,:),[repmat('  ',npts,1), num2str((1:npts)')])
ax = gca;
ax.XTick = [];
ax.YTick = [];