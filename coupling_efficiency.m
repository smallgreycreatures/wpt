function [ eta ] = coupling_efficiency(L1, L2, M, R_load,f,R_l1, R_l2)
k = M/sqrt(L1*L2);
n=sqrt(L2/L1);
R = ((k/n)^2)*(R_load + R_l2);
w = 2*pi*f;
Q_1 = 2*pi*f*L1/R_l1;
Q_2 = 2*pi*f*L2/R_l2;

eta = ((k/n)^2)*(R_load*w^2*L1^2*k^4)/((R+R_l1)*w^2*L1^2*k^4 + (R^2*R_l1));
%eta_2 = (k^2*Q_1*Q_2)/((2+k^2*Q_1*Q_2 +2*sqrt(1+ Q_2^2 + k^2*Q_1*Q_2)));

end

