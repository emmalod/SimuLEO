%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Geoinformatics Project - Positioning and Location Based Services
% A.A. 2023/2024
%
% SimuLEO
% 
% Angelica Iseni, Emma Lodetti
% 
% References:
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
close all
clc

set(0,'DefaultFigureWindowStyle','docked');

%% Read data from txt files and compute position for each second in a day for each satellite

% Define the folder path where your text files are located
InputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\Almanacs010180';
OutputFolderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\SatellitePositions010180';

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
    [ITRF_geod, ORS, ITRF] = ITRF_positions(t,t_0,t_end,D_t,OrbitRadius,OrbitInclination,M0,Omega0);

    % Save position matrix in a txt file in the output folder
    SavePositions(ITRF_geod, InputFileName, OutputFolderPath);

end


%% Plot satellite's daily trajectory with basemap
figure(1);

% H = subplot(m,n,p), or subplot(mnp), breaks the Figure window
% into an m-by-n matrix of small axes

% Plot groundtracks
subplot(3,1,1:2);
% axesm Define map axes and set map properties
ax = axesm ('eqdcylin', 'Frame', 'on', 'Grid', 'on', 'LabelUnits', 'degrees', 'MeridianLabel', 'on', 'ParallelLabel', 'on', 'MLabelParallel', 'south');
% geoshow Display map latitude and longitude data 
%  DISPLAYTYPE can be 'point', 'line', or 'polygon' and defaults to 'line'
geoshow('landareas.shp', 'FaceColor', 'black');
hold on
geoshow(ITRF_geod(:,1)*180/pi,ITRF_geod(:,2)*180/pi, 'DisplayType', 'point', 'MarkerEdgeColor', 'green');
% axis EQUAL  sets the aspect ratio so that equal tick mark
% increments on the x-,y- and z-axis are equal in size.
% axis TIGHT  sets the axis limits to the range of the data.
axis equal; axis tight;

% Plot height of the satellite 
subplot(3,1,3);
plot(t,(ITRF_geod(:,3)-mean(ITRF_geod(:,3)))*1e-3, '.g');
title(['ellipsoidic height variations [km] around mean height = ',num2str(mean(ITRF_geod(:,3))*1e-3),' km']);
xlabel('seconds in one day (00:00 - 23:59 = 86400 sec)');
ylabel('[km]');
xlim([1 t(end)]);

%% Print results on a file
fid = fopen('GPS_KeplerianOrbit_6parameters.txt','w');

fprintf(fid,'EXPORT FROM MATLAB: GPS_orbit_est.m \n\n');
fprintf(fid,' * Coordinates ORS (xF, yF) || Coordinates ITRF (x, y, z) || Coordinates phi, lambda, h ell\n\n');
for i = 1 : length(Dt)
    fprintf(fid, ' %15.6f  %15.6f %15.6f || %15.6f  %15.6f  %15.6f || %15.6f  %15.6f  %15.6f \n',lat,lon,h);
end
fprintf(fid, '\n');


fclose(fid);        %or fclose('all');

save solution2.mat

%% Txt converter

Data = load('ORS.mat');
DataField = fieldnames(Data);
writematrix('ORS.txt', Data.(DataField{1}));

%% Plot ORS last satellite

figure;
plot(ORS(:,1), ORS(:,2),'*');
title('Coordinates in ORS of satellite LEO0202');
xlabel('x ORS');
ylabel('y ORS');
%xlim([1 t(end)]);

%% Plot ICRS last satellite

figure;
plot(ICRS(:,1), ICRS(:,2));
title('Coordinates in IRCS of satellite LEO0202');
xlabel('x ICRS');
ylabel('y ICRS');
%xlim([1 t(end)]);

%% Plot X_ITRF last satellite wrt time 

figure;
plot(ITRF(1:60,1),t(1:60),'-');
title('Coordinates in ITRF of satellite LEO0202');
xlabel('x ITRF');
ylabel('time');

%% Plot Y_ITRF last satellite wrt time 

figure;
plot(ITRF(1:60,2),t(1:60),'-');
title('Coordinates in ITRF of satellite LEO0202');
xlabel('y ITRF');
ylabel('time');

%% Plot X_ITRF, Y_ITRF in time 
plot3(ITRF(1:60,1),ITRF(1:60,2),t(1:60));
xlabel('x ITRF');
ylabel('y ITRF')
zlabel('time');

hold on;
%Plot X_ITRF_geod, Y_ITR_geod in time 
plot3(ITRF(1:60,1),ITRF(1:60,2),t(1:60));
xlabel('x ITRF');
ylabel('y ITRF')
zlabel('time');

%% Plot ITRF_geod last satellite

ITRF_geod_deg_lat = ITRF_geod(:,1);
ITRF_geod_deg_long = ITRF_geod(:,2);

plot3(ITRF_geod_deg_lat(1:60),ITRF_geod_deg_long(1:60),t(1:60));
xlabel('x ITRF');
ylabel('y ITRF')
zlabel('time');
%%

figure;

ax = axesm ('eqdcylin', 'Frame', 'on', 'Grid', 'on', 'LabelUnits', 'degrees', 'MeridianLabel', 'on', 'ParallelLabel', 'on', 'MLabelParallel', 'south');
geoshow('landareas.shp', 'FaceColor', 'black');
hold on
%geoshow(ITRF_geod(1000,1)*180/pi,ITRF_geod(1000,2)*180/pi, 'DisplayType', 'line', 'MarkerEdgeColor', 'green');
geoshow(ITRF_geod(:,1),ITRF_geod(:,2), 'DisplayType', 'point', 'MarkerEdgeColor', 'green');
title('Coordinates in ITRF_geod of satellite LEO0202');
xlabel('longitude');
ylabel('latitude');

%%

figure
plot(ITRF_geod(1:3600*2,2),ITRF_geod(1:3600*2,1),'ro')




  

    