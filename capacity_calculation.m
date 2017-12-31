function [ ret] = capacity_calculation(w, L, M)

c_sek = 1/(L*w*w*(1-(M/L)))
z_s = j*w*(L-M);
z_m = j*w*M;
syms r real;
z_eq = (((z_s + (1/(j*w*c_sek)) + r)*z_m)/(z_s + (1/(j*w*c_sek)) + r + z_m)) + z_s;

S = solve(real(z_eq) == r)
r = S(1)
z_eq = (((z_s + (1/(j*w*c_sek)) + r)*z_m)/(z_s + (1/(j*w*c_sek)) + r + z_m)) + z_s;

c_prime = 1/(w*imag(z_eq));
c_prime = double(c_prime)
r = double(r);
c_sek = double(c_sek);
ret = [c_prime, r, c_sek];
end

