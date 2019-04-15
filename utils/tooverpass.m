function blocknum=tooverpass(c,x,y,center,radius)
global blockmax;
global radiusn;
global radiusz;
global radiusw;

onroad(c) = 0;
xpos = x - center;
ypos = y - center;

degree = 360 / blockmax;

blocknum = 0;
for pos = 1:blockmax
    if blocknum ~= 0
        break
    end
    if pos <= blockmax/2
        xrange = radius * cosd(90 - degree * pos) + 0.05;
    else
        xrange = radius * cosd(90 - degree * pos) - 0.05;
    end
    if xpos >= 0 && xrange >= xpos
        if ypos > 0
            blocknum = pos;
        else
            blocknum = blockmax/2 - pos;
        end
    elseif xpos < 0 && xrange <= xpos
        if ypos > 0
            blocknum = 3 * (blockmax/2) - pos;
        else
            blocknum = pos;
        end
    end
end

if radius == radiusn
    on_nloop(c) = 1;
elseif radius == radiusz
    on_zloop(c) = 1;
elseif radius == radiusw
    on_wloop(c) = 1;
end

