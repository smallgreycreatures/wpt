function [ output_args ] = plot_radii_solenoid(r,l,n,d,wire_radius,delta )
radii_for_plot = [];
values_for_radii_plot = [];
i = 1;

for r1 = 0.05:0.01:0.5
    r = [r1, r1];
    radii_for_plot(i) = r1;
    
    M = calculate_mutual_inductance(r,l,n,d);
    Le1 = external_selfinductance(r(1),l(1),n(1), wire_radius);
    Le1_self = internal_selfinductance(r(1),wire_radius,delta, n(1));   
    L1 = Le1 + Le1_self;

    Le2 = external_selfinductance(r(2),l(2),n(2), wire_radius);       
    Le2_self = internal_selfinductance(r(1),wire_radius, delta, n(2));
    L2 = Le2 + Le2_self;
    k_self = M/sqrt((L2*L2));
    values_for_radii_plot(i) = k_self;
    i=i+1;
end

scatter(radii_for_plot, values_for_radii_plot);
xlabel('radii [m]') % x-axis label
ylabel('coupling coefficient k') % y-axis label

end

