%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geoinformatics Project - Positioning and Location Based Services
% A.A. 2023/2024
%
% SimuLEO - Low Earth Orbit satellites Simulator
%
% Angelica Iseni, Emma Lodetti
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
close all
clc

%set(0,'DefaultFigureWindowStyle','docked');

%% Read data from txt files and compute position for each second in a day for each satellite

% Define the folder path where your text files are located
InputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\Almanacs040470';
OutputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\SatellitePositions040470';

% List all files in the folder
files = dir(fullfile(InputFolderPath, '*.txt'));

% Initialize vector of epochs
t_0 = 0; %[sec]
t_end = 24*3600; %[sec]
D_t = 1; %[sec]
t = t_0:D_t:t_end;

% Loop through each file in the folder
for i = 1:length(files)
    % Get the file name
    InputFileName = files(i).name;

    % Create the full file path
    InputFilePath = fullfile(InputFolderPath, InputFileName);

    % Read data
    [OrbitRadius,OrbitInclination,M0,Omega0] = ReadData(InputFilePath);

    % Compute ITRF positions each second of the day
    [ITRF_geod] = ITRF_positions(t,t_0,t_end,D_t,OrbitRadius,OrbitInclination,M0,Omega0);

    % Save position matrix in a txt file in the output folder
    SavePositions(ITRF_geod, InputFileName, OutputFolderPath);

end










