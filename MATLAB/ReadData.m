function [OrbitRadius,OrbitInclination,M0,Omega0] = ReadData(files_path)

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
% This function reads data from a txt file that refers to a specific
% satellite in a specific constellation and extracts orbit radius, orbit
% inclination, M0 and Omega0.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    fid = fopen(files_path, 'r');

    % Leggi i dati dal file
    data = fscanf(fid, '%*s %f');
    
    % Chiudi il file
    fclose(fid);
    
    % Estrai le variabili
    OrbitRadius = data(1);
    OrbitInclination = data(2);
    M0 = data(3);
    Omega0 = data(4);

end