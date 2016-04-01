function dvardt = lotvol( t, var, params)
x = var(1);
y = var(2);

alpha = params(1);
beta = params(2);
gamma = params(3);
delta = params(4);

dvardt(1,1) = (alpha*x) - (beta*x*y);
dvardt(2,1) = (-gamma*y) + (delta*x*y);

