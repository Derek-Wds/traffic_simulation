addpath('utils')

clear
clf
initialize
t = 0;
tk = 0;
numcars = 0;
numcarsout = 0;
set(gcf,'double','on')
plot(xpl,YPL,'y-',XPL,ypl,'y-',xnpl,ynpl,'b-',xzpl,yzpl,'b-',xwpl,ywpl,'b-');
hold on
hcars = plot(0,0,'ko', 'MarkerFaceColor',[0.9290 0.6940 0.1250], 'MarkerSize',6);
hcars_nloops = plot(0,0,'ko', 'MarkerFaceColor',[0.9290 0.6940 0.1250], 'MarkerSize',6);
hcars_zloops = plot(0,0,'ko', 'MarkerFaceColor',[0.9290 0.6940 0.1250], 'MarkerSize',6);
hcars_wloops = plot(0,0,'ko', 'MarkerFaceColor',[0.9290 0.6940 0.1250], 'MarkerSize',6);
hbcars = plot(0,0,'r*');
hcblocked = plot(0,0,'g*');
axis manual
axis equal
axis([0 (I+1) 0 (J+1)])

while((numcars<numcarsmax)|(numcarsout>0))
  t = t+dt;
  tk = tk+1;
  breakdown           %flag broken cars
  setlights
  createcars
  avenues
  unblock             %unblock corners where blocking car has moved
  streets
  loops(centern, radiusn);               %move cars on the nloop
  loops(centerz, radiusz);               %move cars on the zloop
  loops(centerw, radiusw);               %move cars on the wloop
  deletecars
  unblock             %unblock corners where blocking car has moved
  set(hcars,'xdata',x(find(onroad)),'ydata',y(find(onroad)))
  set(hcars_nloops,'xdata', x(find(on_nloop)),'ydata', y(find(on_nloop)))
  set(hcars_zloops,'xdata', x(find(on_zloop)),'ydata', y(find(on_zloop)))
  set(hcars_wloops,'xdata', x(find(on_wloop)),'ydata', y(find(on_wloop)))
  [ib,jb,cb]=find(cblocked);
  set(hcblocked,'xdata',x(cb),'ydata',y(cb))
  set(hbcars,'xdata',x(find(onroad&broken)),'ydata',y(find(onroad&broken)))
  drawnow

end
hold off