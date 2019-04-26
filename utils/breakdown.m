%filename breakdown.m
if(numcars > 0)
  broken(1:numcars) = broken(1:numcars) | (rand(1,numcars) < pbreakdown * dt);
  broken(1:numcars) = broken(1:numcars) & (rand(1,numcars) > pfix * dt);
end
