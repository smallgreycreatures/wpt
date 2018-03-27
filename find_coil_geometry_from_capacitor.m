function [ radius, n ] = find_coil_geometry_from_capacitor( inner_radius, n, d, distance_between_turns, wire_radius, delta, a,b, R_load,f, C)
    
    w = 2*pi*f;
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
    max_R_load = 0;
    max_im_part = 1000;
    i = 1;
    d_for_turn = distance_between_turns+a;
    
    R_l1 = 0;
    R_l2 = 0;
    max_eta = 0;
    sol = 0;
    for n1 = 1:1:20
        n = [n1,n1];
        i_i = 1;    
        n1
        
        
        for r1 = 0.2:0.01:0.22
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
                %for R_load = 1:1:100
                R_load = 27.7028;
                eta = coupling_efficiency3(L_r1,L_r2,M_r,R_load,f,R_l1,R_l2,C);
                
                
                z2 = j*w*M_r;
                %z3eq = j*w*(L_r2-M_r) + R_l2 + 1/(j*w*C) + R_load;
                %z2eq = (z2*z3eq)/(z3eq+z2);
                L = 1/(w^2*C);
                
                %im_part = imag(z2eq);
                
                if abs(L-L_r2) <  max_im_part
                    max_k = k;
                    max_n = n1;
                    max_r = r1;
                    max_L = L_r1;
                    max_M = M_r;
                    max_eta = eta;
                    max_R_l1 = R_l1;
                    max_R_l2 = R_l2;
                    sol = 0;
                    max_R_load = R_load;
                    max_im_part = abs(L-L_r2);
                %end
                end
            end  
        
        end
        i = i + i_i;
        max_k
        max_n
        max_r
    end
    radius = max_r
    n = max_n
    max_im_part
    max_eta
    max_L
    max_M
end

