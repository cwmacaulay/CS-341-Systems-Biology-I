function [costs, params] = generateChild( numc, parents, costfn, lb, ub, maxt, mutation)

numparams = size(parents,1);
numparents = size(parents,2);
params = zeros(length(lb), numc);
costs = inf + zeros(1, numc);

for i = 1:numc
    for j = 1: maxt
        p1 = parents(:, randi(numparents));
        p2 = parents(:, randi(numparents));
        p = zeros( size(lb) );
        for k = 1 : numparams
            if rand()<0.5
                p(k) = p1(k);
            else
                p(k) = p2(k);
            end;
        end;
        p = p.*(1+randn(size(p))*mutation);
        % need these lines to make sure mutation didn't make them out of
        % bounds.
        p = max(lb,p);
        p = min(ub,p);
        c = costfn( p );
        if isfinite( c )
            params(:,i) = p;
            costs(i) = c;
            break
        end;
    end;
end;


