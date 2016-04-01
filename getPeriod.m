function [per,per_std] = getPeriod( t, y )
stateIdx = 1;
y = y(:,stateIdx);
m = mean(y);
d = diff( y );
idx_pos = find(y>m);

idx_up = find(diff(y)>0);
ref_idxs = intersect( idx_pos, idx_up );
d = diff(ref_idxs);
idxs = ref_idxs(find(d>1)+1);
per = mean(diff(t(idxs)));
per_std = std(diff(t(idxs)));
% 
% figure( 'Color', 'white' );
% plot( t, y );
% hold on;
% plot( t(idxs), y(idxs), 'r*' );
% xlabel( 'Time (h)' );
% ylabel( 'Abundance (a.u.)' );
% xlim( [t(1) t(end)] );