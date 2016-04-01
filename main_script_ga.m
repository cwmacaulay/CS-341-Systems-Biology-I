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

% This calls the evolutionary strategy function which returns the matrices of
% child parameter sets and their costs. 
%function [children, costs] = ES( costfn, numpar, numc, numGenerations, mutationFraction, lb, ub, maxt)
[children, costs] = ES( @Gb5stateDrosOsc, numpar, numc, numGenerations, mutationFraction, lb, ub, maxt);




%% Cell 2: Runs the genetic algorithm with linear ranking selection.

% lower bound of each parameter is zero.
lb = zeros(1,18);
% upper bound of each parameters is 6. 
ub = 6 + zeros(1,18);

% this controls the selection operator by designating how many children can
% become parents each generation.
% numparents = numchildren = numIndividuals.
numIndividuals = 10;
mutationFraction = 0.05;
numGenerations = 5;
maxt = 100;

% This parameter, r, designates how many more times likely the best (lowest
% cost)parameter set (in a given generation) is to be selected over the 
% worst (highest cost).
r = 3;

% This calls the genetic algorithm with linear selection function which 
% returns the matrices of child parameter sets and their costs. 
% function [children, costs] = GAlinear( costfn, numIndividuals, numGenerations, mutationFraction, lb, ub, maxt, r)
[children, costs] = GAlinear( @Gb5stateDrosOsc, numIndividuals, numGenerations, mutationFraction, lb, ub, maxt, r);



%% Cell 3: Runs the genetic algorithm with tournament selection

% lower bound of each parameter is zero.
lb = zeros(1,18);
% upper bound of each parameters is 6. 
ub = 6 + zeros(1,18);

% this controls the selection operator by designating how many children can
% become parents each generation. 
% numparents = numchildren = numIndividuals.
numIndividuals = 10;
mutationFraction = 0.05;
numGenerations = 6;
maxt = 100;

% Number of fittest parents that continue into next generation.
elite = 1;

% Number of individuals to enter into a tournament per number of potential 
% parents every generation.
tourn = numIndividuals/2;
% function [children, costs] = GAtourn( costfn, numIndividuals, numGenerations, mutationFraction, lb, ub, maxt, tourn)
[children, costs] = GAlinear( @Gb5stateDrosOsc, numIndividuals, numGenerations, mutationFraction, lb, ub, maxt, tourn);





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
