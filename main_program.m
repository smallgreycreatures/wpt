mu0 = 4*pi*10^(-7);
r = [0.5, 0.5]; %radi of one loop 
l = [0.1, 0.1]; %längd på solenoid
d = 0.2; %distance in x
n = [20, 20]; % num of laps
z = 0;  
zprim = 0.2;
k = 0;
r_res =0;
l_res = 0;
n_res = 0;
f = 200*10^3; %frequency [Hz]
wire_radius = 0.001;
conductivity = 5.96*10^7;
delta=1/sqrt(pi*f*conductivity*mu0);


tic
M = calculate_mutual_inductance(r,l,n,d)
Le1 = external_selfinductance(r(1),l(1),n(1), wire_radius)
Le1_self = internal_selfinductance(r(1),wire_radius,delta);
L1 = Le1 + Le1_self;
%L_wheeler = (10*pi*mu0*n(1)^2*r(1)^2)/(9*r(1)+10*l(1))
Le2 = external_selfinductance(r(2),l(2),n(2), wire_radius)       
Le2_self = internal_selfinductance(r(1),wire_radius, delta);
L2 = Le2 + Le2_self;
%L = mu0*n(1)^2*r(1)^2*pi/l(1)
k_self = M/sqrt((L2*L2))
k = M/sqrt((Le1*Le2));
toc


%here is plot generation
radii_for_plot = [];
values_for_radii_plot = [];
i = 1;
%{
for r1 = 0.05:0.01:0.5
    r = [r1, r1];
    radii_for_plot(i) = r1;
    
    M = calculate_mutual_inductance(r,l,n,d);

    Le1 = external_selfinductance(r(1),l(1),n(1));
    Le1_self = internal_selfinductance(r(1),wire_thickness,delta);
    L1 = Le1 + Le1_self;

    Le2 = external_selfinductance(r(2),l(2),n(2));       
    Le2_self = internal_selfinductance(r(1),wire_thickness, delta);
    L2 = Le2 + Le2_self;
    k_self = M/sqrt((L2*L2));
    values_for_radii_plot(i) = k_self;
    i=i+1;
end

scatter(radii_for_plot, values_for_radii_plot);
xlabel('radii [m]') % x-axis label
ylabel('coupling factor') % y-axis label
figure()
r = [0.5, 0.5]; %radi of one loop 
l = [0.1, 0.1]; %längd på solenoid
d = 0.2; %distance in x
n = [20, 20]; % num of laps
len_for_plot = [];
values_for_len_plot = [];
turns_for_plot = [];
values_for_turn_plot = [];
i = 1;
c =1;
for l1 = 0.01:0.01:0.2
    l = [l1, l1];
    len_for_plot(i) = l1;
    
    M = calculate_mutual_inductance(r,l,n,d);

    Le1 = external_selfinductance(r(1),l(1),n(1));
    Le1_self = internal_selfinductance(r(1),wire_thickness,delta);
    L1 = Le1 + Le1_self;

    Le2 = external_selfinductance(r(2),l(2),n(2));       
    Le2_self = internal_selfinductance(r(1),wire_thickness, delta);
    L2 = Le2 + Le2_self;
    k_self = M/sqrt((L2*L2));
    values_for_len_plot(i) = k_self;
    i=i+1;
    
end
11111
scatter3(len_for_plot,values_for_len_plot,values_for_turn_plot)
figure()
scatter(len_for_plot, values_for_len_plot);
xlabel('len [m]') % x-axis label
ylabel('coupling factor') % y-axis label
figure()
r = [0.5, 0.5]; %radi of one loop 
l = [0.1, 0.1]; %längd på solenoid
d = 0.2; %distance in x
n = [20, 20]; % num of laps
turns_for_plot = [];
values_for_turn_plot = [];
i = 1;

for n1 = 1:1:100
    n = [n1, n1];
    turns_for_plot(i) = n1;
    
    M = calculate_mutual_inductance(r,l,n,d);

    Le1 = external_selfinductance(r(1),l(1),n(1));
    Le1_self = internal_selfinductance(r(1),wire_thickness,delta);
    L1 = Le1 + Le1_self;

    Le2 = external_selfinductance(r(2),l(2),n(2));       
    Le2_self = internal_selfinductance(r(1),wire_thickness, delta);
    L2 = Le2 + Le2_self;
    k_self = M/sqrt((L2*L2));
    values_for_turns_plot(i) = k_self;
    i=i+1;
end

scatter(turns_for_plot, values_for_turns_plot);
xlabel('turns n') % x-axis label
ylabel('coupling factor') % y-axis label
    %}     
%{
i = 0;  
for r1 = 0.1:0.1:0.5
    i
    i=i+1;
   r = [r1,r1];
   for l1 = 0.01:0.01:0.2
      l = [l1,l1];
      for n1 = 1:20
         n = [n1,n1];
         
    M = calculate_mutual_inductance(r,l,n,d);

    Le1 = external_selfinductance(r(1),l(1),n(1));
    Le1_self = internal_selfinductance(r(1),wire_thickness,delta);
    L1 = Le1 + Le1_self;

    Le2 = external_selfinductance(r(2),l(2),n(2));       
    Le2_self = internal_selfinductance(r(1),wire_thickness, delta);
    L2 = Le2 + Le2_self;
    k_self = M/sqrt((L2*L2));
          k_temp = k_self;
         if k_temp > k
             k = k_temp;
             r_res = r(1);
             l_res = l(1);
             n_res = n(1);
         end
      end
       
   end    
    
end
   
k
r_res
l_res
n_res
%}