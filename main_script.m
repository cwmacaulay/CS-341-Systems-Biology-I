% CS 341 Project 4
% main_script.m
% Charles Macaulay
% 12-10-15


% Each of the functions returns a matrix of children and a matrix of costs:

% example of matrix of 6-parameter parameter sets for 4 generations:
% [ 1 2 3 4 5 6 ] <-first child from generation 1
% [ 1 2 3 4 5 6 ]
% [ 1 2 3 4 5 6 ]
% [ 1 2 3 4 5 6 ]  
% [ 1 2 3 4 5 6 ] <-second child** from generation 2 if 3 children/generation.
% [ 1 2 3 4 5 6 ]
% [ 1 2 3 4 5 6 ]
% [ 1 2 3 4 5 6 ]
% [ 1 2 3 4 5 6 ]
% [ 1 2 3 4 5 6 ]
% [ 1 2 3 4 5 6 ]
% [ 1 2 3 4 5 6 ]

% example of matrix of costs:
% cost associated with child**
% generation:
%   1   2   3   4
% [ c   c   c   c ]
% [ c   c** c   c ]
% [ c   c   c   c ]




%% Cell 1: Runs the evolutionary strategy (truncation selection).
% This sets up the variables so that the strategy function can be called. 

% lower bound of each parameter is zero.
lb = zeros(1,18);
% upper bound of each parameters is 6. 
ub = 6 + zeros(1,18);

% this controls the selection operator by designating how many children can
% become parents each generation. 
numpar = 8;
numc = 40;
mutationFraction = 0.05;
numGenerations = 5;
maxt = 100;

% how many times to run the algorithm. 
runtimes = 5;

% dimensions multiplied by five because we're gonna run it 5 times. 
fiveRuns_children = zeros((numGenerations*numc*runtimes),length(lb));
fiveRuns_costs = zeros( numc*runtimes, numGenerations);

% This calls the evolutionary strategy function which returns the matrices of
% child parameter sets and their costs. 
for i =1:runtimes
    %function [children, costs] = ES( costfn, numpar, numc, numGenerations, mutationFraction, lb, ub, maxt)
    [children, costs] = ES( @Gb5stateDrosOsc, numpar, numc, numGenerations, mutationFraction, lb, ub, maxt);
    fiveRuns_children( ((i-1)*(numGenerations*numc)+1):(i*numGenerations*numc), : ) = children;
    fiveRuns_costs( ((((i-1)*numc)+1): i*numc), :)  = costs;
end;

fileID = fopen('ES_Children.txt','w');
fprintf( fileID, '%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', fiveRuns_children');
fclose(fileID);

fileID = fopen('ES_Costs.txt','w');
fprintf( fileID, '%f\t%f\t%f\t%f\t%f\n', fiveRuns_costs');
fclose(fileID);


%% Cell 2: Runs the genetic algorithm with linear ranking selection.

% lower bound of each parameter is zero.
lb = zeros(1,18);
% upper bound of each parameters is 6. 
ub = 6 + zeros(1,18);

% this controls the selection operator by designating how many children can
% become parents each generation.
% numparents = numchildren = numIndividuals.
numIndividuals = 40;
mutationFraction = 0.05;
numGenerations = 5;
maxt = 100;

% This parameter, r, designates how many more times likely the best (lowest
% cost)parameter set (in a given generation) is to be selected over the 
% worst (highest cost).
r = 3;

% how many times to run the algorithm. 
runtimes = 5;

% dimensions multiplied by five because we're gonna run it 5 times. 
fiveRuns_children = zeros((numGenerations*numIndividuals*runtimes),length(lb));
fiveRuns_costs = zeros( numIndividuals*runtimes, numGenerations);

% This calls the genetic algorithm with linear selection function.
for i =1:runtimes
    % function [children, costs] = GAlinear( costfn, numIndividuals, numGenerations, mutationFraction, lb, ub, maxt, r)
    [children, costs] = GAlinear( @Gb5stateDrosOsc, numIndividuals, numGenerations, mutationFraction, lb, ub, maxt, r);
    fiveRuns_children( ((i-1)*(numGenerations*numIndividuals)+1):(i*numGenerations*numIndividuals), : ) = children;
    fiveRuns_costs( ((((i-1)*numIndividuals)+1): i*numIndividuals), :)  = costs;
end;

fileID = fopen('GAlinear_Children.txt','w');
fprintf( fileID, '%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', fiveRuns_children');
fclose(fileID);

fileID = fopen('GAlinear_Costs.txt','w');
fprintf( fileID, '%f\t%f\t%f\t%f\t%f\n', fiveRuns_costs');
fclose(fileID);




%% Cell 3: Runs the genetic algorithm with tournament selection

% lower bound of each parameter is zero.
lb = zeros(1,18);
% upper bound of each parameters is 6. 
ub = 6 + zeros(1,18);

% this controls the selection operator by designating how many children can
% become parents each generation. 
% numparents = numchildren = numIndividuals.
numIndividuals = 40;
mutationFraction = 0.05;
numGenerations = 5;
maxt = 100;

% Number of fittest parents that continue into next generation.
elite = 1;

% Number of individuals to enter into a tournament per number of potential 
% parents every generation.
tourn = numIndividuals/2;

% how many times to run the algorithm. 
runtimes = 5;

% dimensions multiplied by run times. 
fiveRuns_children = zeros((numGenerations*numIndividuals*runtimes),length(lb));
fiveRuns_costs = zeros( numIndividuals*runtimes, numGenerations);

% This calls the genetic algorithm with tournament selection function.
for i =1:runtimes
    % function [children, costs] = GAtourn( costfn, numIndividuals, numGenerations, mutationFraction, lb, ub, maxt, tourn)
    [children, costs] = GAtourn( @Gb5stateDrosOsc, numIndividuals, numGenerations, mutationFraction, lb, ub, maxt, tourn);
    fiveRuns_children( ((i-1)*(numGenerations*numIndividuals)+1):(i*numGenerations*numIndividuals), : ) = children;
    fiveRuns_costs( ((((i-1)*numIndividuals)+1): i*numIndividuals), :)  = costs;
end;

fileID = fopen('GAtourn_Children.txt','w');
fprintf( fileID, '%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n', fiveRuns_children');
fclose(fileID);

fileID = fopen('GAtourn_Costs.txt','w');
fprintf( fileID, '%f\t%f\t%f\t%f\t%f\n', fiveRuns_costs');
fclose(fileID);



%% 4. Analyze the effect of increasing vd (rate of PER degradation) on the amount of PER.

% from pg. 320 of Goldbeter journal article: "the total (nonconserved)
% quantity of PER protein is given by [the sum of the four states]...

% holds the several parameter sets. 
psets = zeros(5, 18);
deltaPERs = zeros(5, 3);
% Several parameter sets from GAlinear output children. (Note that these
% aren't matrices...)
p1 = [1.311790	5.490872	2.943188	3.591481	1.667044 ...
    5.424242	5.055990	0.098978	0.553505	3.466889 ...
    0.453324	2.192459	4.098032	5.797595	0.384182 ...
    3.613246	0.145250	6.000000];
psets(1,:) = p1;
p2 = [1.229806	5.550525	0.438332	0.823440	3.052502 ...
    3.725128	4.943101	0.124125	0.821335	6.000000 ...
    4.086390	0.901546	4.492042	5.355356	2.933230 ...
    3.598540	6.000000	3.866582];
psets(2,:) = p2;
p3 = [1.194490	5.506627	3.789895	0.783835	2.756145 ...
    4.450054	5.607146	0.103233	0.651182	3.529246 ...
    0.416636	1.766093	4.157255	1.746846	0.404963 ...
    4.680768	0.313374	3.838520];
psets(3,:) = p3;
p4 = [1.348167	5.822814	3.774986	0.677719	4.995644 ...
    0.543067	0.968150	5.199175	1.181915	4.269204 ...
    3.424712	2.432315	4.643012	5.676619	1.437324 ...
    4.227148	3.599278	1.722631];
psets(4,:) = p4;
p5 = [1.261715	5.237130	3.776807	0.697382	2.815592 ...
    4.046695	4.506451	0.104058	2.226737	3.258189 ...
    4.209617	1.731594	4.823413	1.039766	4.675060 ...
    4.503844	0.204463	4.373373];
psets(5,:) = p5;

% Arbitrary initial concentrations (M, Po, P1, P2, PN ) for the PER
% oscillator. These were from project 2. 
var = [0.6 0.3 .3 0.3 1];

for i=1:5
    [~,y] = ode15s( @per, 0:0.1:6, var, odeset('AbsTol', .1, 'RelTol',.1), psets(i,:));
    
    pero = sum(sum(y));
    vd = 0;
    params = zeros( 1, 18);
    params = psets( i, : );
    for j=1:3
        vd = (params(5) + (params(5)*.03));
        params(5) = vd;
        [t,y] = ode15s( @per, 0:0.1:6, var, odeset('AbsTol', .1, 'RelTol',.1), params);
        pern = sum(sum(y));
        dper = (pern-pero);
        pero = pern;
        deltaPERs(i, j) = dper;
    end;
end;

figure;
for i=1:5
    plot(deltaPERs(i,:));
    hold on;
end;
xlabel('#times 3% of vd added to vd');
ylabel('change in PER content');
legend( {'pset1','pset2','pset3','pset4', 'pset5'});



% -------------------------------------------------------------------------
% Some other random things I have from class and my own futzing around. 
% -------------------------------------------------------------------------



%% Draw the landscape for the simple_island cost function
% This is a 2-d parameter space. We will draw the first parameter 
% in the x-dimension, the 2nd parameter in the y-dimension, and
% the cost in the z-dimension.

x = 0:1:100;
y = 0:1:100;
c = zeros(length(x),length(y));
for i = 1 : length(x), 
    for j = 1 : length(y), 
        c(i,j) = simple_island_cost_function( [x(i), y(j)] ); 
    end; 
end;
figure; surf( x, y, c ); 
xlim( [x(1) x(end)] ); 
ylim( [y(1) y(end)] )
xlabel( 'Parameter 1' )
ylabel( 'Parameter 2' )
zlabel( 'Cost ')
title( 'Simple Island' );


%% generateParents test
lb = zeros(1,18);
ub = 5 + zeros(1,18);
numpar = 10;
maxt = 100;
[costs, params] = generateParents( numpar, @Gb5stateDrosOsc, lb, ub, maxt);
figure;
plot3( params(1,:), params(2,:), costs, '*');

mutation = 0.05;
parents = params;
numc = 10;
%generateChild( numc, parents, costfn, lb, ub, maxt, mutation) 
[cost1, params] = generateChild( numc, parents, @Gb5stateDrosOsc, lb, ub, maxt, mutation);
figure;
plot3( params(1,:), params(2,:), cost1, 'r*');




%% JUST TESTING THE COST FUNCTION

% [ vs vm Km ks vd k1 k2 KI Kd n K1 K2 K3 K4 V1 V2 V3 V4 ]
params = [0.76 0.5 0.5 0.38 0.95 1.9 1.3 1 0.2 4 2 2 2 2 3.2 1.58 5 2.5];
cost = Gb5stateDrosOsc( params );
