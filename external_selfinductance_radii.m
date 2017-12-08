function [ L_E ] = external_selfinductance_radii(initial_radius, turns, distance_between_turns, wire_radius)

mu0= 4*pi*10^-7;

L = 0;
L_E = 0;
K = 0;
E = 0;
dx = 0.7780*wire_radius;
for r_prime = (initial_radius:distance_between_turns:initial_radius + (turns-1)*distance_between_turns)

    for r = (initial_radius + dx:distance_between_turns:initial_radius + dx + (turns-1)*distance_between_turns)
        %if r==r_prime %singular point handled as instructed in Elektricitetsl�ra by Hall�n 1953
            
         %   L_first = mu0*r*(log((8*r)/(r+(2*wire_radius))) -2);
          %  L_E = L_E + L_first;
       % else %Determine induction by the maxwell method
            k_M = (2*sqrt(r*r_prime))/(sqrt((r+r_prime)^2));
            
            [K,E] = ellipke(k_M^2); %solve elliptic integral
            L_E = L_E - mu0*sqrt(r*r_prime)*((k_M - 2/k_M)*K + 2/k_M*E);
        %end
    %if (~zprim==z) 
    
        %integrand = @(phi, phiprim) mu0*radius^2/(4*pi)*cos(phi-phiprim)./sqrt(radius^2+radius^2+(z-zprim)^2+-2*radius^2.*cos(phi-phiprim));

       % L = L + integral2(integrand, phi_limits(1), phi_limits(2), phi_limits(1), phi_limits(2));
        
        %end
    end

end

%{
for zprim = (0:length/(turns-1):length)

    for z = (0.0003:length/(turns-1):(length+0.0003))
        
        k_M = (2*sqrt(radius*radius))/(sqrt((radius+radius)^2 + (z-zprim)^2));
        
        [K,E] = ellipke(k_M^2); %solve elliptic integral
         L_E = L_E - mu0*sqrt(radius*radius)*((k_M - 2/k_M)*K + 2/k_M*E);
        
    %if (~zprim==z) 
    
        %integrand = @(phi, phiprim) mu0*radius^2/(4*pi)*cos(phi-phiprim)./sqrt(radius^2+radius^2+(z-zprim)^2+-2*radius^2.*cos(phi-phiprim));

       % L = L + integral2(integrand, phi_limits(1), phi_limits(2), phi_limits(1), phi_limits(2));
        
        %end
    end

end

 %}




