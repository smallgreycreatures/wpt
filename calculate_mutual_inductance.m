function [M_E] = calculate_mutual_inductance(radii, len, turns, distance_between_coils)
%calculates mutual inductance between two solenoids with air core

r = radii;
mu0 = 4*pi*10^(-7);
phi_limits = [2*pi 0]; %limits for the integral
M = 0;
M_E = 0; %value for elliptic integral
K = 0; %first order elliptic integral
E = 0; %second order elliptic integral

%For each z' we iterate over all z coils and changes the distance dependent
%on N/len
for zprim = (0: len(1)/(turns(1)-1): len(1))
    for z = (len(1)+distance_between_coils: len(2)/(turns(2)-1): len(1)+distance_between_coils+len(2))
%if ~(abs(z - zprim) < 0.0003)
        k_M = (2*sqrt(r(1)*r(2)))/(sqrt((r(1)+r(2))^2 + (z-zprim)^2));
        
        [K,E] = ellipke(k_M^2); %solve elliptic integral
         M_E = M_E - mu0*sqrt(r(1)*r(2))*((k_M - 2/k_M)*K + 2/k_M*E);
        
        
        %integrand = @(phi, phiprim) mu0*prod(radii)/(4*pi)*cos(phi-phiprim)./sqrt(radii(1)^2+radii(2)^2+(z-zprim)^2+-2*prod(radii).*cos(phi-phiprim));
        %z
        %zprim
       % M = M + integral2(integrand, phi_limits(1), phi_limits(2), phi_limits(1), phi_limits(2));
        
        %end
    end
end
