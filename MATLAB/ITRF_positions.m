function [ITRF_geod, ORS, ITRF] = ITRF_positions(t,t_0,t_end,D_t,r,o_i,M0,Omega0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geoinformatics Project - Positioning and Location Based Services
% A.A. 2023/2024
% 
% Input:
% t         --> vector of times
% t_0       --> starting time 
% t_end     --> ending time 
% D_t       --> time discretization step 
% r         --> orbit radius
% o_i       --> orbit inclination 
% M0        --> mean anomaly
% Omega0    --> starting rigth ascension of the ascending node 
% Output: 
% ITRF_geod --> coordinates of the point of interest in ITRF geodethic 
%   
% This function manages the conversion of a point from the Orbital Reference
% System to the ITRF geodethic 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Inizialize constants
    OmegaEdot = 7.2921151467e-05; %(rad/s)
    GMe = 3.986005e+14; %(m3/s2)
    
    % Compute positions in ITRF, X, Y, Z

    % Initialize vector of positions
    x_t = zeros(1,length(t));
    y_t = zeros(1,length(t));
    W = zeros(1,length(t));
    %ORS = zeros(length(t), 3);
    
    % Compute the mean angular velocity
    n = sqrt(GMe/r^3); 
    
    % Fill the previous vectors
    i = 1;
    for Dt = t_0 : D_t : (t_end - t_0)      % Dt is the counter
        % compute M_t
           M_t = M0 + n*Dt;
        % compute W(t)
           W(i)= Omega0 - OmegaEdot*Dt;
        % compute x(t)
           x_t(i) = r*cos(M_t);          
        % compute y(t)
           y_t(i) = r*sin(M_t);
        i = i+1;
    end

    ORS = [x_t' y_t' zeros(length(t), 1)]; % axis z is 0 because the orbital plane
                                           % lays on the x,y plane
    
    % Fill the three rotation matrices and rotate from ORS to ITRF
    
    ITRF = zeros(length(t), 3);
    ITRF_geod = zeros(length(t), 3);
   
    for i = 1:length(t)
        
        R1 = [1 0 0 ; 0 cos(o_i*pi/180) -sin(o_i*pi/180); 0 sin(o_i*pi/180) cos(o_i*pi/180)];    % o_i = OrbitInclination
        R31 = [cos(W(i)) -sin(W(i)) 0; sin(W(i)) cos(W(i)) 0; 0 0 1];
        R32 = [1 0 0; 0 1 0; 0 0 1];
        R = R31*R1*R32;
 
        X_ORS = ORS(i, :);
        X_ITRF = R*X_ORS';
        ITRF(i,:) = X_ITRF;
    
        % From global Cartesian to Geodetic 
        [lat, lon, h] = Cart2Geod(X_ITRF(1),X_ITRF(2),X_ITRF(3));
        ITRF_geod(i, :) = [lat, lon, h];
        
    end 

end