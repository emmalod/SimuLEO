%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geoinformatics Project - Positioning and Location Based Services
% A.A. 2023/2024
%
% Input: 
% files_path       --> path of the txt that contains data inserted by the user in jupyter
%
% Output: 
% OrbitRadius      --> radius of the orbit
% OrbitInclination --> inclination of the orbit 
% M0               --> mean anomaly
% Omega0           --> starting rigth ascension of the ascending node 
%
% This function reads data from a txt file that refers to a 
% specific satellite in a specific constellation 
% and extracts from it the orbit radius, the
% orbit inclination,the M0 and the Omega0.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [OrbitRadius,OrbitInclination,M0,Omega0] = ReadData(files_path)
    data = readtable(files_path);
    
    % Extract variables
    OrbitRadius = data{1,2};
    OrbitInclination = data{2, 2};
    M0 = data{3, 2};
    Omega0 = data{4, 2};

end