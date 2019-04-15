as=2;                                         %consider cars on streets
for j=1:J                                     %all streets
  sign=odd(j)-even(j);                        %direction of traffic flow
  for i=((I:(-1):2)*odd(j)+(1:(I-1))*even(j)) %blocks on street j
    
    %xpc = x-coordinate of the car ahead of the first car on the block.
    %If the block ahead is empty, or if there is no such block,
    %xpc is set  dmax  ahead of the first car, 
    %so the first car can proceed at maximum speed.
    %If the traffic light is red, however, it is treated as the car ahead,
    %so xpc is set equal to the x-coordinate of the (red) light.
    if((L(i,j,as)==0)|cblocked(i,j))     %red light (or blocked intersection)?
      xpc=i;                                   %"previous car" = traffic light
    elseif((1<i)&(i<I))                       %interior block?
      if(lc(i+sign,j,as)~=0)                    %next block not empty?
        xpc=x(lc(i+sign,j,as));                  %previous car is 
      end                                       %the last car on next block
    else                                      %otherwise
      xpc=i+sign*dmax;                         %first car can proceed
    end                                        %at maximum speed

    c=fc(i,j,as);                            %c=first car on block
    beforec = c;
    while(c~=0)                              %consider all cars on block
      nextc=nc(c);                            %note next car

      % check if move to the loop
      if (abs(sqrt((x(c) - centern)^2 + (y(c) - centern)^2) - radiusn) <= 0.01)
          change = decideoverpass(x(c),y(c),xd(c),yd(c),centern,radiusn);
          if change == 1 && rand <= 0.5 && x(c) ~= 0 && y(c) ~= 0
              blocknum = tooverpass(c,x(c),y(c),centern,radiusn);
              handoffoverpass(c, blocknum, radiusn)
              if c ~= fc(i,j,as)
                nc(beforec) = nextc;
              end         
              fc(i,j,as) = nextc;         
              if(nextc==0)                      
                lc(i,j,as)=0;                  
              end
          else
              if(~broken(c))                          %car not broken?
                x(c)=x(c)+sign*dt*v(sign*(xpc-x(c)));   %move car c
              end
              if((x(c)*sign)>(i*sign))                
                [inew,jnew,asnew]=decide(i,j,xd(c),yd(c)); 
                handoff                                    
              end
          end
      elseif (abs(sqrt((x(c) - centerz)^2 + (y(c) - centerz)^2) - radiusz) <= 0.01)
          change = decideoverpass(x(c),y(c),xd(c),yd(c),centerz,radiusz);
          if change == 1 && rand <= 0.5 && x(c) ~= 0 && y(c) ~= 0
              blocknum = tooverpass(c,x(c),y(c),centerz,radiusz);
              handoffoverpass(c, blocknum, radiusz)
              if c ~= fc(i,j,as)
                nc(beforec) = nextc;
              end         
              fc(i,j,as) = nextc;         
              if(nextc==0)                      
                lc(i,j,as)=0;                  
              end
          else
              if(~broken(c))                          %car not broken?
                x(c)=x(c)+sign*dt*v(sign*(xpc-x(c)));   %move car c
              end
              if((x(c)*sign)>(i*sign))                
                [inew,jnew,asnew]=decide(i,j,xd(c),yd(c)); 
                handoff                                    
              end
          end
      elseif (abs(sqrt((x(c) - centerw)^2 + (y(c) - centerw)^2) - radiusw) <= 0.01)
          change = decideoverpass(x(c),y(c),xd(c),yd(c),centerw,radiusw);
          if change == 1 && rand <= 0.5 && x(c) ~= 0 && y(c) ~= 0
              blocknum = tooverpass(c,x(c),y(c),centerw,radiusw);
              handoffoverpass(c, blocknum, radiusw)
              if c ~= fc(i,j,as)
                nc(beforec) = nextc;
              end         
              fc(i,j,as) = nextc;         
              if(nextc==0)                      
                lc(i,j,as)=0;                  
              end
          else
              if(~broken(c))                          %car not broken?
                x(c)=x(c)+sign*dt*v(sign*(xpc-x(c)));   %move car c
              end
              if((x(c)*sign)>(i*sign))                
                [inew,jnew,asnew]=decide(i,j,xd(c),yd(c)); 
                handoff                                    
              end
          end
      else
          if(~broken(c))                          %car not broken?
            x(c)=x(c)+sign*dt*v(sign*(xpc-x(c)));   %move car c
          end
          if((x(c)*sign)>(i*sign))                %reached the corner?
            [inew,jnew,asnew]=decide(i,j,xd(c),yd(c)); %decide which way to go
            handoff                                    %handoff to next block
          end
          xpc=x(c);                               %current car becomes
      end
      
      if onroad(c) == 0
        beforec = nextc;
      else
        beforec = c;
      end
      c=nextc;                                %previous car
    end
  end
end