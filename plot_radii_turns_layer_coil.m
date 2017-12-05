function [ regression_function ] = plot_radii_turns_layer_coil( r, n, d, distance_between_turns, wire_radius, delta )
    turns_for_plot = [];
    radii_for_plot = [];
    values_for_turns_plot = [];
    i = 1;
    for n1 = 1:1:100
        n = [n1, n1];
        turns_for_plot(i) = n1;
        radii_for_plot(i) = r(1) + n1*(distance_between_turns+(wire_radius*2));
        L_re1 = external_selfinductance_radii(r(1), n(1), distance_between_turns, wire_radius);
        Lr_self1 = internal_selfinductance(r(1),wire_radius,delta, n(1));
        L_r1 = L_re1 + Lr_self1;

        L_re2 = external_selfinductance_radii(r(2), n(2), distance_between_turns, wire_radius);
        Lr_self2 = internal_selfinductance(r(1),wire_radius, delta, n(2));
        L_r2 = L_re2 + Lr_self2;

        M_r = calculate_mutual_inductance_radii(r(1), distance_between_turns, n, d);
        k = M_r/sqrt((L_r1*L_r2));
        values_for_turns_plot(i) = k;
        i=i+1;
    end

    %scatter(turns_for_plot, values_for_turns_plot);

    f = fit(radii_for_plot.', values_for_turns_plot.', 'poly3');
    %plot(f, radii_for_plot, values_for_turns_plot);
    %xlabel('radii n') % x-axis label
    %ylabel('coupling factor') % y-axis label
    regression_function = f;
end


