function [children, costs] = ES( costfn, numpar, numc, numGenerations, mutationFraction, lb, ub, maxt)
% In this algorithm there is a smaller number of children than parents.
% This is the truncation approach: taking a given number of most fit
% children to become parents each generation.

% To store all of the children that get generated. 
all_ch = zeros((numGenerations*numc),length(lb));
% To store all of their costs. 
all_costs = zeros( numc, numGenerations);


[costs, parents] = generateParents( numpar, costfn, lb, ub, maxt);
for g = 1: numGenerations
    [costs, children] = generateChild( numc, parents, costfn, lb, ub, maxt, mutationFraction);
    % the sort method returns idx, which is a list of indices.
    [costs, idx] = sort(costs);
    
    children = children( :, idx)'; %or (:, idx)'
    
    %children
    %all_ch((((g-1)*numc)+1):(g*numc),:)
    
    all_ch((((g-1)*numc)+1):(g*numc),:) = children;
    all_costs(:,g) = costs;
    
    parents = children( 1: numpar, : )';
end;

children = all_ch;
costs = all_costs;