function [phi_s,lambda_s,h_s] = ReadPositions(files_path)

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