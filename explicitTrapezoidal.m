function [t,y] = explicitTrapezoidal( fn, t, y0, params )

y = zeros(length(t),length(y0));
y(1,:) = y0;
for i = 2 : length(t),
    h = t(i)-t(i-1);
    yprime = fn( t(i-1), y(i-1,:)', params);
    yhat = y(i-1,:) + h*yprime';
    yprimehat = fn(t(i),yhat', params);
    y(i,:) = y(i-1,:) + h/2*(yprime' + yprimehat');
end;