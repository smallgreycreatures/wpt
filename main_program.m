mu0 = 4*pi*10^(-7);
r = [0.2, 0.2]; %radi of one loop 
l = [0.1, 0.1]; %l�ngd p� solenoid
d = 0.2; %distance in z
n = [10, 10]; % num of laps
z = 0; 
zprim = 0.2;
k = 0;
r_res =0;
l_res = 0;
n_res = 0;
f = 200*10^3; %frequency [Hz]
wire_radius = 0.003;
distance_between_turns = 0.002;
conductivity = 5.96*10^7;
delta=1/sqrt(pi*f*conductivity*mu0);
R_load = 27.7028;
R_L = 0.074;
%{
tic
M = calculate_mutual_inductance(r,l,n,d)
Le1 = external_selfinductance(r(1),l(1),n(1), wire_radius)
Le1_self = internal_selfinductance(r(1),wire_radius,delta, n(1))
L1 = Le1 + Le1_self;
%L_wheeler = (10*pi*mu0*n(1)^2*r(1)^2)/(9*r(1)+10*l(1))
Le2 = external_selfinductance(r(2),l(2),n(2), wire_radius)       
Le2_self = internal_selfinductance(r(1),wire_radius, delta, n(2))
L2 = Le2 + Le2_self;
%L = mu0*n(1)^2*r(1)^2*pi/l(1)
k_self = M/sqrt((L2*L2))
k = M/sqrt((Le1*Le2));
toc
%}
%{
figure
subplot(2,2,1)
plot_turns_solenoid(r,l,n,d,wire_radius,delta);
title(['solenoid med r = ',num2str(r(1)),' m, l = ', num2str(l(1)), ' m, d = ', num2str(d), ' m'])
%figure();
subplot(2,2,2)
plot_radii_solenoid(r,l,n,d,wire_radius,delta);
title(['solenoid med n = ',num2str(n(1)),' m, l = ', num2str(l(1)), ' m, d = ', num2str(d), ' m'])
%figure()

L_re1 = external_selfinductance_radii(r(1), n(1), distance_between_turns, wire_radius)
Lr_self1 = internal_selfinductance(r(1),wire_radius,delta, n(1))
L_r1 = L_re1 + Lr_self1;

L_re2 = external_selfinductance_radii(r(2), n(2), distance_between_turns, wire_radius)
Lr_self2 = internal_selfinductance(r(1),wire_radius, delta, n(2))
L_r2 = L_re2 + Lr_self2;

M_r = calculate_mutual_inductance_radii(r(1), distance_between_turns, n, d)
k = M_r/sqrt((L_r1*L_r2))

%check distance

for d = 0.1:0.03:0.3
d
L_re1 = external_selfinductance_radii(r(1), n(1), distance_between_turns, wire_radius);
Lr_self1 = internal_selfinductance(r(1),wire_radius,delta, n(1));
L_r1 = L_re1 + Lr_self1;

L_re2 = external_selfinductance_radii(r(2), n(2), distance_between_turns, wire_radius);
Lr_self2 = internal_selfinductance(r(1),wire_radius, delta, n(2));
L_r2 = L_re2 + Lr_self2;

M_r = calculate_mutual_inductance_radii(r(1), distance_between_turns, n, d);
k = M_r/sqrt((L_r1*L_r2))
coupling_efficiency2(L_r1, L_r2, M_r, R_load,f,R_L, R_L)
coupling_efficiency3(L_r1, L_r2, M_r, R_load,f,R_L, R_L,6.1303*10^-9)
end



subplot(2,2,3)
f_rad = plot_radii_layer_coil(r,n,d,distance_between_turns, wire_radius, delta)
title(['plattspole med n = ', num2str(n(1)), ' , d = ', num2str(d), ' m'])
%figure();
subplot(2,2,4)
f_turns = plot_turns_layer_coil(r,n,d,distance_between_turns, wire_radius, delta)
title(['plattspole med r = ', num2str(r(1)), ' , d = ', num2str(d), ' m'])
%figure();
f_radii_turns = plot_radii_turns_layer_coil(r,n,d,distance_between_turns, wire_radius, delta)

points = [0.3];
fx_radii = differentiate(f_rad, points)
fx_radii_turns = differentiate(f_radii_turns, points)

%plot_turns_solenoid_and_layer_coil(r,n,d,distance_between_turns,wire_radius,delta,l);
%}
%Maximize_k_flat_coil(r(1),n,d,distance_between_turns, wire_radius,delta,0.002,0.004);
optimize_coilz(r(1),n,d,distance_between_turns, wire_radius,delta,0.002,0.004, 10, 200*10^3, l);
%find_coil_geometry_from_capacitor(r(1),n,d,distance_between_turns, wire_radius,delta,0.002,0.004, 10, 200*10^3, 6.1303*10^-9)
