function [OrbitRadius,OrbitInclination,M0,Omega0] = ReadData(files_path)

data = readtable(files_path);

% Extract variables
%SatelliteName = data.SatelliteName;
OrbitRadius = data{1,2};
OrbitInclination = data{2, 2};
M0 = data{3, 2};
Omega0 = data{4, 2};

end