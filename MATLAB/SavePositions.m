function [] = SavePositions(PositionMatrix,file_name, OutputFolderPath)
   
    % Define the file name for the output text file
    FileName = strcat('Position', file_name);
    
    % Create the full file path
    FilePath = fullfile(OutputFolderPath, FileName);
    
    % Save the position matrix to a text file
    dlmwrite(FilePath, PositionMatrix, 'delimiter', '\t');

end