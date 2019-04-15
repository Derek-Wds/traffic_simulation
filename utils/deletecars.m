for j=2:(J-1)                              %interior streets
  for i=(2:I)*odd(j)+(1:(I-1))*even(j)     %all blocks
    c=fc(i,j,2);                           %first car in block
    pc=0;                                  %previous car
    while(c~=0)                            %while any cars are left
      if((j==yd(c)) & (abs(x(c)-xd(c))<eps)) %close to destination?
        if(pc==0)                           %first car?
          fc(i,j,2)=nc(c);                   %delete first car
        else                                %otherwise
          nc(pc)=nc(c);                      %delete car c
        end
        if(c==lc(i,j,2))                    %last car?
          lc(i,j,2)=pc;                      %previous car becomes last car
        end
        onroad(c)=0;                        %mark car as no longer on road   
        numcarsout=numcarsout-1;            %decrement number of cars out
      else
        pc=c;                              %update previous car
      end
      c=nc(c);                             %update current car
    end  
  end
end