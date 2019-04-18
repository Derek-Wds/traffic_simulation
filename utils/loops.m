function loops(center, radius)
global lc_nloop fc_nloop lc_zloop fc_zloop lc_wloop fc_wloop;
global on_nloop on_zloop on_wloop;
global centern radiusn;
global centerz radiusz;
global centerw radiusw;
global blockmax nc dt broken x y fc lc;

% decide which loop
if radius == radiusn
    fc_loop = fc_nloop;
    lc_loop = lc_nloop;
    on_loop = on_nloop;
elseif radius == radiusz
    fc_loop = fc_zloop;
    lc_loop = lc_zloop;
    on_loop = on_zloop;
else
    fc_loop = fc_wloop;
    lc_loop = lc_wloop;
    on_loop = on_wloop;
end

for blocknum = 1:blockmax
    
    % move car on the loop
    c = fc_loop(blocknum);
    % fprintf('fcloop %i \n', fc_loop(blocknum));
    % fprintf('lcloop %i \n', lc_loop(blocknum));
    i = 1;
    while i < blockmax
        if mod(blocknum + i, blockmax) == 0
            c_before = lc_loop(blockmax);
        else
            c_before = lc_loop(mod(blocknum + i, blockmax));
        end
        i = i + 1;
        if c_before ~= 0
            break
        end
    end
    if c_before ~= 0
        xp = x(c_before);
        yp = x(c_before);
    else
        r = rand;
        if r < 0.25
            xp = center;
            yp = center + radius;
        elseif r < 0.5
            xp = center + radius;
            yp = center;
        elseif r < 0.75
            xp = center;
            yp = center - radius;
        else
            xp = center - radius;
            yp = center;
        end
    end
    while(c~=0)
        nextc=nc(c);
        car_before = find(nc==c);
        if c == nextc
            nc(c) = 0;
            break
        end
        if(~broken(c))
            vec_c = [x(c)-center y(c)-center 0];
            vec_cb = [xp-center yp-center 0];
            % fprintf('nloop vecc %i %i %i \n', vec_c)
            % fprintf('nloop veccb %i %i %i \n', vec_cb)
            ddegree = atan2d(norm(cross(vec_c,vec_cb)),dot(vec_c,vec_cb));
            distance = 2 * pi * radius * (ddegree / 360);
            move_distance = dt*v(distance);
            % fprintf('distance %i \n', distance)
            % fprintf('move distance %i \n', move_distance)
            ratio = move_distance / distance;
            [theta,rho] = cart2pol(x(c)-center, y(c)-center);
            if mod(radius, 2) == 0
                x(c) = cosd(rad2deg(theta)-ddegree*ratio)*radius + center;
                y(c) = sind(rad2deg(theta)-ddegree*ratio)*radius + center;
            else
                x(c) = cosd(rad2deg(theta)+ddegree*ratio)*radius + center;
                y(c) = sind(rad2deg(theta)+ddegree*ratio)*radius + center;
            end
        end

        % change block
        changeblock(center, radius, c, nextc);
        
        % check if car should be off the overpass and to road
        offoverpass = 0;
        toroad
        if offoverpass == 1
            on_loop(c) = 0;
            if car_before
                if find(fc_loop==c)
                    fc_loop(find(fc_loop==c)) = nextc;
                end
                if find(lc_loop==c)
                    lc_loop(find(lc_loop==c)) = 0;
                end
                if car_before == nextc
                    nc(car_before) = nextc;
                else
                    nc(car_before) = 0;
                end
            end
        else
            xp = x(c);
            yp = y(c);
        end

        c = nextc;
    end
    
end