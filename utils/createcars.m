% filename: createcars.m
% This script creates at most one new car per block, and inserts
% that car into the linked-list data structure of its block.  
% Cars are created at random 
% with probability  pcreate  per unit length per unit time.
% Cars can only be created on streets (not avenues), 
% and only on interior streets (j = 2...(J-1)).
% At time of creation, cars are assigned a destination,
% which must also be on an interior street.

for j = 2:(J-1)                                  %interior streets
  sign = odd(j) - even(j);                         %direction of traffic
  for i = (2:I) * odd(j) + (1:(I-1)) * even(j)         %all blocks on street
  % all x should be out of 9-13 for not create at tunnels
  % i is the block end; no use between 9 and 13.
   if (i < 9) | (i > 13)
        if(rand < pcreate * dt)                        %create car in block?
          numcars = numcars + 1;                       %update total number of cars
          if(numcars == numcarsmax)                  %is this car the last?
            pcreate = 0;                              %prevent future car creation
          end
          x(numcars) = i - rand * sign;                  %origin (x)
          y(numcars) = j;                            %origin (y)
          xd(numcars) = xdmin + (xdmax - xdmin) * rand;              %destination (x)
          yd(numcars) = jdmin + floor(rand * (jdmax + 1 - jdmin));     %destination (y)
          if xd(numcars) > 8 & xd(numcars) < 14
              xd(numcars)  =  xd(numcars) + 6;
          end
          onroad(numcars) = 1;                       %mark car as out on road
          numcarsout = numcarsout+1;                 %increment number of cars out

          if(fc(i,j,2) == 0)                         %empty block?
            fc(i,j,2) = numcars;                      %new car is first on block
            lc(i,j,2) = numcars;                      %new car is last on block
            nc(numcars) = 0;                          %no car is next after new car

          elseif((x(numcars) * sign) > (x(fc(i,j,2)) * sign)) 
                                                   %new car is first on block?
              nc(numcars) = fc(i,j,2);                  %old first car is next
            fc(i,j,2) = numcars;                      %update first-car pointer

          elseif((x(numcars) * sign)  < (x(lc(i,j,2)) * sign)) 
                                                   %new car is last on block?
            nc(lc(i,j,2)) = numcars;                  %old last car is next to last
            lc(i,j,2) = numcars;                      %new car is last on block
            nc(numcars) = 0;                          %no car is next after new car

          else                                   %new car not first or last:
            pc = fc(i,j,2);                           %previous car  =  first car
            c = nc(pc);                               %current car = next car
            while(c ~= 0)                             %search where to insert new car
              if((x(numcars) * sign) > (x(c) * sign))     %found where to insert new car?
                nc(pc) = numcars;                     %insert new car after car pc
                nc(numcars) = c;                      %insert new car before car c
                break                               %leave "while" loop
              else
                pc = c;                               %update previous car
                c = nc(c);                            %update current car
              end
            end
          end
        end
    end
  end
end




