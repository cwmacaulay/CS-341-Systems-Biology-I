function [children, costs] = GAlinear( costfn, numIndividuals, numGenerations, mutationFraction, lb, ub, maxt, r)
% In this algorithm the number of children and parents from generation to
% generation is the same. The selection of parents to produce children is
% based on linear probability which is assigned based on cost of each
% individual. This is also an elitist implementation, allowing the
% designated number of most-fit parents to proceed to the next
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
    probs = zeros(numIndividuals,1);
    cutoff = 0.0;
    for j=1:numIndividuals
        pN = (2/numIndividuals)/(r+1);
        p1 = r*pN;
        pj = pN + (p1-pN)*((numIndividuals-j)/(numIndividuals-1));
        cutoff = cutoff +pj;
        probs(j) = cutoff;
    end;
    
    all_ch((((g-1)*numIndividuals)+1):(g*numIndividuals),:) = children;
    all_costs(:,g) = costs;
    parents = zeros( length(lb), numIndividuals );

    for i=1:(numIndividuals-1)
        a = rand();
        dex = 1;
        for j=1:length(probs)
            if (a >= probs(j))
                dex = int8(j);
            end;
        end;
        parents(:,i) = children( dex, : )';
    end;
    parents( :, numIndividuals ) = eliteParent;
    eliteParent = children(1, :)';
end;

children = all_ch;
costs = all_costs;