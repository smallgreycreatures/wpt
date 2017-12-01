function [ output_args ] = plot_turns_solenoid_and_layer_coil(r, n, d, distance_between_turns, wire_radius, delta,l)
    turns_for_plot = [];
    values_for_turns_plot_layer = [];
    values_for_turns_plot_solenoid = [];
    i = 1;
    for n1 = 1:1:100
        n = [n1, n1];
        turns_for_plot(i) = n1;
    
        L_re1 = external_selfinductance_radii(r(1), n(1), distance_between_turns, wire_radius);
        Lr_self1 = internal_selfinductance(r(1),wire_radius,delta, n);
        L_r1 = L_re1 + Lr_self1(1);

        L_re2 = external_selfinductance_radii(r(2), n(2), distance_between_turns, wire_radius);
        Lr_self2 = internal_selfinductance(r(1),wire_radius, delta, n);
        L_r2 = L_re2 + Lr_self2(1);

        M_r = calculate_mutual_inductance_radii(r(1), distance_between_turns, n, d);
        k = M_r/sqrt((L_r1*L_r2));
        values_for_turns_plot_layer(i) = k;

        M = calculate_mutual_inductance(r,l,n,d);
        Le1 = external_selfinductance(r(1),l(1),n(1), wire_radius);
        Le1_self = internal_selfinductance(r(1),wire_radius,delta, n);   
        L1 = Le1 + Le1_self(1);

        Le2 = external_selfinductance(r(2),l(2),n(2), wire_radius);       
        Le2_self = internal_selfinductance(r(1),wire_radius, delta, n);
        L2 = Le2 + Le2_self(1);
    
        k_self = M/sqrt((L2*L2));
        values_for_turns_plot_solenoid(i) = k_self;
        i=i+1;
    end
    z = turns_for_plot;
    x = values_for_turns_plot_solenoid;
    y = values_for_turns_plot_layer;
    scatter3(x, y, z);    
    xlabel('turns n') % x-axis label
    ylabel('coupling factor') % y-axis label


end

