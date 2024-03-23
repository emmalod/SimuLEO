function [OrbitRadius,OrbitInclination,M0,Omega0] = ReadData(files_path)

% This functions read data from txt files, one for each satellite

    data = readtable(files_path);
    
    % Extract variables
    OrbitRadius = data{1,2};
    OrbitInclination = data{2, 2};
    M0 = data{3, 2};
    Omega0 = data{4, 2};

end