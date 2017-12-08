function [ R ] = calc_resistance_of_planar_coil( n, a, b,inner_radius, f )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
d = a+b;
s = a*b;
l = pi*(n^2*d^2 + 2*n*d*inner_radius)/d;

resistivity = 1.68*10^(-8);
conductivity = 5.96*10^7;
mu_0 = 4*pi*10^(-7);

%DC resistance
R_dc = resistivity*l/s;

%Skin effect resistance
skin_depth = sqrt(1/(pi*f*mu_0*conductivity));
R_s = l/(skin_depth*conductivity*(2*a + 2*b -4*skin_depth));

R = R_dc+R_s;

end

