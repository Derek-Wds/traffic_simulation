function [inew,jnew,asnew] = decide(i,j,xd,yd)
global I J;

%Given a car at corner (i,j) with destination (xd,yd),
%this function decides which way the car should go.
%There are only two choices, since all streets and avenues are one-way.
%Let  ua  and  us  be the unit vectors of the two possible directions,
% ua  being along the avenue and  us  being along the street.
%Note that  ua= +- (0,1)  and  us= +- (1,0).
%Let  u=(xd-i,yd-j)=vector from current location to destination.
%Then the direction chosen by this routine is  
%       ua  if  u.ua > u.us, and
%       us  otherwise
%where "." denotes the usual dot product of two vectors.

%First consider special cases in which there is only one way to go
%(but note that corners of the grid will take care of themselves,
% since the destination is within the grid):

if((i == 1) & (even(j)))
  asnew = 1;
  inew = 1;
  jnew = j - 1;
elseif((i == I) & (odd(j)))
  asnew = 1;
  inew = I;
  jnew = j + 1;
elseif((j == 1) & (odd(i)))
  asnew = 2;
  jnew = 1;
  inew = i + 1;
elseif((j==J) & (even(i)))
  asnew = 2;
  jnew = J;
  inew = i - 1;



%Now consider typical cases, in which there are two choices:

else
  signi=even(i) - odd(i); %direction of traffic flow on avenue i
  signj=odd(j) - even(j); %direction of traffic flow on street j
  s=(xd-i) * signj;       %s=u.us
  a=(yd-j) * signi;       %a=u.ua
  if i < 9 | i > 13
      if(a > s)               %u.us > u.ua ?
        asnew = 1;             %choose avenue
        inew = i;              %avenue remains that of corner where choice was made
        jnew = j + signi;        %street index of next light will be 
                             %current street index +-1, depending on the
                             %direction of traffic flow on the avenue (signi)
      else
        asnew = 2;             %choose street
        jnew = j;              %street remains that of corner where choice was made
        inew = i + signj;        %avenue index of next light will be
                             %current avenue index +-1, depending on the
                             %direction of traffic flow on the street (signj)
      end
  else
      asnew = 2;
      jnew = j;
      inew = i + signj;
  end
end
