function [ITRF_geod] = ITRF_positions(t,t_0,t_end,D_t,r,o_i,M0,Omega0)

% This function computes the ITRF positions in each second for each
% satellite
    
    % Inizialize constants
    OmegaEdot = 7.2921151467e-05; %(radians)
    GMe = 3.986005e+14; %(m3/s2)
    
    % Compute positions in ITRF, X, Y, Z

    % Initialize vector of positions
    x_t = zeros(1,length(t));
    y_t = zeros(1,length(t));
    W = zeros(1,length(t));
    ORS = zeros(length(t), 3);
    
    % Compute the mean angular velocity
    n = sqrt(GMe/r^3); 
    
    % Fill the previous vectors
    i = 1;
    for Dt = t_0 : D_t : (t_end - t_0)      % Dt is the counter
        % compute M_t
           M_t = M0 + n*Dt;
        % compute W(t)
           W(i)= Omega0-OmegaEdot*Dt;
        % compute x(t)
           x_t(i) = r*M_t;          
        % compute y(t)
           y_t(i) = r*M_t;
        i = i+1;
    end

    ORS = [x_t' y_t' zeros(length(t), 1)]; % axis z is 0 because the orbital plane
                                           % lays on the x,y plane
    
    % Fill the three rotation matrices and rotate from ORS to ITRF
    
    ITRF = zeros(length(t), 3);
    ITRF_geod = zeros(length(t), 3);
    
    for i=1:length(t)
        
        R1 = [1 0 0 ; 0 cos(o_i) -sin(o_i); 0 sin(o_i) cos(o_i)];    % o_i = OrbitInclination
        R31 = [cos(W(i)) -sin(W(i)) 0; sin(W(i)) cos(W(i)) 0; 0 0 1];
        R32 = [1 0 0; 0 1 0; 0 0 1];
        R = R31*R1*R32;
    
        % Suppose that the ORS could be seen as a LL RS
        X_LL = ORS(i, :); 

        % Transform the LL RS in the LC RS (from ORS to ICRS) with the rotation matrix
        X_LC = R*X_LL'; 
        ITRF(i, :) = X_LC';
    
        % From Local cartesian to Geodetic 
        [lat, lon, h] = Cart2Geod(X_LC(1),X_LC(2),X_LC(3));
        ITRF_geod(i, :) = [lat, lon, h];
        
    end 

end