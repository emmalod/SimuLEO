%% ITRF positions script

InputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\Almanacs040470';
OutputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\SatellitePositions040470';

SimuLEO_f(InputFolderPath,OutputFolderPath)

%% PDOP script

t = 21*3600 + 15*60 + 30;
phi_0 = 51.509865;
lambda_0 = -0.118092;

InputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\SatellitePositions040470';
OutputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\mask_prova';

PDOP = SimuLEO_pdop(InputFolderPath,OutputFolderPath,t,phi_0,lambda_0);
