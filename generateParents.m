function [costs, parents] = generateParents( numpar, costfn, lowbound, upbound, maxt)

parents = zeros(length(lowbound), numpar);
costs = inf + zeros(1, numpar);

for i = 1:numpar
    for j = 1: maxt
        p = lowbound + (upbound-lowbound).*rand(size(lowbound));
        c = costfn( p );
        if isfinite( c )
            parents(:,i) = p;
            costs(i) = c;
            break
        end;
    end;
end;



