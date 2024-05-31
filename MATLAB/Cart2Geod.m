function [Phi,Lambda,h] = Cart2Geod(X,Y,Z) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geoinformatics Project - Positioning and Location Based Services lalalal
% A.A. 2023/2024
%
% Input: 
% [x,y,z]        --> cartesian coordinates of the point
% 
% Output: 
% [Phi,Lambda,h] --> geodethic coordinates of the point
%
% This function transforms the coordinates from cartesian to geodethic,
% receiving as input the cartesian coordinates of the point of interest 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Computation of the auxiliar quantities
    r = sqrt(X^2 + Y^2); 
    a = 6378137.0; % major semiaxis 
    f = 1/298.257222100882711243; % flattening: a-b/a 
    b = a - a*f; % minor semiaxis 
    e2 = 2*f - f^2;  
    eb2 = (a^2-b^2)/(b^2); 
    e = sqrt(e2); % eccentricity 
    psi = atan2 (Z , (r * sqrt(1 - e2))); 
    
    % Computation of geodetic coordinates [rad] 
    Lambda = atan2 (Y,X);  
    Phi = atan2 ( ( Z + (eb2 * b * (sin(psi))^3)) , (r - (e2 * a * (cos(psi))^3))); 
    Rn = a / sqrt (1- e2 * (sin(Phi))^2); 
    h = r / cos(Phi) - Rn; %[m] 

end