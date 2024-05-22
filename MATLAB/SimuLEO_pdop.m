function [] = SimuLEO_pdop(InputFolderPath, t,x_0,y_0,z_0)
 
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
    files = dir(fullfile(InputFolderPath, '*.txt')); % InputFolderPath = SatellitePosition folder
    
    % Loop through each file in the folder
    for i = 1:length(files)
        % Get the file name
        InputFileName = files(i).name;
    
        % Create the full file path
        InputFilePath = fullfile(InputFolderPath, InputFileName);
    
        % Read positions
        [phi_s,lambda_s,h_s] = ReadPositions(InputFilePath);

        % Convert from geodetic coordinates to cartesian coordinates
        [x_s,y_s,z_s] = Geod2Cart(phi_s,lambda_s,h_s);
    
        % Compute ITRF positions each second of the day
        %[ITRF_geod] = ITRF_positions(t,t_0,t_end,D_t,OrbitRadius,OrbitInclination,M0,Omega0);
    
        % Save position matrix in a txt file in the output folder
        %SavePositions(ITRF_geod, InputFileName, OutputFolderPath);
        
    end

end