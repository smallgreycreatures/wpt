function [L_E] = external_selfinductance(radius, length, turns)

mu0= 4*pi*10^-7;

phi_limits = [2*pi 0];

L = 0;
L_E = 0;
K = 0;
E = 0;
for zprim = (0:length/(turns-1):length)

    for z = (0.003:length/(turns-1):(length+0.003))
        
        k_M = (2*sqrt(radius*radius))/(sqrt((radius+radius)^2 + (z-zprim)^2));
        
        [K,E] = ellipke(k_M^2); %solve elliptic integral
         L_E = L_E - mu0*sqrt(radius*radius)*((k_M - 2/k_M)*K + 2/k_M*E);
        
    %if (~zprim==z) 
    
        %integrand = @(phi, phiprim) mu0*radius^2/(4*pi)*cos(phi-phiprim)./sqrt(radius^2+radius^2+(z-zprim)^2+-2*radius^2.*cos(phi-phiprim));

       % L = L + integral2(integrand, phi_limits(1), phi_limits(2), phi_limits(1), phi_limits(2));
        
        %end
    end

end

 

 


