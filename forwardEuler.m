function [t,y] = forwardEuler( fn, t, y0, params )

y = zeros(length(t),length(y0));
y(1,:) = y0;

for i = 2 : length(t),
    dt = t(i) - t(i-1);
    % y must go in as a column, so we need to transpose
    yprime = fn(t(i-1),y(i-1,:)',params);
    %fprintf( 'Output of degrade for this time step %d \n', yprime)
    % yprime is a column, but we need a row, so we need to transpose again
    y(i,:) = y(i-1,:) + dt*yprime';
end;
