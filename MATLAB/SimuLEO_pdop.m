function [pdop] = SimuLEO_pdop(InputFolderPath,OutputFolderPath,t,phi_0,lambda_0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geoinformatics Project - Positioning and Location Based Services
% A.A. 2023/2024
%
% Input: 
% InputFolderPath  --> path of the folder in which input txt files are read
% OutputFolderPath --> path of the folder in which output txt files are written
% t                --> time selected by the user for which the positions of
%                      the satellites should be computed 
% Phi_0            --> latitude of a point on Earth surface selected by the
%                      user
% Lambda_0         --> longitude of a point on Earth surface selected by the
%                      user
%
% Output: 
% pdop             --> indicator of quality for a certain set of in view 
%                      satellites
%
% This function takes as input the path of the folder in which txt files of
% satellites positions are located (InputFolderPath) and loops through them, 
% computing for each satellite the local coordinates and determining which satellite
% is in view and which not. At the end, it computes the pdop indicator of the constellation,
% considering the satellites in view at a specific epoch from a specific point on the
% Earth surface selected by the user.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Convert position of the point in Cartesian
    [x_0,y_0,z_0] = Geod2Cart(phi_0,lambda_0,0);

    % List all files in the folder
    files = dir(fullfile(InputFolderPath, '*.txt')); % SatellitePosition folder

    % Initialize matrices and vectors
    A = [];
    LC_normalized = [];

    % Loop through each file in the folder
    for i = 1:length(files)

        % Get the file name
        InputFileName = files(i).name;

        % Create the full file path
        InputFilePath = fullfile(InputFolderPath, InputFileName);

        % Read positions of satellite i
        [phi_s,lambda_s,h_s] = ReadPositions(InputFilePath);

        % Convert from geodetic coordinates to cartesian coordinates
        [x_s,y_s,z_s] = Geod2Cart(phi_s,lambda_s,h_s);

        % Compute local coordinates of the satellite with respect to the
        % coordinates of the point in time
        [loc_coords] = local_coordinates(x_0,y_0,z_0,x_s,y_s,z_s);

        % Save mask SATELLITE IN VIEW / SATELLITE NOT IN VIEW
        SaveMask(loc_coords, InputFileName, OutputFolderPath);

        % Check if satellite i is or isn't in view at given time t and
        % normalize its coordinates
        if (loc_coords(t,3)) >= 0
            norm_LC = norm(loc_coords(t,:)); % L2 norm
            LC_normalized = - (loc_coords(t,:) / norm_LC);
            A = [A ; LC_normalized];
        end

    end
    
    % Compute pdop
    A = [A ones(size(A,1),1)];
    N = A'*A;
    K = inv(N);
    pdop = trace(K);

end