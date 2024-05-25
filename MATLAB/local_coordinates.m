function [loc_coords] = local_coordinates(x_0,y_0,z_0,x_s,y_s,z_s)

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
%
% Output: 
% ITRF_geod --> coordinates of the point of interest in ITRF geodethic 
%   
% This function converts the coordinates of a point from the Orbital
% Reference System to the ITRF geodethic.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Convert point coordinates from cartesian to geodetic
    [phi_0,lambda_0,h_0] = Cart2Geod(x_0,y_0,z_0);

    R = [-sin(lambda_0) cos(lambda_0) 0; -sin(phi_0)*cos(lambda_0) -sin(phi_0)*sin(lambda_0) cos(phi_0); cos(phi_0)*cos(lambda_0) cos(phi_0)*sin(lambda_0) sin(phi_0)];

    % Initialize vector of positions
    loc_coords = zeros(length(x_s),3);

    for i = 1 : length(x_s) 
        
        dx = [x_s(i)-x_0; y_s(i)-y_0; z_s(i)-z_0];
        loc_coords_vec = R*dx;
        loc_coords(i,:) = loc_coords_vec';

    end

end