function [fc_loop, lc_loop] = handoffoverpass(c, blocknum, radius)
global radiusn
global radiusz
global radiusw
global lc_nloop fc_nloop lc_zloop fc_zloop lc_wloop fc_wloop on_nloop on_zloop on_wloop;
global nc;
global blockmax;

if radius == radiusn
    fc_loop = fc_nloop;
    lc_loop = lc_nloop;
elseif radius == radiusz
    fc_loop = fc_zloop;
    lc_loop = lc_zloop;
else
    fc_loop = fc_wloop;
    lc_loop = lc_wloop;
end

if lc_loop(blocknum) ~= 0
    nc(lc_loop(blocknum)) = c;
else
    fc_loop(blocknum) = c;
end
lc_loop(blocknum) = c;
nc(c) = 0;

% if mod(radius,2) == 0
%     if blocknum - 1 == 0
%         nc(c) = fc_loop(blockmax);
%     else
%         nc(c) = fc_loop(blocknum-1);
%     end
% else
%     if blocknum + 1 > blockmax
%         nc(c) = fc_loop(1);
%     else
%         nc(c) = fc_loop(blocknum+1);
%     end
% end
