function [ output_args ] = e_class_calculator(Ls1,Ls2,M,f,Rs1,Rs2,R_Load)
k = M/sqrt(Ls1*Ls2);
w = 2*pi*f;
C2 = 1/(w^2*Ls2);
alpha = w*C2*R_Load;
Qls1 = w*Ls1/Rs1;
Qls2 = w*Ls2/Rs2;
n=sqrt(Ls2/Ls1);




%R_eq = (k^2*Ls1)/(C2*(R_Load +Rs2))

%C = Ls1/((w^2*Ls1^2 +(R_eq+Rs1)^2))
%{
A = sqrt((alpha*R_eq*R_Load)/((w^2*Ls1^2 + (R_eq + Rs1)^2)*(alpha + (1/Qls2))));

C1_spol = Ls1/(w^2*Ls1^2 + (Rs1 + Req)^2);
R = (w^2*Ls1^2+ (Rs1+R_eq)^2)/(Rs1+Req);
y = pi*(1-0.5);
phi = atan(((sin(y)/y) +cos(y))/sin(y));

q1 = -2*g*sin(phi-y)*sin(y) - 2*y*sin(y);
q2 = 2*y*cos(y) - 2*sin(y);
q3 = -(g/2)*sin(2*y);

treudd = (q1*sin(phi) +q2*cos(phi) +q3*cos(2*phi) +g*y)/(q2*sin(phi) + q3*sin(2*phi) -q1*cos(phi));

C1par = (2*y^2 + 2*y*g*sin(phi - y) - 2*g*sin(phi)*sin(y))/(w*pi*g^2*Rs1);
C1ser = 1/(w*(w*Ls1 - R*tan(treudd)));

%}
end

