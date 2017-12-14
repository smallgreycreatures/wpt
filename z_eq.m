function [ ] = z_eq(f, L1 ,L2, M, Rl1, Rl2, R_amp)
    w = 2*pi*f;
syms R_Load real;
    
   syms C1 real;
    
    C2 = 1/(w^2*L2)
    z3eq = j*w*(L2-M) + Rl2 + 1/(j*w*C2) + R_Load;
    z2 = j*w*M;
    z2eq = (z2*z3eq)/(z2+z3eq);
    z1eq = Rl1 + j*w*(L1 - M) + z2eq;
    zc1 = 1/(j*w*C1);
    
    real_part = real(z1eq);
    R_Load_Nr = solve(real_part==R_amp, R_Load);
    R_Load_Nr = double(R_Load_Nr)
    [m,n] = size(R_Load_Nr)
    
    if m > 1
        4
        if R_Load_Nr(1) > 0
            R_Load_Nr = R_Load_Nr(1)
            
        else
            R_Load_Nr = R_Load_Nr(2)
        end
    end
    z3eq = j*w*(L2-M) + Rl2 + 1/(j*w*C2) + R_Load_Nr;
    z2 = j*w*M;
    z2eq = (z2*z3eq)/(z2+z3eq);
    z1eq = Rl1 + j*w*(L1 - M) + z2eq;
    zc1 = 1/(j*w*C1);
    zeqc1 = z1eq+zc1;%zc1*z1eq/(zc1+z1eq);
    imag_part = imag(zeqc1);
    
    C1_Nr = solve(imag_part==0, C1)
    
    double(C1_Nr)
    double(R_Load_Nr)
end
