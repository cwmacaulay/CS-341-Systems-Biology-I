function cost = simple_island_cost_function( params )
if params(1) < 20 || params(1) > 40
    cost = inf;
    return
end
if params(2) < 10 || params(2) > 50
    cost = inf;
    return
end;
cost = abs(100 - (params(1)*params(2)*0.1));