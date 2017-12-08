function [ output_args ] = optimize_coilz( inner_radius, n, d, distance_between_turns, wire_radius, delta, a,b, R_load,f, sol_l)
    turns = [];
    turns_k = [];
    radii = [];
    radii_k = [];
    price = 1000;
    price_per_meter = 50;
    A = a*b;
    rho = 8.96*10^3;
    max_param = price/(2*price_per_meter*A*rho);
    max_eta = 0;
    max_k = 0;
    max_n = 0;
    max_r = 0;
    max_L = 0;
    max_M = 0;
    i = 1;
    d_for_turn = distance_between_turns+a;
    
    R_l1 = 0;
    R_l2 = 0;
    max_eta = 0;
    sol = 0;
    for n1 = 1:1:10
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
                R_l1 = calc_resistance_of_planar_coil(n1,a,b,r1, f);
                R_l2 = calc_resistance_of_planar_coil(n1,a,b,r1, f);
                eta = coupling_efficiency(L_r1,L_r2,M_r,R_load,f,R_l1,R_l2);
                if eta >= max_eta
                    max_k = k;
                    max_n = n1;
                    max_r = r1;
                    max_L = L_r1;
                    max_M = M_r;
                    max_eta = eta;
                    max_R_l1 = R_l1;
                    max_R_l2 = R_l2;
                    sol = 0;
                end
            
            end  
        
        end
        i = i + i_i;
        max_k
        max_n
        max_r
    end
    i = 1;
        for n1 = 1:1:10
        n = [n1,n1];
        i_i = 1;    
        n1
        
        
        for r1 = 0.05:0.01:0.5
            r = [r1, r1];
            radii(i) = r1;
            
            l = pi * (n1^2*d_for_turn^2 + 2*n1*d_for_turn*r1)/(d_for_turn);
            if l <= max_param
                
            M = calculate_mutual_inductance(r,sol_l,n,d);

            Le1 = external_selfinductance(r(1),sol_l(1),n(1), wire_radius);
            Le1_self = internal_selfinductance(r(1),wire_radius,delta,n(1));
            L1 = Le1 + Le1_self;

            Le2 = external_selfinductance(r(2),sol_l(2),n(2), wire_radius);       
            Le2_self = internal_selfinductance(r(1),wire_radius, delta,n(2));
            L2 = Le2 + Le2_self;
            k_self = M/sqrt((L2*L2));
                radii_k(i) = k;
                i_i=i_i+1;
                R_l1 = calc_resistance_of_planar_coil(n1,a,b,r1, f);
                R_l2 = calc_resistance_of_planar_coil(n1,a,b,r1, f);
                eta = coupling_efficiency(L1,L2,M,R_load,f,R_l1,R_l2);
                if eta >= max_eta
                    max_k = k;
                    max_n = n1;
                    max_r = r1;
                    max_L = L_r1;
                    max_M = M_r;
                    max_eta = eta;
                    max_R_l1 = R_l1;
                    max_R_l2 = R_l2;
                    sol = 1;
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
    max_M
    max_L
    max_eta
    max_R_l1
    max_R_l2
    sol

end

