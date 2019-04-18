function  changeblock(center, radius, c, nextc)

global lc_nloop fc_nloop lc_zloop fc_zloop lc_wloop fc_wloop;
global blockmax;
global centern radiusn;
global centerz radiusz;
global centerw radiusw;
global nc dt broken x y;

% decide which loop
if radius == radiusn
    blocknum = find(fc_nloop==c);
elseif radius == radiusz
    blocknum = find(fc_zloop==c);
else
    blocknum = find(fc_wloop==c);
end

nextblock = 0;
% check if should move to next block
if blocknum
    if mod(radius, 2) == 0
        if blocknum <= blockmax / 2
            pointer = [0 center 0];
            rel_vec = [x(c)-center y(c)-center 0];
            degree = atan2d(norm(cross(pointer,rel_vec)),dot(pointer,rel_vec));
        else
            pointer = [0 center - radius 0];
            rel_vec = [x(c)-center y(c)-center 0];
            degree = atan2d(norm(cross(pointer,rel_vec)),dot(pointer,rel_vec)) + 180;
        end
        if degree > (blocknum * 360 / blockmax)
            if blocknum + 1 > blockmax
                nextblock = 1;
            else
                nextblock = blocknum + 1;
            end
        end
    else
        if blocknum <= blockmax / 2
            pointer = [0 center 0];
            rel_vec = [x(c)-center y(c)-center 0];
            degree = atan2d(norm(cross(pointer,rel_vec)),dot(pointer,rel_vec));
        else
            pointer = [0 center - radius 0];
            rel_vec = [x(c)-center y(c)-center 0];
            degree = atan2d(norm(cross(pointer,rel_vec)),dot(pointer,rel_vec)) + 180;
        end
        if degree > (blocknum * 360 / blockmax)
            if blocknum - 1 < 1
                nextblock = blockmax;
            else
                nextblock = blocknum - 1;
            end
        end
    end
    if nextblock
        if radius == radiusn
            if fc_nloop(nextblock) == 0
                fc_nloop(nextblock) = c;
            end
            if lc_nloop(nextblock) ~= 0
                nc(lc_nloop(nextblock)) = c;
            end
            lc_nloop(nextblock) = c;
            nc(c) = 0;
            fc_nloop(blocknum) = nextc;
        elseif radius == radiusz
            if fc_zloop(nextblock) == 0
                fc_zloop(nextblock) = c;
            end
            if lc_zloop(nextblock) ~= 0
                nc(lc_zloop(nextblock)) = c;
            end
            lc_zloop(nextblock) = c;
            nc(c) = 0;
            fc_zloop(blocknum) = nextc;
        else
            if fc_wloop(nextblock) == 0
                fc_wloop(nextblock) = c;
            end
            if lc_wloop(nextblock) ~= 0
                nc(lc_wloop(nextblock)) = c;
            end
            lc_wloop(nextblock) = c;
            nc(c) = 0;
            fc_wloop(blocknum) = nextc;
        end
    end
end