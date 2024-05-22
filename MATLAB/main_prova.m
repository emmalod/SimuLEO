%% position script

InputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\Almanacs040470';
OutputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\SatellitePositions040470';

SimuLEO_f(InputFolderPath,OutputFolderPath)

%% PDOP script

t = 13*3600 + 15*60 + 30; % ore 13:15:30
x0 = 0;
y0 = 0;
z0 = 0;
% Xs -> txt

InputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\SatellitePositions040470';

SimuLEO_pdop(InputFolderPath,t,x0,y0,z0)
