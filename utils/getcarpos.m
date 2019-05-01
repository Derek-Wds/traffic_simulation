function position=getcarpos(c, pc, radius, blocknum)

global radiusn
global radiusz
global radiusw
global lc_nloop fc_nloop lc_zloop fc_zloop lc_wloop fc_wloop on_nloop on_zloop on_wloop;
global blockmax nc dt broken x y xd yd fc lc pchangepath;

% position = 0 -> car is relatively behind
position = 0;

% clockwise
if mod(radius,2)==0
    if blocknum <= blockmax / 4
        if x(c) > x(pc)
            position = 1;
        end
    elseif blocknum <= blockmax / 2
        if x(c) < x(pc)
            position = 1;
        end
    elseif blocknum <= blockmax*3 / 4
        if x(c) < x(pc)
            position = 1;
        end
    else
        if x(c) > x(pc)
            position = 1;
        end
    end
% counter-clockwise
else
    if blocknum <= blockmax / 4
        if x(c) < x(pc)
            position = 1;
        end
    elseif blocknum <= blockmax / 2
        if x(c) > x(pc)
            position = 1;
        end
    elseif blocknum <= blockmax*3 / 4
        if x(c) > x(pc)
            position = 1;
        end
    else
        if x(c) < x(pc)
            position = 1;
        end
    end
end