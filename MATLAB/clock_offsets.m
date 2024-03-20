function [dt_sat] = clock_offsets(a0,a1,a2,t)

dt_sat = zeros(1,length(t));

% linear regression of degree 2

for i = 1:length(t)
    dt_sat (i) = a0*(t(i)-t(1)) + a1*(t(i)-t(1)) + a2*(t(i)-t(1));
end

%dt_sat = dt_sat_hat + D_rel;

end