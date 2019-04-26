function overpass(c, nextc, i, j, center, radius, sign, xpc, as, turn)
global nc dt broken x y xd yd fc lc pchangepath;
global centern radiusn;
global centerz radiusz;
global centerw radiusw;
global lc_nloop fc_nloop lc_zloop fc_zloop lc_wloop fc_wloop on_nloop on_zloop on_wloop;

change = decideoverpass(x(c),y(c),xd(c),yd(c),center,radius);
if change == 1 && rand <= pchangepath && x(c) ~= 0 && y(c) ~= 0
    car_before = find(nc==c);
    nc(car_before) = nextc;
    [on_loop, blocknum] = tooverpass(c,x(c),y(c),center,radius);
    [fc_loop, lc_loop] = handoffoverpass(c, blocknum, radius);
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
    if fc(i,j,as) == c
        fc(i,j,as) = nextc;
    end
    if(nextc==0)
        if fc(i,j,as) ~= 0
            lc(i,j,as) = car_before;
        else                  
            lc(i,j,as) = 0;
        end                  
    end
else
    if(~broken(c))                          %car not broken?
        x(c)=x(c)+sign*dt*v(sign*(xpc-x(c)));   %move car c
    end
    if((x(c)*sign)>(i*sign))                
        [inew,jnew,asnew]=decide(i,j,xd(c),yd(c)); 
        handoff                                 
        turn = 0;   
    end
    xpc=x(c);
end