function cost = Gb5stateDrosOsc( params )

% Use ode15s to get the output from the per oscillator given this set of
% parameters.

% Arbitrary initial concentrations (M, Po, P1, P2, PN ) for the PER
% oscillator. These were from project 2. 
var = [0.6 0.3 .3 0.3 1];
[t,y] = ode15s( @per, 0:0.1:600, var, odeset('AbsTol', .1, 'RelTol',.1), params);

%figure;
%plot(t, y);


% 1. What is the period from this output? 
[period, ~] = getPeriod( t, y );

% 2. What is the amplitude from this output?
% This is the amplitude we will add to the cost under.
threshold = .1;
ampsUnderThreshold = 0;
for i = 1:length(y(1,:))
    % get the average amplitude for state i
    amp = getAmp( y, i );
    if (amp < threshold)
        ampsUnderThreshold = ampsUnderThreshold +1;
    end;
end;

% cost penalizes periods different from 23.6
% and outputs with highger numbers of states with amplitudes
% less than the threshold value. 
cost = (abs(period - 23.6) + (ampsUnderThreshold*10));
