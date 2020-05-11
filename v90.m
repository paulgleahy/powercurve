% v90.m
% PL 21.03.2011
% Define and fit the Vestas V90 power curve to supplied datasheet
% see: Class 1 Item no. 950010.R1 2004-03-02 General Specification V90 –
%   3.0 MW 60 Hz Variable Speed Turbine
% 
% Selected power curve: 
% air density = 1.225 kg m-3
% noise  = 107.8 dBA
% Calculated at 1000V / 400V, low voltage side of the medium voltage
% transformer.

function turbine=v90();
%% data sheet values
P = [0 77 190 353 581 886 1273 1710 2145 2544 2837 2965 2995 3000 3000 3000 3000 3000 3000 3000 3000 3000 3000] ;
v =3:25;
Prated=max(P);
% (rated power @ 16 m-s)

%% interpolate (0.1 ms-1)
% 6-degree polynomial for variable part
[p,S] = polyfit(v(1:14),P(1:14),6);
Pfit=polyval(p,v);

%% assemble the new curve from zero, variable, rated and zero regions
vvar= v(1):0.1:v(14);
Pvar=polyval(p,vvar);

turbine.v=[0:2 vvar v(15:end) 0.1+(v(end):(v(end)+5))];
turbine.P=[zeros(1,3) , Pvar, P(15:end), zeros(1,6)];
turbine.name='V90';
turbine.Prated=Prated;

%% plotting (remove later)
% clf;
% plot(v,P,'k-s');hold on; plot(vnew,Pnew,'r-s');ylim([0 3100]);
