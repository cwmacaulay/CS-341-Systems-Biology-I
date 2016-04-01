function dydt = degrade( t, y, params)

y1 = y(1);
y2 = y(2);

alpha = params(1);
beta = params(2);

dydt(1,1) = -alpha*y1;
dydt(2,1) = -beta*y2;
