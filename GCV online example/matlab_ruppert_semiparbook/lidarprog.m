%	Program to generate figures for the LIDAR data
%	
%
clear
clc

load lidar.dat ;
x = lidar(:,1) ;
y = lidar(:,2) ;

% Plot raw data, fit, confidence bounds, and prediction bounds
fit = PsplineDR04(x,y);
figure(1)
hf=fill([x; flipud(x) ],[fit.llimitpred; flipud(fit.ulimitpred)],[.9 .9 .9], ...
	[x; flipud(x)],[fit.llimit; flipud(fit.ulimit)],[.7 .7 .7]) ;
set(hf(1),'linestyle','none') ;
set(hf(2),'linestyle','none') ;
hold on ;
p=plot(x,y,'.',x,fit.yhat) ;
set(p(2),'linewidth',2) ;
xlabel('range','fontsize',14) ;
ylabel('logratio','fontsize',14) ;
set(gca,'xlim',[min(x) max(x)]) ;
hold off ;

% Plot estimated derivative and confidence bounds
fit2 = PsplineDR04(x,y,struct('degree',3));
figure(2) 
hf=fill([x; flipud(x)],-[fit2.llimitder; flipud(fit2.ulimitder)],[.7 .7 .7]) ;
set(hf(1),'linestyle','none') ;
hold on ;
p = plot(fit2.xgrid,-fit2.mhatder,fit2.xgrid,0*fit2.xgrid)
set(p(1),'linewidth',2) ;
xlabel('range','fontsize',14) ;
ylabel('-derivative of logratio','fontsize',14) ;
set(gca,'xlim',[min(x) max(x)]) ;
hold off ;