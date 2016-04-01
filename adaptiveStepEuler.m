function [t, y] = adaptiveStepEuler( funct, start_time, end_time, errTol, params, yinit) 
t = start_time;
y = yinit;
hold = ((start_time+.000001)/end_time/100.00);

while t(end) < end_time
    %test = funct(t(end), y(end,:), params);
    %test
    [~,yn] = forwardEuler( funct, [t(end) t(end)+hold], y(end,:)', params );

    [~,ynhat] = explicitTrapezoidal( funct, [t(end) t(end)+hold], y(end,:)', params );

    err = norm( yn(2,:) - ynhat(2,:) );
    

    hnew = hold* (.9*(errTol/err))^.5;
    if hnew/hold > 2
        %fprintf('hnew is more than 2X hold \n');
        hnew = hold *2;
    end;
    if err < errTol
        %fprintf('LESS THAN TOLERANCE \n');
        y( end +1,:) = yn(2,:);
        t( end +1 ) = t(end) + hold;
    end;
    hold = hnew;
    %hold
end;