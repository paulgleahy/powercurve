%% polynomial_fit_to_turbine_discrete_power_curve.m
% PL 24.08.2012
function fit_coeffs = polynomial_fit_to_turbine_discrete_power_curve(v,p,vcutin,vcutout)

poly_degree=6;% 6th order polynomial

%% error checking (1) : v,p must have same size
if numel(v) ~= numel(p) 
    error('input arguments v,p (velocity, power) must have same dimensions');
end

%% range for fitting is between cut-in and cut-out speed
fit_range=intersect(find(v>=vcutin),find(v<vcutout));


%% error checking (2) : sufficient points to fit polynomial?
if (numel(fit_range) <= poly_degree)
    error('Insufficient points in range to fit polynomial.');
end

%% perform the polynomial fit
fit_coeffs=polyfit(v(fit_range),p(fit_range),poly_degree); 
