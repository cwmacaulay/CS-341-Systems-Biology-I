% This main script file tests two aspects of each method:
% 1 - time efficiency
% 2 - accuracy
% Methods tested:
% 1 - ode15s built in               (  builtin  )
% 2 - Forward Euler                 (forwardEuler.m)
% 3 - Explicit Trapezoidal          (explicitTrapezoidal.m)
% 4 - Adaptive Step Euler           (adaptiveStepEuler.m)
% 5 (Extension) - Backwards Euler   (backEuler.m)
% Functions tested on:
% 1 - Two-protein degradation model (degrade.m)
% 2 - Lottka-Volterra               (lotvol.m)


%% 1. Let's just graph all of the solvers so that we can show they all work.

% PARAMS/ YINIT FOR degrade.m
% initial y value
y0 = [1 2.5];
% parameters
params = [0.1 0.2];
[to,yo] = ode15s( @degrade, 0:0.1:30, y0, odeset('AbsTol', 1e-8, 'RelTol', 1e-8), params );
[tfe,yfe] = forwardEuler( @degrade, 0:0.1:30, y0, params );
[tbe,ybe] = backEuler( @degrade, y0, 0.0, 30.0, 300, params );
[tet,yet] = explicitTrapezoidal( @degrade, 0:0.1:30, y0, params );
[tas,yas] = adaptiveStepEuler( @degrade, 0.0, 30.0, .001, params, y0 );

figure;
p1 = plot( to, yo, 'black.');
hold on;
p2 = plot( tfe, yfe,  'g');
p3 = plot( tbe, ybe, 'r');
p4 = plot( tet, yet, 'y');
p5 = plot( tas, yas, 'b' );
hold off;
title('Protein Degradation Model');
xlabel( 't' );
ylabel( 'y' );


% PARAMS/ YINIT FOR lotvol.m
% initial y value
var0 = [1 2.5];
% parameters
params = [0.25 0.01 1 0.01];

[to,yo] = ode15s( @lotvol, 0:0.1:60, var0, odeset('AbsTol', 1e-8, 'RelTol', 1e-8), params );
[tfe,yfe] = forwardEuler( @lotvol, 0:0.1:60, var0, params );
[tbe,ybe] = backEuler( @lotvol, var0, 0.0, 60.0, 10000, params );
[tet,yet] = explicitTrapezoidal( @lotvol, 0:0.1:60, var0, params );
[tas,yas] = adaptiveStepEuler( @lotvol, 0.0, 60.0, .001, params, var0 );


figure;
p1 = plot( to, yo, 'black.');
hold on;
p2 = plot( tfe, yfe,  'g');
p3 = plot( tbe, ybe, 'r');
p4 = plot( tet, yet, 'y');
p5 = plot( tas, yas, 'b' );
hold off;
title('Lottka-Volterra Model');
xlabel( 't' );
ylabel( 'y' );


%% 2. Basic time efficiency of all ode solvers tested with protein degradation function.

% PARAMS/ YINIT FOR degrade.m
% initial y value
y0 = [1 2.5];
% parameters
params = [0.1 0.2];

fprintf('Runtime of ode15s: \t');
tic;
[t,y] = ode15s( @degrade, 0:0.1:50, y0, odeset('AbsTol', 1e-8, 'RelTol', 1e-8), params );
toc;
fprintf('Runtime of Forward Euler: \t');
tic;
[t,y] = forwardEuler( @degrade, 0:0.1:50, y0, params );
toc;
fprintf('Runtime of Explicit Trapezoidal: \t');
tic;
[t,y] = explicitTrapezoidal( @degrade, 0:0.1:50, y0, params );
toc;
fprintf('Runtime of Adaptive Step Euler: \t');
tic;
[t,y] = adaptiveStepEuler( @degrade, 0.0, 50.0, 1e-8, params, y0 );
toc;
fprintf('Runtime of Backwards Euler: \t');
tic;
[t,y] = backEuler( @degrade, y0, 0.0, 50.0, 500, params );
toc;

%% 3. Basic time efficiency of all ode solvers tested with Lotka-Volterra.

% PARAMS/ YINIT FOR lotvol.m
% initial y value
var0 = [1 2.5];
% parameters
params = [0.25 0.01 1 0.01];

fprintf('Runtime of ode15s: \t');
tic;
[t,y] = ode15s( @lotvol, 0:0.1:50, var0, odeset('AbsTol', 1e-8, 'RelTol', 1e-8), params );
toc;
fprintf('Runtime of Forward Euler: \t');
tic;
[t,y] = forwardEuler( @lotvol, 0:0.1:50, var0, params );
toc;
fprintf('Runtime of Explicit Trapezoidal: \t');
tic;
[t,y] = explicitTrapezoidal( @lotvol, 0:0.1:50, var0, params );
toc;
fprintf('Runtime of Adaptive Step Euler: \t');
tic;
[t,y] = adaptiveStepEuler( @lotvol, 0.0, 50.0, 1e-8, params, var0 );
toc;
fprintf('Runtime of Backwards Euler: \t');
tic;
[t,y] = backEuler( @lotvol, var0, 0.0, 50.0, 500, params );
toc;


%% 3. Comparison of RUNTIME of Forward Euler, Backward Euler, Explicit Trapezoidal for range of stepsize

% stepsizes considered
stepsizes = [ 0.01, 0.02, 0.04, 0.08, 0.16];

% -------------- effects of stepsize in the protein model ------------------
% PARAMS/ YINIT FOR degrade.m
% initial y value
y0 = [1 2.5];
% parameters
params = [0.1 0.2];

% Variables to store the runtime at each stepsize
fe_pr = zeros( length(stepsizes), 2 );
fe_pr( :,1 ) = stepsizes;
be_pr = zeros( length(stepsizes), 2 );
be_pr( :,1 ) = stepsizes;
et_pr = zeros( length(stepsizes), 2 );
et_pr( :,1 ) = stepsizes;

for i=1:length(stepsizes)
    [t,y] = ode15s( @degrade, 0:stepsizes(i):20, y0, odeset('AbsTol', 1e-8, 'RelTol', 1e-8), params );
    tic;
    [~,~] = forwardEuler( @degrade, 0:stepsizes(i):20, y0, params );
    fe_pr(i,2) = toc;
    
    tic;
    [~,~] = backEuler( @degrade, y0, 0.0, 20.0, 20.0/stepsizes(i), params );
    be_pr(i,2) = toc;
    
    tic;
    [~,~] = explicitTrapezoidal( @degrade, 0:stepsizes(i):20, y0, params );
    et_pr(i,2) = toc;
end;


    
% ---------- effects of stepsize in the predator prey model ---------------
% PARAMS/ YINIT FOR lotvol.m
% initial y value
var0 = [1 2.5];
% parameters
params = [0.25 0.01 1 0.01];

% Variables to store the runtime at each stepsize
fe_pp = zeros( length(stepsizes), 2 );
fe_pp( :,1 ) = stepsizes;
be_pp = zeros( length(stepsizes), 2 );
be_pp( :,1 ) = stepsizes;
et_pp = zeros( length(stepsizes), 2 );
et_pp( :,1 ) = stepsizes;

for i=1:length(stepsizes)
    tic;
    [~,~] = forwardEuler( @lotvol, 0:stepsizes(i):20, var0, params );
    fe_pp(i,2) = toc;
    
    tic;
    [~,~] = backEuler( @lotvol, var0, 0.0, 20.0, 20.0/stepsizes(i), params );
    be_pp(i,2) = toc;
    
    tic;
    [~,~] = explicitTrapezoidal( @lotvol, 0:stepsizes(i):20, var0, params );
    et_pp(i,2) = toc;
end;


figure;
plot( fe_pr(:,1), fe_pr(:,2) );
hold on;
plot( fe_pp(:,1), fe_pp(:,2) );
hold on;

plot( be_pr(:,1), be_pr(:,2) );
hold on;
plot( be_pp(:,1), be_pp(:,2) );
hold on;

plot( et_pr(:,1), et_pr(:,2) );
hold on;
plot( et_pp(:,1), et_pp(:,2) );
hold on;

legend( {'Forward Euler(Pr)', 'Forward Euler(LV)', 'Backward Euler(Pr)', ...
    'Backward Euler(LV)', 'Explicit Trapezoidal(Pr)',   ...
    'Explicit Trapezoidal(LV)', } );
xlabel( 'Time step size (s)' );
ylabel( 'Runtime of ode solver (s)' );



%% 4. Comparison of ACCURACY of Forward Euler, Backward Euler, Explicit Trapezoidal for range of stepsizes.

% Timesteps considered
stepsizes = [ 0.01, 0.02, 0.04, 0.08, 0.16];

% -------------- effects of stepsize on accuracy in the protein model ------------------
% PARAMS/ YINIT FOR degrade.m
% initial y value
y0 = [1 2.5];
% parameters
params = [0.1 0.2];


% Use the built-in ode15s as the "true" solution:
sol = ode15s( @degrade, [0 20], y0, odeset('AbsTol', 1e-9), params );



% To store the errors
fe_pr = zeros( length(stepsizes), 3 );
fe_pr( :,1 ) = stepsizes;
be_pr = zeros( length(stepsizes), 3 );
be_pr( :,1 ) = stepsizes;
et_pr = zeros( length(stepsizes), 3 );
et_pr( :,1 ) = stepsizes;


for i=1:length(stepsizes)
    
    ytrue = deval(sol, 0:stepsizes(i):20 ).';
    [~,y1] = forwardEuler( @degrade, 0:stepsizes(i):20, y0, params );
    errFE1 = norm(y1(:,1)-ytrue(:,1));
    errFE2 = norm(y1(:,2)-ytrue(:,2));
    errFE = mean([errFE1 errFE2]);
    fe_pr(i,2) = errFE;
    
    [~,y2] = backEuler( @degrade, y0, 0.0, 20.0, 20/stepsizes(i), params );
    errBE1 = norm(y2(:,1)-ytrue(:,1));
    errBE2 = norm(y2(:,2)-ytrue(:,2));
    errBE = mean([errBE1 errBE2]);
    be_pr(i,2) = errBE;
    
    [~,y3] = explicitTrapezoidal( @degrade, 0:stepsizes(i):20, y0, params );
    errET1 = norm(y3(:,1)-ytrue(:,1));
    errET2 = norm(y3(:,2)-ytrue(:,2));
    errET = mean([errET1 errET2]);
    et_pr(i,2) = errET;
    
    maxdif1 = 0;
    maxdif2 = 0;
    maxdif3 = 0;
    for j=1:length(y1)
        err11 = y1(j,1) - ytrue(j,1);
        err12 = y1(j,2) - ytrue(j,2);
        err1 = mean([err11 err12]);
        if (abs(err1) > maxdif1)
            maxdif1 = abs(err1);
        end;
        err21 = y2(j,1) - ytrue(j,1);
        err22 = y2(j,2) - ytrue(j,2);
        err2 = mean([err21 err22]);
        if (abs(err2) > maxdif2)
            maxdif2 = abs(err2);
        end;
        err31 = y3(j,1) - ytrue(j,1);
        err32 = y3(j,2) - ytrue(j,2);
        err3 = mean([err31 err32]);
        if (abs(err3) > maxdif3)
            maxdif3 = abs(err3);
        end;
    end;

    fe_pr(i,3) = maxdif1;
    be_pr(i,3) = maxdif2;
    et_pr(i,3) = maxdif3;
        
end;

% ---------- effects of stepsize on accuracy in the predator prey model ---------------
% PARAMS/ YINIT FOR lotvol.m
% initial y value
var0 = [1 2.5];
% parameters
params = [0.25 0.01 1 0.01];


% Use the built-in ode15s as the "true" solution:
sol = ode15s( @lotvol, [0 20], y0, odeset('AbsTol', 1e-9), params );

% To store the errors
fe_pp = zeros( length(stepsizes), 3 );
fe_pp( :,1 ) = stepsizes;
be_pp = zeros( length(stepsizes), 3 );
be_pp( :,1 ) = stepsizes;
et_pp = zeros( length(stepsizes), 3 );
et_pp( :,1 ) = stepsizes;

for i=1:length(stepsizes)
    
    ytrue = deval(sol, 0:stepsizes(i):20 ).';
    
    [~,y1] = forwardEuler( @lotvol, 0:stepsizes(i):20, y0, params );
    errFE1 = norm(y1(:,1)-ytrue(:,1));
    errFE2 = norm(y1(:,2)-ytrue(:,2));
    errFE = mean([errFE1 errFE2]);
    fe_pp(i,2) = errFE;

    [~,y2] = backEuler( @lotvol, y0, 0.0, 20.0, 20.0/stepsizes(i), params );
    errBE1 = norm(y2(:,1)-ytrue(:,1));
    errBE2 = norm(y2(:,2)-ytrue(:,2));
    errBE = mean([errBE1 errBE2]);
    be_pp(i,2) = errBE;
    
    [~,y3] = explicitTrapezoidal( @lotvol, 0:stepsizes(i):20, y0, params );
    errET1 = norm(y3(:,1)-ytrue(:,1));
    errET2 = norm(y3(:,2)-ytrue(:,2));
    errET = mean([errET1 errET2]);
    et_pp(i,2) = errET;
    
    maxdif1 = 0;
    maxdif2 = 0;
    maxdif3 = 0;
    for j=1:length(y1)
        err11 = y1(j,1) - ytrue(j,1);
        err12 = y1(j,2) - ytrue(j,2);
        err1 = mean([err11 err12]);
        if (abs(err1) > maxdif1)
            maxdif1 = abs(err1);
        end;
        err21 = y2(j,1) - ytrue(j,1);
        err22 = y2(j,2) - ytrue(j,2);
        err2 = mean([err21 err22]);
        if (abs(err2) > maxdif2)
            maxdif2 = abs(err2);
        end;
        err31 = y3(j,1) - ytrue(j,1);
        err32 = y3(j,2) - ytrue(j,2);
        err3 = mean([err31 err32]);
        if (abs(err3) > maxdif3)
            maxdif3 = abs(err3);
        end;
    end;
    
    fe_pp(i,3) = maxdif1;
    be_pp(i,3) = maxdif2;
    et_pp(i,3) = maxdif3;
    
end;


subplot(2,2,1);

set(gca,'fontsize',20)

plot( fe_pr(:,1), fe_pr(:,2) );
hold on;
plot( be_pr(:,1), be_pr(:,2) );
hold on;
plot( et_pr(:,1), et_pr(:,2), 'g');
hold on;
legend( {'Forward Euler',  'Backward Euler', 'Explicit Trapezoidal' } );
title('Stepsize and Relative Error (Protein Model)');
xlabel( 'Time step size (s)' );
ylabel( 'Error compared to ode15s' );

subplot(2,2,2);
plot( fe_pr(:,1), fe_pr(:,3) );
hold on;
plot( be_pr(:,1), be_pr(:,3) );
hold on;
plot( et_pr(:,1), et_pr(:,3), 'g' );
hold on;
legend( {'Forward Euler',  'Backward Euler', 'Explicit Trapezoidal' } );
title('Stepsize and Absolute Error (Protein Model)');
xlabel( 'Time step size (s)' );
ylabel( 'Error compared to ode15s' );

subplot(2,2,3);
plot( fe_pp(:,1), fe_pp(:,2) );
hold on;
plot( be_pp(:,1), be_pp(:,2) );
hold on;
plot( et_pp(:,1), et_pp(:,2), 'g' );
hold on;
legend( {'Forward Euler', 'Backward Euler',   ...
    'Explicit Trapezoidal', } );
title('Stepsize and Relative Error (Lottka-Volterra Model)');
xlabel( 'Time step size (s)' );
ylabel( 'Error compared to ode15s' );

subplot(2,2,4);
plot( fe_pp(:,1), fe_pp(:,3) );
hold on;
plot( be_pp(:,1), be_pp(:,3) );
hold on;
plot( et_pp(:,1), et_pp(:,3), 'g' );
hold on;
legend( {'Forward Euler', 'Backward Euler',   ...
    'Explicit Trapezoidal', } );
title('Stepsize and Absolute Error (Lottka-Volterra Model)');
xlabel( 'Time step size (s)' );
ylabel( 'Error compared to ode15s' );



%% 5. Analysis of varying stepsizes in Adaptive Step Forward Euler


% -------------- effects of stepsize on accuracy in the protein model ------------------
% PARAMS/ YINIT FOR degrade.m
% initial y value
y0 = [1 2.5];
% parameters
params = [0.1 0.2];

errTol = .01;
%function [t, y] = adaptiveStepEuler( funct, start_time, end_time, errTol, params, yinit) 
[tp, yp] = adaptiveStepEuler( @degrade, 0.0, 80.0, errTol, params, y0);
%figure;
%plot( t, 'o' );

% ---------- effects of stepsize on accuracy in the predator prey model ---------------
% PARAMS/ YINIT FOR lotvol.m
% initial y value
var0 = [1 2.5];
% parameters
params = [0.25 0.01 1 0.01];
[tv, yv] = adaptiveStepEuler( @lotvol, 0.0, 80.0, errTol, params, y0);

p_stepsizes = zeros(length(tp), 0);
lv_stepsizes = zeros(length(tv), 0);
for j=1:(length(tp)-1)
    p_stepsizes(j) = (tp(j+1)-tp(j));
    lv_stepsizes(j) = (tv(j+1)-tv(j));
end;

subplot(2,2,1);
plot(tp,yp);
title('Protein Degradation model');
subplot(2,2,3);
plot(p_stepsizes, '.');
title('Stepsize');

subplot(2,2,2);
plot(tv,yv);
title('Lottka-Volterra model');
subplot(2,2,4);
plot(lv_stepsizes, '.');
title('Stepsize');


%% 5. Analysis of error tolerance on stepsize for Adaptive Step Forward Euler

% Error tolerance range to consider:

errtol = [0.0001, 0.001, 0.01, 0.1, 1 ];


% ----------------------PARAMS/ YINIT FOR degrade.m------------------------
% initial y value
degy0 = [1 2.5];
% parameters
degparams = [0.1 0.2];
% ----------------------PARAMS/ YINIT FOR lotvol.m-------------------------
% initial y value
lvvar0 = [1 2.5];
% parameters
lvparams = [0.25 0.01 1 0.01];


% To store the error tolerance, the resulting average stepsize, and the
% standard error associated with this average. 
% for analysis of protein model
as_pr = zeros( length(errtol), 3 );
as_pr( :,1 ) = errtol;
% for analysis of lotvol model
as_lv = zeros( length(errtol), 3 );
as_lv( :,1 ) = errtol;

for i=1:length(errtol)
    
    disp(errtol(i));
    
    [tp, yp] = adaptiveStepEuler( @degrade, 0.0, 30.0, errtol(i), degparams, degy0);
    [tv, yv] = adaptiveStepEuler( @lotvol, 0.0, 30.0, errtol(i), lvparams, lvvar0);
    p_stepsizes = zeros(length(tp), 0);
    lv_stepsizes = zeros(length(tv), 0);
    for j=1:(length(tp)-1)
        p_stepsizes(j) = (tp(j+1)-tp(j));
        lv_stepsizes(j) = (tv(j+1)-tv(j));
    end;
    avp = mean(p_stepsizes);
    as_pr(i,2) = avp;
    stderr = std(p_stepsizes) / (length(p_stepsizes)^2);
    as_pr(i,3) = stderr;

    avlv = mean(lv_stepsizes);
    as_lv(i,2) = avlv;
    stderr = std(lv_stepsizes) / (length(lv_stepsizes)^2);
    as_lv(i,3) = stderr;
end;

subplot(1,2,1);
plot(as_pr(:,1), as_pr(:,2), '.');
errorbar(as_pr(:,1), as_pr(:,2), as_pr(:,3), 'black');
title('Protein Degradation Model');
xlabel('Error Tolerance')
ylabel('Mean stepsize (s)');
subplot(1,2,2);
plot(as_lv(:,1), as_lv(:,2), '.');
errorbar(as_lv(:,1), as_lv(:,2), as_lv(:,3), 'black');
title('Lottka-Volterra Model');
xlabel('Error Tolerance')
ylabel('Mean stepsize (s)');


