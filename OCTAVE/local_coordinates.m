function [loc_coords] = local_coordinates(phi_0,lambda_0,x_s,y_s,z_s)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geoinformatics Project - Positioning and Location Based Services
% A.A. 2023/2024
%
% Input: 
% phi_0            --> latitude of a point on Earth surface selected by the
%                      user
% lambda_0         --> longitude of a point on Earth surface selected by the
%                      user
% x_s              --> cartesian coordinate in x direction of the satellite
%                      of interest 
% y_s              --> cartesian coordinate in y direction of the satellite
%                      of interest 
% z_s              --> cartesian coordinate in z direction of the satellite
%                      of interest
%
% Output: 
% loc_coords       --> local_coordinates of the considered satellite with
%                      respect to the observer
%
% This function takes as input the coordinates of a considered satellite
% and the coordinates of a point on the Earth surface selected by the user
% and it computes the local coordinates of the satellite with respect to
% that point. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Convert point coordinates from geodetic to cartesian
    [x_0,y_0,z_0] = Geod2Cart(phi_0,lambda_0,0);

    R = [-sin(lambda_0) cos(lambda_0) 0; -sin(phi_0)*cos(lambda_0) -sin(phi_0)*sin(lambda_0) cos(phi_0); cos(phi_0)*cos(lambda_0) cos(phi_0)*sin(lambda_0) sin(phi_0)];

    % Initialize vector of positions
    loc_coords = zeros(length(x_s),3);

    for i = 1 : length(x_s) 
        
        dx = [x_s(i)-x_0; y_s(i)-y_0; z_s(i)-z_0];
        loc_coords_vec = R*dx;
        loc_coords(i,:) = loc_coords_vec';

    end

end