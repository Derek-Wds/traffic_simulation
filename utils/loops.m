for block = 1:blockmax
    if block <= blockmax/4
        mode = 1;
    elseif block <= blockmax/2
        mode = 2;
    elseif block <= 3*blockmax/2
        mode = 3;
    else
        mode = 4;
    end
    
    % move car on the nloop
    c = fc_nloop(block);
    i = 1;
    while i ~= blockmax
        if mod(block + i, blockmax) == 0
            c_before = lc_wloop(blockmax);
        else
            c_before = lc_wloop(mod(block + i, blockmax));
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
            xp = centern;
            yp = centern + radiusn;
        elseif r < 0.5
            xp = centern + radiusn;
            yp = centern;
        elseif r < 0.75
            xp = centern;
            yp = centern - radiusn;
        else
            xp = centern - radiusn;
            yp = centern;
        end
    end
    while(c~=0)
        fprintf('c %i \n', c)
        fprintf('x(c) %i \n', x(c))
        fprintf('y(c) %i \n', y(c))
        nextc=nc(c);
        vec_c = [x(c)-centern y(c)-centern 0];
        vec_cb = [xp-centern yp-centern 0];
        ddegree = atan2d(norm(cross(vec_c,vec_cb)),dot(vec_c,vec_cb));
        distance = 2 * pi * radiusn * (ddegree / 360);
        move_distance = dt*v(distance);
        fprintf('distance %i \n', distance)
        fprintf('move distance %i \n', move_distance)
        ratio = move_distance / distance;
        if(~broken(c))
            [theta,rho] = cart2pol(x(c)-centern, y(c)-centern);
            if mod(radiusn, 2) == 0
                x(c) = cosd(rad2deg(theta)-ddegree*ratio)*radiusn + centern;
                y(c) = sind(rad2deg(theta)-ddegree*ratio)*radiusn + centern;
            else
                x(c) = cosd(rad2deg(theta)+ddegree*ratio)*radiusn + centern;
                y(c) = sind(rad2deg(theta)+ddegree*ratio)*radiusn + centern;
            end
        end
        
        xp = x(c);
        yp = x(c);
        c = nextc;
    end
    
    % move car on the zloop
    c = fc_zloop(block);
    i = 1;
    while i ~= blockmax
        if mod(block + i, blockmax) == 0
            c_before = lc_wloop(blockmax);
        else
            c_before = lc_wloop(mod(block + i, blockmax));
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
            xp = centerz;
            yp = centerz + radiusz;
        elseif r < 0.5
            xp = centerz + radiusz;
            yp = centerz;
        elseif r < 0.75
            xp = centerz;
            yp = centerz - radiusz;
        else
            xp = centerz - radiusz;
            yp = centerz;
        end
    end
    while(c~=0)
        % fprintf('c %i \n', c)
        % fprintf('x(c) %i \n', x(c))
        % fprintf('y(c) %i \n', y(c))
        nextc=nc(c);
        vec_c = [x(c)-centerz y(c)-centerz 0];
        vec_cb = [xp-centerz yp-centerz 0];
        ddegree = atan2d(norm(cross(vec_c,vec_cb)),dot(vec_c,vec_cb));
        distance = 2 * pi * radiusz * (ddegree / 360);
        move_distance = dt*v(distance);
        ratio = move_distance / distance;
        if(~broken(c))
            [theta,rho] = cart2pol(x(c)-centerz, y(c)-centerz);
            if mod(radiusz, 2) == 0
                x(c) = cosd(rad2deg(theta)-ddegree*ratio)*radiusz + centerz;
                y(c) = sind(rad2deg(theta)-ddegree*ratio)*radiusz + centerz;
            else
                x(c) = cosd(rad2deg(theta)+ddegree*ratio)*radiusz + centerz;
                y(c) = sind(rad2deg(theta)+ddegree*ratio)*radiusz + centerz;
            end
        end
        
        xp = x(c);
        yp = x(c);
        c = nextc;
    end
    
    % move car on the wloop
    c = fc_wloop(block);
    i = 1;
    while i ~= blockmax
        if mod(block + i, blockmax) == 0
            c_before = lc_wloop(blockmax);
        else
            c_before = lc_wloop(mod(block + i, blockmax));
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
            xp = centerw;
            yp = centerw + radiusw;
        elseif r < 0.5
            xp = centerw + radiusw;
            yp = centerw;
        elseif r < 0.75
            xp = centerw;
            yp = centerw - radiusw;
        else
            xp = centerw - radiusw;
            yp = centerw;
        end
    end
    while(c~=0)
        % fprintf('c %i \n', c)
        % fprintf('x(c) %i \n', x(c))
        % fprintf('y(c) %i \n', y(c))
        nextc=nc(c);
        vec_c = [x(c)-centerw y(c)-centerw 0];
        vec_cb = [xp-centerw yp-centerw 0];
        ddegree = atan2d(norm(cross(vec_c,vec_cb)),dot(vec_c,vec_cb));
        distance = 2 * pi * radiusw * (ddegree / 360);
        move_distance = dt*v(distance);
        ratio = move_distance / distance;
        if(~broken(c))
            [theta,rho] = cart2pol(x(c)-centerw, y(c)-centerw);
            if mod(radiusw, 2) == 0
                x(c) = cosd(rad2deg(theta)-ddegree*ratio)*radiusw + centerw;
                y(c) = sind(rad2deg(theta)-ddegree*ratio)*radiusw + centerw;
            else
                x(c) = cosd(rad2deg(theta)+ddegree*ratio)*radiusw + centerw;
                y(c) = sind(rad2deg(theta)+ddegree*ratio)*radiusw + centerw;
            end
        end
        
        xp = x(c);
        yp = x(c);
        c = nextc;
    end
    
end