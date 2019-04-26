function  [fc_loop, lc_loop]=changeblock(center, radius, c, nextc, fc_loop, lc_loop)

global blockmax;
global centern radiusn;
global centerz radiusz;
global centerw radiusw;
global nc dt broken x y;

% find which block is the car
blocknum = find(fc_loop==c);

nextblock = 0;
% check if should move to next block
if blocknum
    if blocknum <= blockmax / 2
        pointer = [0 radius 0];
        rel_vec = [x(c)-center y(c)-center 0];
        degree = atan2d(norm(cross(pointer,rel_vec)),dot(pointer,rel_vec));
    else
        pointer = [0 -radius 0];
        rel_vec = [x(c)-center y(c)-center 0];
        degree = atan2d(norm(cross(pointer,rel_vec)),dot(pointer,rel_vec)) + 180;
    end
    if mod(radius, 2) == 0
        if degree > (blocknum * 360 / blockmax)
            gap = ceil((degree - blocknum * 360 / blockmax) / (360 / blockmax));
            if blocknum + gap > blockmax
                nextblock = blocknum + gap - blockmax;
            else
                nextblock = blocknum + gap;
            end
        end
    else
        if degree < (blocknum * 360 / blockmax)
            gap = ceil((blocknum * 360 / blockmax - degree) / (360 / blockmax));
            if blocknum - gap < 1
                nextblock = blocknum - gap + blockmax;
            else
                nextblock = blocknum - gap;
            end
        end
    end
    if nextblock
        % if radius == radiusz
        %     fprintf('block %i \n', blocknum);
        %     fprintf('nextblock %i \n', nextblock);
        %     fprintf('position %i %i \n', x(c), y(c));
        %     fprintf('\n');
        %     fprintf('\n');
        %     % error('stop!')
        % end
        if fc_loop(nextblock) == 0
            fc_loop(nextblock) = c;
        else
            nc(lc_loop(nextblock)) = c;
        end
        lc_loop(nextblock) = c;
        nc(c) = 0;
        fc_loop(blocknum) = nextc;
        if nextc == 0
            lc_loop(blocknum) = 0;
        end
    end
end