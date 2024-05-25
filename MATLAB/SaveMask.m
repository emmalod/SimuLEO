function [] = SaveMask(local_coordinates, file_name, OutputFolderPath)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geoinformatics Project - Positioning and Location Based Services
% A.A. 2023/2024
%
% Input: 
% PositionMatrix   --> matrix with the position of a certain satellite in a certain orbit in time
% file_name        --> name of the txt file that will contain the position of the satellite in time 
% OutputFolderPath --> path of the folder in which output txt files are written
%
% This function takes as input the matrix with the position of a certain
% satellite in a certain orbit in time, the file name and the output folder
% path in order to write on a txt file "PositionLEOxxyy.txt" the position
% matrix of the considered satellite. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Define the file name for the output text file
    FileName = file_name;
    
    % Create the full file path
    FilePath = fullfile(OutputFolderPath, FileName);
    
    mask = zeros(length(local_coordinates(:,3)),1);

    % Create mask SATELLITE IN VIEW / SATELLITE NOT IN VIEW
    for i = 1 : length(local_coordinates(:,3))
        if local_coordinates(i,3) >= 0
            mask(i) = 1;
        end
    end

    % Save the position matrix to a text file
    save(FilePath, 'mask', "-ascii", "-tabs");

end