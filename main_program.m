mu0 = 4*pi*10^(-7);
r = [0.05, 0.05]; %radi of one loop 
l = [0.1, 0.1]; %l�ngd p� solenoid
d = 0.2; %distance in z
n = [200, 200]; % num of laps
z = 0;  
zprim = 0.2;
k = 0;
r_res =0;
l_res = 0;
n_res = 0;
f = 200*10^3; %frequency [Hz]
wire_radius = 0.001;
distance_between_turns = 0.005;
conductivity = 5.96*10^7;
delta=1/sqrt(pi*f*conductivity*mu0);

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

figure
subplot(2,2,1)
plot_turns_solenoid(r,l,n,d,wire_radius,delta);
title(['solenoid with r = ',num2str(r(1)),' m, l = ', num2str(l(1)), ' m, d = ', num2str(d), ' m'])
%figure();
subplot(2,2,2)
plot_radii_solenoid(r,l,n,d,wire_radius,delta);
title(['solenoid with n = ',num2str(n(1)),' m, l = ', num2str(l(1)), ' m, d = ', num2str(d), ' m'])
%figure()


L_re1 = external_selfinductance_radii(r(1), n(1), distance_between_turns, wire_radius)
Lr_self1 = internal_selfinductance(r(1),wire_radius,delta, n(1))
L_r1 = L_re1 + Lr_self1;

L_re2 = external_selfinductance_radii(r(2), n(2), distance_between_turns, wire_radius)
Lr_self2 = internal_selfinductance(r(1),wire_radius, delta, n(2))
L_r2 = L_re2 + Lr_self2;

M_r = calculate_mutual_inductance_radii(r(1), distance_between_turns, n, d)
k = M_r/sqrt((L_r1*L_r2))

subplot(2,2,3)
f_rad = plot_radii_layer_coil(r,n,d,distance_between_turns, wire_radius, delta)
title(['flat coil with n = ', num2str(n(1)), ' , d = ', num2str(d), ' m'])
%figure();
subplot(2,2,4)
f_turns = plot_turns_layer_coil(r,n,d,distance_between_turns, wire_radius, delta)
title(['flat coil with r = ', num2str(r(1)), ' , d = ', num2str(d), ' m'])
%figure();

%plot_turns_solenoid_and_layer_coil(r,n,d,distance_between_turns,wire_radius,delta,l);

%Maximize_k_flat_coil(r(1),n,d,distance_between_turns, wire_radius,delta,0.002,0.004);
