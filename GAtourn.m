function [children, costs] = GAtourn( costfn, numIndividuals, numGenerations, mutationFraction, lb, ub, maxt, tourn)

% In this algorithm the number of children and parents from generation to
% generation is the same. The selection of parents to produce children 
% works as follows: a given number of children in a generation enter a 
% "tournament"--These are randomly chosen. The fittest individual of this 
% "tournament" becomes a parent of the next generation. This is another
% elitist implementation, allowing the designated number of most-fit 
% parents to proceed to the next
% generation.

% To store all of the children that get generated. 
all_ch = zeros((numGenerations*numIndividuals),length(lb));
% To store all of their costs. 
all_costs = zeros( numIndividuals, numGenerations);

% Generate the parents.
[costs, parents] = generateParents( numIndividuals, costfn, lb, ub, maxt);
% find the fittest parent.
[costs,idx] = min(costs);
eliteParent = parents(:,idx);
for g = 1: numGenerations
    [costs, childrens] = generateChild( numIndividuals, parents, costfn, lb, ub, maxt, mutationFraction);
    % the sort method returns idx, which is a list of indices.
    [costs, idx] = sort(costs);   
    children = childrens( :, idx)';
    
    all_ch((((g-1)*numIndividuals)+1):(g*numIndividuals),:) = children;
    all_costs(:,g) = costs;
    parents = zeros( length(lb), numIndividuals );

    for i=1:(numIndividuals-1)
        co = 100000000;
        keeper = 0;
        for j=1:tourn
            a = int64(randi(numIndividuals));
            if (costs(a) < co)
                keeper = a;
                co = costs(a);
            end;
        end;
        parents(:,i) = children( keeper, : )';
    end;
    parents( :, numIndividuals ) = eliteParent;
    eliteParent = children(1, :)';
end;

children = all_ch;
costs = all_costs;
