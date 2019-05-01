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

if fc_loop(blocknum) == 0
    fc_loop(blocknum) = c;
    lc_loop(blocknum) = c;
    nc(c) = 0;
elseif getcarpos(c, fc_loop(blocknum), radius, blocknum) == 1
    nc(c) = fc_loop(blocknum);
    fc_loop(blocknum) = c;
elseif getcarpos(lc_loop(blocknum), c, radius, blocknum) == 1
    nc(lc_loop(blocknum)) = c;
    lc_loop(blocknum) = c;
    nc(c) = 0;
else
    pc = fc_loop(blocknum);
    cc = nc(pc);
    while cc ~= 0
        if getcarpos(c, cc, radius, blocknum) == 1
            nc(pc) = c;
            nc(c) = cc;
            break
        else
            pc = cc;
            cc = nc(cc);
        end
    end
end