function vv = v(d)
global dmin dmax v0 vmax;
if(d < dmin)
  vv = 0;
elseif(d < dmax)
  vv = v0 * log(d/dmin);
else
  vv = vmax;
end
