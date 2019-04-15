as=1;                                         %consider cars on avenues
for i=1:I                                     %all avenues
  sign=even(i)-odd(i);                        %direction of traffic flow
  for j=((J:(-1):2)*even(i)+(1:(J-1))*odd(i)) %blocks on avenue i
    
    %ypc = y-coordinate of the car ahead of the first car on the block.
    %If the block ahead is empty, or if there is no such block,
    %ypc is set  dmax  ahead of the first car, 
    %so the first car can proceed at maximum speed.
    %If the traffic light is red, however, it is treated as the car ahead,
    %so ypc is set equal to the y-coordinate of the (red) light.
    if((L(i,j,as)==0)|cblocked(i,j))    %red light (or blocked intersection)?
      ypc=j;                                   %"previous car" = traffic light
    elseif((1<j)&(j<J))                       %interior block?
      if(lc(i,j+sign,as)~=0)                    %next block not empty?
        ypc=y(lc(i,j+sign,as));                  %previous car is 
      end                                       %the last car on next block
    else                                      %otherwise
      ypc=j+sign*dmax;                         %first car can proceed
    end                                        %at maximum speed

    c=fc(i,j,as);                             %c=first car on block
    while(c~=0)                               %consider all cars on block
      nextc=nc(c);                            %note next car
      if(~broken(c))                          %car not broken?
        y(c)=y(c)+sign*dt*v(sign*(ypc-y(c)));   %move car c
      end
      if((y(c)*sign)>(j*sign))                %reached the corner?
        [inew,jnew,asnew]=decide(i,j,xd(c),yd(c)); %decide which way to go
        handoff                                    %handoff to next block
      end
      ypc=y(c);                               %current car becomes
      c=nextc;                                %previous car
    end
  end
end