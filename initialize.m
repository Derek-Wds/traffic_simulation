addpath('utils')

global dmin dmax v0 vmax;
global I J;
global centern radiusn;
global centerz radiusz;
global centerw radiusw;
 
I = 22;                         %number of avenues (must be even)
J = 22;                         %number of streets (must be even)
centern = 11;                   %center for inner loop
radiusn = 3;                    %radius for inner loop
centerz = 11;                   %center for middle loop
radiusz = 6;                    %radius for middle loop
centerw = 11;                   %center for outter loop
radiusw = 9;                    %radius for outter loop
pcreate = 0.3;                  %creation rate per block per unit time
pbreakdown = 0.01 ;             %breakdown rate per car per unit time
pfix = 0.1;                     %repair rate per broken car per unit time
dt = .1  ;                      %time step duration
dmin = .05;                     %distance below which v=0    (in units of blocks)
dmax = .5;                      %distance above which v=vmax (in units of blocks)
vmax = 1;                       %maximum speed of cars (since the unit of time 
                                %is the time it takes a car to go one block 
                                %at maximum speed)
numcarsmax = 1000;              %maximum number of cars       
TLP = 3;                        %period of the traffic light cycle
TLA = 2;                        %duration of green on avenues in each cycle

v0 = vmax/log(dmax/dmin);       %v=v0*log(d/dmin), d=distance to car ahead
eps = dt*vmax;                  %tolerance for finding destination 
epsl = 0.05  ;                  %distance of lights (as plotted) from corner

cstr = ['r+';'g+'];             %color string for plotting lights  

%set range of random destinations
%default values are xdmin=1, xdmax=I, jdmin=2, jdmax=J-1
xdmin = 1;
xdmax = I;
jdmin = 2;
jdmax = J-1;

fc = zeros(I,J,2);
lc = zeros(I,J,2);
L = zeros(I,J,2);
nc = zeros(1,numcarsmax);
x = zeros(1,numcarsmax);
y = zeros(1,numcarsmax);
xd = zeros(1,numcarsmax);
yd = zeros(1,numcarsmax);
onroad = zeros(1,numcarsmax);
broken = zeros(1,numcarsmax);



xpl = [1 I];
XPL = (1:I)'*[1 1];
ypl = [1 J];
YPL = (1:J)'*[1 1];

cblocked = zeros(I,J);
