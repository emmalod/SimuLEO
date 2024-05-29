function [X,Y,Z] = Geod2Cart(phi,lambda,h)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geoinformatics Project - Positioning and Location Based Services
% A.A. 2023/2024
%
% Input:
% [Phi,Lambda,h] --> geodethic coordinates of the point
% 
% Output: 
% [x,y,z]        --> cartesian coordinates of the point
%
% This function transforms the coordinates from geodethic to cartesian,
% receiving as input the geodethic of the point of interest 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    a = 6378137; %major semiaxis
    e = 0.0818191908426215; %eccentricy
    b = a*sqrt(1-e^2); %minor semiaxis
    
    % Initialize coordinates vectors
    X = zeros(length(phi), 1);
    Y = zeros(length(phi), 1);
    Z = zeros(length(phi), 1);

    for i = 1:length(phi)
    
        Rn = a/sqrt(1-(e^2*(sin(phi(i)))^2));
        
        % Compute coordinates
        X(i) = (Rn+h(i))*cos(phi(i))*cos(lambda(i));
        Y(i) = (Rn+h(i))*cos(phi(i))*sin(lambda(i));
        Z(i) = (Rn*(1-e^2)+h(i))*sin(phi(i));
    
    end

end