cblocked(i,j)=c;   %note that corner is blocked, 
                   %and which car is blocking it

%If the transfer involves a turn, put car right at the corner:
if((as==1)&(asnew==2))             %avenue to street?
  y(c)=j;                          %make y-coordinate that of the street
end
if((as==2)&(asnew==1))             %street to avenue?
  x(c)=i;                          %make x-coordinate that of the avenue
end

%Append car to the linked-list data structure of the new block:
if(lc(inew,jnew,asnew)~=0)         %new block not empty?
  nc(lc(inew,jnew,asnew))=c;        %car c is next after old last car
else                               %otherwise new block was empty, so
  fc(inew,jnew,asnew)=c;            %car c is first on its new block
end                                %in either case,
lc(inew,jnew,asnew)=c;             %car c is last on its new block, and
nc(c)=0;                           %there is no next car after car c

%Remove car c from the linked list of its old block:
fc(i,j,as)=nextc;                  %car behind car c becomes the first car
if(nextc==0)                       %no car behind car c ?
  lc(i,j,as)=0;                     %note that the block is then empty
end
