function [ output_args ] = plot_turns_solenoid( r,l,n,d,wire_radius,delta  )
turns_for_plot = [];
values_for_turn_plot = [];
i = 1;

for n1 = 1:1:30
    n = [n1, n1];
    turns_for_plot(i) = n1;
    
    M = calculate_mutual_inductance(r,l,n,d);
    Le1 = external_selfinductance(r(1),l(1),n(1), wire_radius);
    Le1_self = internal_selfinductance(r(1),wire_radius,delta, n(1));   
    L1 = Le1 + Le1_self;

    Le2 = external_selfinductance(r(2),l(2),n(2), wire_radius);       
    Le2_self = internal_selfinductance(r(1),wire_radius, delta, n(2));
    L2 = Le2 + Le2_self;
    
    k_self = M/sqrt((L2*L2));
    values_for_turns_plot(i) = k_self;
    i=i+1;
end

scatter(turns_for_plot, values_for_turns_plot);
xlabel('varv n') % x-axis label
ylabel('kopplingsfaktor k') % y-axis label


end

