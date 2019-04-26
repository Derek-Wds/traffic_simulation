function loops(center, radius)
global lc_nloop fc_nloop lc_zloop fc_zloop lc_wloop fc_wloop;
global on_nloop on_zloop on_wloop;
global centern radiusn;
global centerz radiusz;
global centerw radiusw;
global blockmax nc dt broken x y xd yd fc lc pchangepath;

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
    if c_before == 0 & (fc_loop(blocknum) ~= lc_loop(blocknum))
        c_before = lc_loop(blocknum);
    end
    if c_before ~= 0
        xp = x(c_before);
        yp = y(c_before);
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
        if car_before
            % disp('car_before')
            % disp(car_before)
            % fprintf('car before position %i %i ',x(car_before), y(car_before))
            xp = x(car_before);
            yp = y(car_before);
        else
            % if radius == radiusz
            %     disp('works!')
            %     fprintf('old position %i %i \n', x(c), y(c));
            % end
            car_before = 0;
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
        if(~broken(c))
            vec_c = [x(c)-center y(c)-center 0];
            vec_cb = [xp-center yp-center 0];
            ddegree = atan2d(norm(cross(vec_c,vec_cb)),dot(vec_c,vec_cb));
            distance = 2 * pi * radius * (ddegree / 360);
            move_distance = dt * v(distance);
            ratio = move_distance / distance;
            [theta,rho] = cart2pol(x(c)-center, y(c)-center);
            if mod(radius, 2) == 0
                x(c) = cosd(rad2deg(theta)-ddegree*ratio)*radius + center;
                y(c) = sind(rad2deg(theta)-ddegree*ratio)*radius + center;
            else
                x(c) = cosd(rad2deg(theta)+ddegree*ratio)*radius + center;
                y(c) = sind(rad2deg(theta)+ddegree*ratio)*radius + center;
            end
            % if radius == radiusz
            %     fprintf('nloop vecc %i %i %i \n', vec_c)
            %     fprintf('nloop veccb %i %i %i \n', vec_cb)
            %     fprintf('ddegree %i\n', ddegree)
            %     fprintf('distance %i \n', distance)
            %     fprintf('move distance %i \n', move_distance)
            %     fprintf('theta %i, rho %i\n', theta, rho)
            %     fprintf('new position %i %i \n', x(c), y(c));
            % end
        end
        
        % if on_loop(c) == 1 & radius == radiusw
        %     disp('cc:\n')
        %     disp(c)
        %     disp('on loop')
        %     disp(on_loop(c))
        %     if radius == radiusn
        %         disp('nloop')
        %     elseif radius == radiusz
        %         disp('zloop')
        %     else
        %         disp('wloop')
        %     end
        %     fprintf('car position %i %i', x(c), y(c))
        %     if car_before
        %         disp('car before:\n')
        %         disp(car_before)
        %         disp('car before on loop:\n')
        %         disp(on_loop(car_before))
        %     end
        %     disp('block number\n')
        %     disp(blocknum)
        %     disp('fc_loop block\n')
        %     disp(fc_loop(blocknum))
        %     disp('lc_loop block\n')
        %     disp(lc_loop(blocknum))
        % end

        % check if car should be off the overpass and to road
        offoverpass = 0;
        toroad
        if offoverpass == 1
            on_loop(c) = 0;
            if c == fc_loop(blocknum)
                fc_loop(blocknum) = nextc;
            elseif car_before ~= 0
                nc(car_before) = nextc;
            end
            if car_before
                lc_loop(blocknum) = car_before;
            else
                lc_loop(blocknum) = 0;
            end

        % else
        %     xp = x(c);
        %     yp = y(c);
        end


        % change block for different cars
        [fc_loop, lc_loop] = changeblock(center, radius, c, nextc, fc_loop, lc_loop);

        xp = x(c);
        yp = y(c);
        c = nextc;
    end
end

% decide which loop
if radius == radiusn
    fc_nloop = fc_loop;
    lc_nloop = lc_loop;
    on_nloop = on_loop;
elseif radius == radiusz
    fc_zloop = fc_loop;
    lc_zloop = lc_loop;
    on_zloop = on_loop;
else
    fc_wloop = fc_loop;
    lc_wloop = lc_loop;
    on_wloop = on_loop;
end