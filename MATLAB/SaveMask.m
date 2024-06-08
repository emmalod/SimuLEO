function [] = SaveMask(local_coordinates, file_name, OutputFolderPath)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geoinformatics Project - Positioning and Location Based Services
% A.A. 2023/2024
%
% Input: 
% loc_coords       --> local coordinates in x direction of the point on
%                      the Earth surface selected by the user
% file_name        --> name of the current output file
% OutputFolderPath --> path of the folder in which output txt files are written
%
% This function takes as input the coordinates of a considered satellite
% and the output file, and creates a mask of 1 for in view satellites and 0
% for not in view satellites, saving it on txt files inside an OutputFolder
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Define the file name for the output text file
    FileName = file_name;
    
    % Create the full file path
    FilePath = fullfile(OutputFolderPath, FileName);

    % Initialize mask matrix
    mask = zeros(length(local_coordinates(:,3)),1);

    % Create mask SATELLITE IN VIEW / SATELLITE NOT IN VIEW
    for i = 1 : length(local_coordinates(:,3))
        if local_coordinates(i,3) >= 0
            mask(i) = 1;
        else
            mask(i) = 0;
        end
    end

    % Save the position matrix to a text file
    save(FilePath, 'mask', "-ascii", "-tabs");

end