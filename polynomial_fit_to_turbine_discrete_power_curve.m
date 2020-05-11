%% polynomial_fit_to_turbine_discrete_power_curve.m
% PL 24.08.2012
% Use to fit a polynomial function (typically 6th order) to the variable section of a wind turbine power curve.
% The power curve should be specified by two vectors of values: wind speeds and powers.
%
% The return variable can be used to convert a time series of wind speeds to wind power
% Note that the polynomial should only be fitted to the3 variable section of the curve 
% 	-- use the vlower and vupper arguments to limit the fit range.
% Outside of this range, the power should be set to the correct values (zero or rated power for the particular turbine)
%
%% Usage example: (based on Vestas V90)
% P = [0 77 190 353 581 886 1273 1710 2145 2544 2837 2965 2995 3000 3000 3000 3000 3000 3000 3000 3000 3000 3000] ; % power, kW
% v =3:25;						% wind speed m/s
% fit_coeffs=polynomial_fit_to_turbine_discrete_power_curve(v, P, 4, 14);
% turbinepower=polyval(fit_coeffs,windspeeds);		% calculate the wind power for every value of wind speed in the time series "windspeeds"
% turbinepower(find(windspeeds<4))=0;			% below cut-in
% turbinepower(find(windspeeds>14))=3000;		% rated wind speed
% turbinepower(find(windspeeds>25))==0; 		% cut-out wind speed

%%
function fit_coeffs = polynomial_fit_to_turbine_discrete_power_curve(v,p,vlower,vupper)

poly_degree=6;% 6th order polynomial

%% error checking (1) : v,p must have same size
if numel(v) ~= numel(p) 
    error('input arguments v,p (velocity, power) must have same dimensions');
end

%% range for fitting is between lower and upper speed 
fit_range=intersect(find(v>=vlower),find(v<vupper));


%% error checking (2) : sufficient points to fit polynomial?
if (numel(fit_range) <= poly_degree)
    error('Insufficient points in range to fit polynomial.');
end

%% perform the polynomial fit
fit_coeffs=polyfit(v(fit_range),p(fit_range),poly_degree); 
