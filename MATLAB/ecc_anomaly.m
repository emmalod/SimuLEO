% SYNTAX
%  *  [E] = ecc_anomaly(M, e)
% OUTPUT
%  *  E = eccentricity anomaly
% INPUT
%  *  M = mean anomaly
%  *  e = eccentricity of the orbit

function [E] = ecc_anomaly(M, e)

E = M;

max_iter = 12; %it was 10 when using only GPS (convergence was achieved at 4-6 iterations);
               % now it set to 12 because QZSS PRN 193 can take 11 iterations to converge
i = 1;
dE = 1;

while ((dE > 1e-12) && (i < max_iter))
   E_tmp = E;
   E = M + e * sin(E);
   dE = mod(E - E_tmp, 2 * pi);
   i = i + 1;
end

if (i == max_iter)
    fprintf('WARNING: Eccentric anomaly does not converge.\n')
end

E = mod(E, 2 * pi);

