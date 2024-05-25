function [pdop] = SimuLEO_pdop(InputFolderPath,OutputFolderPath,t,x_0,y_0,z_0)
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geoinformatics Project - Positioning and Location Based Services
% A.A. 2023/2024
%
% Input: 
% InputFolderPath  --> path of the folder in which input txt files are read
% OutputFolderPath --> path of the folder in which output txt files are written
%
% This function takes as input the path of the folder in which txt files of
% satellites parameters are located (InputFolderPath), it makes a list of
% these files and computes the positions of the satellites in each second
% for 24 hours. At the end, it writes positions computed in txt files in
% the folder located in OutputFolderPath.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % List all files in the folder
    files = dir(fullfile(InputFolderPath, '*.txt')); % SatellitePosition folder

    A = [];

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
            norm_LC = norm(loc_coords(t,:));
            LC_normalized = - (loc_coords(t,:) / norm_LC);
        end

        A = [A ; LC_normalized];

    end

    A = [A ones(length(A),1)];
    N = A'*A;
    K = inv(N);
    pdop = trace(K);

end