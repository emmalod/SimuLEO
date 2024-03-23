function [] = SavePositions(PositionMatrix,file_name, OutputFolderPath)

% This function save the positions of each satellite in an indipendent txt
% files "PositionLEOxxyy.txt" in the SatellitePositionxxyyzz folder
   
    % Define the file name for the output text file
    FileName = strcat('Position', file_name);
    
    % Create the full file path
    FilePath = fullfile(OutputFolderPath, FileName);
    
    % Save the position matrix to a text file
    writematrix(PositionMatrix, FilePath,'Delimiter','tab')

end