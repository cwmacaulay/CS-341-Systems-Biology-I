% Charles Macaulay
% per.m
% CS 341, Project 2
% 10-16-15

function dvardt = per( t, var, params )

M = var(1);
Po = var(2);
P1 = var(3);
P2 = var(4);
Pn = var(5);

vs = params(1);
vm = params(2);
Km = params(3);
ks = params(4);
vd = params(5);
k1 = params(6);
k2 = params(7);
KI = params(8);
Kd = params(9);
n = params(10);
K1 = params(11);
K2 = params(12);
K3 = params(13);
K4 = params(14);
V1 = params(15);
V2 = params(16);
V3 = params(17);
V4 = params(18);

% M
dvardt(1,1) = (vs*(KI^n)/((KI^n)+(Pn^n)))-(vm*(M/(Km+M))); 
% Po
dvardt(2,1) = ks*M - V1*(Po/(K1+Po)) + V2*(P1/(K2+P1));
% P1
dvardt(3,1) = V1*(Po/(K1+Po)) - V2*(P1/(K2+P1)) - ...
    V3*(P1/(K3+P1)) + V4*(P2/(K4+P2));
% P2
dvardt(4,1) = V3*(P1/(K3+P1)) - V4*(P2/(K4+P2)) - ...
    k1*P2 + k2*Pn - vd*(P2/(Kd+P2));
% Pn
dvardt(5,1) = k1*P2 - k2*Pn;

