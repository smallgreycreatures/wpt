function [L] = internal_selfinductance(radius, thickness, delta)

integrand = @(r) (thickness^2-(r-delta).^2)/2 + 2*delta.*(r-delta-thickness)+delta^2*log(thickness./(r-delta))*2.*(thickness-r)/((thickness-delta)^2);

L_self = 2*pi*radius*integral(integrand,delta,thickness);

L = L_self;

end