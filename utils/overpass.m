function overpass(c, nextc, beforec, i, j, center, radius, sign, xpc, as)
global nc dt broken x y xd yd fc lc;
global centern radiusn;
global centerz radiusz;
global centerw radiusw;
global lc_nloop fc_nloop lc_zloop fc_zloop lc_wloop fc_wloop;

change = decideoverpass(x(c),y(c),xd(c),yd(c),center,radius);
if change == 1 && rand <= 0.15 && x(c) ~= 0 && y(c) ~= 0
    blocknum = tooverpass(c,x(c),y(c),center,radius);
    [fc_loop, lc_loop] = handoffoverpass(c, blocknum, radius);
    if radius == radiusn
        fc_nloop = fc_loop;
        lc_nloop = lc_loop;
    elseif radius == radiusz
        fc_zloop = fc_loop;
        lc_zloop = lc_loop;
    else
        fc_wloop = fc_loop;
        lc_wloop = lc_loop;
    end
    if c ~= fc(i,j,as)
        nc(beforec) = nextc;
    else
        fc(i,j,as) = nextc;
    end     
    if(nextc==0)
        if fc(i,j,as) ~= 0
            lc(i,j,as) = beforec;
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
    end
    xpc=x(c);
end