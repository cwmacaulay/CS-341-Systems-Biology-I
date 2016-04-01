function [t,y] = backEuler( fn, y0, tstart, tend, n, params )
% Works cited:
% The following sources were useful in figuring out how backward Euler works 
% and basics on how to implement it. 
% http://people.ischool.berkeley.edu/~johnsonb/Math_128A_files/ProgrammingAssignment4.pdf
% http://www.mathstat.dal.ca/~iron/math3210/backwardeuler
% David Houcque - Northwestern U. http://www.math.unipd.it/~alvise/CS_2008/ODE/MFILES/ode.pdf 

% h is the step size, just the chunk of time being evaluated divided by the
% number of steps, n.
h = (tend-tstart)/n;
t=linspace(tstart,tend,n+1);
y=zeros(n,length(y0));
y(1,:) = y0;
for i=1:n
    t(i+1) = t(i)+h;
    %y(i,:)
    %h*(fn(t(i),y(i,:), params))
    ynew = y(i,:) + h*(fn(t(i),y(i,:), params)');
    y(i+1,:) = y(i,:) + h*(fn(t(i+1),ynew, params)');
end;
end

