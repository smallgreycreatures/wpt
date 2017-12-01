function [ weight] = weight_of_copper_coil( length, a, b, shape)

rho = 8.96*10^3;

if shape == 1 %rect
    weight = rho*a*b*length;
else if shape == 2 %cylind
    weight= rho*a*b*pi;
else
    weight = 0;
end
end

