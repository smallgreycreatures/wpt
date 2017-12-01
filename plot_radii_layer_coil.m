function [ regression_function ] = plot_radii_layer_coil(r, n, d, distance_between_turns, wire_radius, delta)
radii_for_plot = [];
values_for_radii_plot = [];
i = 1;

    for r1 = 0.05:0.01:0.5
        r = [r1, r1];
        radii_for_plot(i) = r1;
    

        L_re1 = external_selfinductance_radii(r(1), n(1), distance_between_turns, wire_radius);
        Lr_self1 = internal_selfinductance(r(1),wire_radius,delta, n(1));
        L_r1 = L_re1 + Lr_self1;

        L_re2 = external_selfinductance_radii(r(2), n(2), distance_between_turns, wire_radius);
        Lr_self2 = internal_selfinductance(r(1),wire_radius, delta, n(2));
        L_r2 = L_re2 + Lr_self2;

        M_r = calculate_mutual_inductance_radii(r(1), distance_between_turns, n, d);
        k = M_r/sqrt((L_r1*L_r2));
        values_for_radii_plot(i) = k;
        i=i+1;
    end

%    scatter(radii_for_plot, values_for_radii_plot);

    f = fit(radii_for_plot.', values_for_radii_plot.', 'poly3');
    plot(f, radii_for_plot, values_for_radii_plot);
    xlabel('radii [m]') % x-axis label
    ylabel('coupling factor') % y-axis label
    regression_function = f;
    
end

