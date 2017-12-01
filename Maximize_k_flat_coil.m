function [ output_args ] = Maximize_k_flat_coil( inner_radius, n, d, distance_between_turns, wire_radius, delta, a,b )
    turns = [];
    turns_k = [];
    radii = [];
    radii_k = [];
    price = 2000;
    price_per_meter = 50;
    A = a*b;
    rho = 8.96*10^3;
    max_param = price/(2*price_per_meter*A*rho);
    max_k = 0;
    max_n = 0;
    max_r = 0;
    i = 1;
    d_for_turn = distance_between_turns+a;
    for n1 = 1:1:200
        n = [n1,n1];
        i_i = 1;    
        n1
        
        
        for r1 = 0.05:0.01:0.5
            r = [r1, r1];
            radii(i) = r1;
            
            l = pi * (n1^2*d_for_turn^2 + 2*n1*d_for_turn*r1)/(d_for_turn);
            if l <= max_param
                
                L_re1 = external_selfinductance_radii(r(1), n(1), distance_between_turns, wire_radius);
                Lr_self1 = internal_selfinductance(r(1),wire_radius,delta, n(1));
                L_r1 = L_re1 + Lr_self1;

                L_re2 = external_selfinductance_radii(r(2), n(2), distance_between_turns, wire_radius);
                Lr_self2 = internal_selfinductance(r(1),wire_radius, delta, n(2));
                L_r2 = L_re2 + Lr_self2;

                M_r = calculate_mutual_inductance_radii(r(1), distance_between_turns, n, d);
                k = M_r/sqrt((L_r1*L_r2));
                radii_k(i) = k;
                i_i=i_i+1;
            
                if k >= max_k
                    max_k = k;
                    max_n = n1;
                    max_r = r1;
                
                end
            
            end  
        
        end
        i = i + i_i;
        max_k
        max_n
        max_r
    end
    
    max_k
    max_n
    max_r




end

