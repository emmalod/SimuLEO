%% position script

InputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\Almanacs040470';
OutputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\SatellitePositions040470';

SimuLEO_f(InputFolderPath,OutputFolderPath)

%% PDOP script

t = 13*3600 + 15*60 + 30; % ore 13:15:30
x_0 = 0;
y_0 = 0;
z_0 = 0;

InputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\SatellitePositions040470';
OutputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\mask_prova';

SimuLEO_pdop(InputFolderPath,OutputFolderPath, t,x_0,y_0,z_0)
