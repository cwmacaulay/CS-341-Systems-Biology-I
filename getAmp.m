function [avgamp] = getAmp( y, state )
y = y(:,state);
m = mean(y);

% take the derivative of y so we can find extrema.
der = diff(y);
extr = zeros(length(y), 2);
for i=1:(length(der)-1)
    % check to find any places where the slope of y changes from positive
    % to negative (extrema). 
    if (((der(i) >= 0 ) && ( der(i+1) <= 0)) || ((der(i) <= 0 ) && ( der(i+1) >= 0)))
        extr(i,1) = y(i);
        extr(i,2) = i;
    end;
end;


% are these find methods fast enough or is there a faster way to do this?
idx_pos = find(y>m);
idx_neg = find(y<m);

peaks = intersect( idx_pos, extr );
troughs = intersect( idx_neg, extr );

a = length(peaks);
if (a>=length(troughs) )
    a = length(troughs);
    
end;
numamps = zeros(a, 1);
for i=1:a
    numamps(i) = y(peaks(i))-y(troughs(i));
end;

avgamp = mean(numamps);

%avgamp



%d = diff((peaks-troughs));
%idxs = ref_idxs(find(d>1)+1);
%amp = mean(diff(t(idxs)));
%amp_std = std(diff(t(idxs)));