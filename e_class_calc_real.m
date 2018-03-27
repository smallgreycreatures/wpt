function [ output_args ] = e_class_calc_real(L1, f, Vin, P, Q)
w = 2*pi*f;

R = 8*Vin^2/((pi^2+4)*P)


C1 = 1/(w*R*(pi/2)*((pi^2/4) +1))

C2 = 1/(w*R*(Q - ((pi*(pi^2-4))/16)))

L = Q*R/w


end

