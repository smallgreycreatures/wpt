function [M_E] = calculate_mutual_inductance_radii(initial_radius, distance_between_turns, turns, distance_between_coils_z)
%calculates mutual inductance between two solenoids with air core


mu0 = 4*pi*10^(-7);
M = 0;
M_E = 0; %value for elliptic integral
K = 0; %first order elliptic integral
E = 0; %second order elliptic integral

%For each r' we iterate over all coils abs(r+z) away and changes the distance dependent
%on the winding
for r_prime = (initial_radius: distance_between_turns: initial_radius+((turns(1)-1)*distance_between_turns))
    for r = (initial_radius: distance_between_turns: initial_radius+ ((turns(2)-1)*distance_between_turns))

        k_M = (2*sqrt(r_prime*r))/(sqrt((r+r_prime)^2 + (distance_between_coils_z)^2));
        
        [K,E] = ellipke(k_M^2); %solve elliptic integral
        M_E = M_E - mu0*sqrt(r*r_prime)*((k_M - 2/k_M)*K + 2/k_M*E);
        
        
    end
end


