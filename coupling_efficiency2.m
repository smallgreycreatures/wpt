function [ eta_link ] = coupling_efficiency2(L1, L2, M, Rload,f,RL1, RL2)
k = M/sqrt(L1*L2);
w = 2*pi*f;
C2 = 1/(w^2*L2)
alpha = w*C2*Rload;
Qls1 = w*L1/RL1;
Qls2 = w*L2/RL2;

eta_link = k^2*Qls1*alpha/((alpha+k^2*Qls1+1/Qls2)*(alpha + 1/Qls2));
end