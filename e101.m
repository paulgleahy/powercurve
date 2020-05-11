%% e101.m
% Cp versus wind speed of Enercon E101 turbine
% PL 21.04.2016
%% values taken from published curve at http://www.enercon.de/en/products/ep-3/e-101/ 
v=0:30;
Cp=zeros(size(v));
Cp=         [0 ...
            0 0 0.08 0.28 0.38 ... 
            0.44 0.46 0.47 0.47 0.47 ...
            0.44 0.36 0.28 0.22 0.18 ...
            0.15 0.12 0.11 0.08 0.07 ...
            0.06 0.06 0.05 0.05 0.05 ...
            0 0 0 0 0];
 % now find corresponding axial induction factor values based on roots of
 % equation: Cp=4a(1-a)^2     => 4a3 -8a2 + 4a -Cp = 0
 a=zeros(size(v));
 for ir=4:25 % range where Cp is nonzero
     p=[4 -8 4 -Cp(ir)];
     r=roots(p);
     a(ir)=r(3);
 end
        
            
 
        