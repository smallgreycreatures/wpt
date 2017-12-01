function [L_self] = internal_selfinductance(radius, thickness, delta, turns)

%integrand = @(r) (thickness^2-(r-delta).^2)/2 + 2*delta.*(r-delta-thickness)+delta^2*log(thickness./(r-delta))*2.*(thickness-r)/((thickness-delta)^2);
mu = 1.256629*10^(-6);
mu0 = 4*pi*10^(-7);

%L_self = 2*pi*radius*integral(integrand,delta,thickness);
l = turns*2*pi*radius;
L_self = l*mu/(8*pi);

end