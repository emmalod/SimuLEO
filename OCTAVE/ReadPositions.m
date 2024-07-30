function [phi_s,lambda_s,h_s] = ReadPositions(files_path)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geoinformatics Project - Positioning and Location Based Services
% A.A. 2023/2024
%
% Input: 
% files_path       --> path of the folder in which input txt files are read
%
% Output: 
% phi_s            --> latitude of the considered satellite 
% lambda_s         --> longitude of the considered satellite
% h_s              --> altitude of the considered satellite
%
% This function takes as input the path of the folder in which txt files of
% satellites positions are located (InputFolderPath) and reads the data in
% columns, saving in phi_s variable the first column, in lambda_s variable
% the second column and in h_s the third column. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    fid = fopen(files_path, 'r');

    % Read data from file
    data = fscanf(fid, '%f %f %f', [3 Inf]);
    
    % Close file
    fclose(fid);

    % Transpose matrix
    data = data';

    % Coordinates extraction
    phi_s = data(:,1);
    lambda_s = data(:,2);
    h_s = data(:,3);

end