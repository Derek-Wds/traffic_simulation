function handoffoverpass(c, blocknum, radius)
global radiusn
global radiusz
global radiusw
global lc_nloop fc_nloop lc_zloop fc_zloop lc_wloop fc_wloop;
global nc;
global blockmax;

if radius == radiusn
    if lc_nloop(blocknum) ~= 0
        nc(lc_nloop(blocknum)) = c;
    else
        fc_nloop(blocknum) = c;
    end
    lc_nloop(blocknum) = c;
    if mod(radius,2) == 0
        if blocknum - 1 == 0
            nc(c) = fc_nloop(blockmax);
        else
            nc(c) = fc_nloop(blocknum-1);
        end
    else
        if blocknum + 1 > blockmax
            nc(c) = fc_nloop(1);
        else
            nc(c) = fc_nloop(blocknum+1);
        end
    end
end   

if radius == radiusz
    if lc_zloop(blocknum) ~= 0
        nc(lc_zloop(blocknum)) = c;
    else
        fc_zloop(blocknum) = c;
    end
    lc_zloop(blocknum) = c;
    if mod(radius,2) == 0
        if blocknum - 1 == 0
            nc(c) = fc_nloop(blockmax);
        else
            nc(c) = fc_nloop(blocknum-1);
        end
    else
        if blocknum + 1 > blockmax
            nc(c) = fc_nloop(1);
        else
            nc(c) = fc_nloop(blocknum+1);
        end
    end
end

if radius == radiusw
    if lc_wloop(blocknum) ~= 0
        nc(lc_wloop(blocknum)) = c;
    else
        fc_wloop(blocknum) = c;
    end
    lc_wloop(blocknum) = c;
    if mod(radius,2) == 0
        if blocknum - 1 == 0
            nc(c) = fc_nloop(blockmax);
        else
            nc(c) = fc_nloop(blocknum-1);
        end
    else
        if blocknum + 1 > blockmax
            nc(c) = fc_nloop(1);
        else
            nc(c) = fc_nloop(blocknum+1);
        end
    end
end