tt = mod(t,TLP); %time in since lights turned green on avenues (red on streets)
if(tt<TLA)
  L(:,:,1) = 1;  %green on avenues
  L(:,:,2) = 0;  %  red on streets
else
  L(:,:,1) = 0;  %  red on avenues
  L(:,:,2) = 1;  %green on streets
end