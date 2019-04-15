[ib,jb,cb]=find(cblocked);       %list of blocked corners
                               %and indices of blocking cars
ncblocked=length(cb);          %number of blocked corners
for kb=1:ncblocked
  xcondition=abs(x(cb(kb))-ib(kb))<=dmin;
  ycondition=abs(y(cb(kb))-jb(kb))<=dmin;
  cblocked(ib(kb),jb(kb))=cb(kb)*(onroad(cb(kb))&xcondition&ycondition);
end