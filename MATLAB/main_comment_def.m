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

%% Load Almanac

% Define the folder path where your text files are located
folderPath = 'C:\Users\emmal\Documents\GitHub\SimuLEO\Almanacs040352'; 

% Define the file name
fileName = 'LEO0203.txt';

% Create the full file path using fullfile
filePath = fullfile(folderPath, fileName);

data = readtable(filePath);

% Extract variables
%SatelliteName = data.SatelliteName;
OrbitRadius = data{1,2};
OrbitInclination = data{2, 2};
M0 = data{3, 2};
Omega0 = data{4, 2};

% Display extracted variables
%disp(satelliteName);
disp(OrbitRadius);
disp(OrbitInclination);
disp(M0);
disp(Omega0);

%% Load Almanac of satellite SVN 63, PRN 01 (Block IIR) for 2016
% Almanac of satellite SVN 63, PRN 01 (Block IIR) for 2016, 11, 28
dt0 = -7.661711424589e-05;
dt1 = -3.183231456205e-12;
dt2 = 0.000000000000e+00;
sqrt_a = 5.153650835037e+03; %(sqrt of meters)
a = sqrt_a^2;
e = 3.841053112410e-03; 
M0 = 1.295004883409e+00; %(radians) %mean anomaly
Omega0 = -2.241692424630e-01; %(radians)
Omegadot = -8.386063598924e-09; %(radians/sec)
i0 = 9.634782624741e-01; %(radians)
idot = -7.286017777600e-11; %(radians/sec)
w0 = 9.419793734505e-01; %(radians)
wdot = 0.0;  %(radians/sec)
GMe = 3.986005e+14; %(m3/s2)
OmegaEdot = 7.2921151467e-05; %(radians)
eta0 = M0;

%% 0. Initialize vector of epochs 
t_0 = 0; %[sec]
t_end = 23*3600+59*60; %[sec]
D_t = 30; %[sec]
t = [t_0:D_t:t_end];

%% 2. Compute positions in ITRF, X, Y, Z
% Initialize vector of positions
eta = zeros(1,length(t));
eta(1) = M0;
psi = zeros(1,length(t));
r_t = zeros(1,length(t));
x_t = zeros(1,length(t));
y_t = zeros(1,length(t));
w = zeros(1,length(t));
f= zeros(1,length(t));
W = zeros(1,length(t));
ORS = zeros(length(t), 3);

% compute the mean angular velocity
n = sqrt(GMe/a^3); 

% Fill the previous vectors
i=1;
for Dt = t_0 : D_t : (t_end - t_0)
    M_t = M0 + n*Dt;
    %compute eta
        eta(i) = ecc_anomaly(M_t, e);  
    % compute psi
       psi(i) = atan2(sqrt(1-e^2).*sin(eta(i)), (cos(eta(i) - e))); 
    % compute r 
       r_t(i) = a*(1-e^2)/(1+e*cos(psi(i))); 
    % compute w(t)=w0+wdot*(t-t0)
       w(i)= w0 + wdot*(t(i)-t_0);
    % compute i(t)
       f(i)= i0 + idot*(t(i)-t_0);
    % compute W(t)
       W(i)=Omega0+(Omegadot - OmegaEdot)*Dt;
    % compute x(t)
       x_t(i)=r_t(i)*cos(psi(i));
    % compute y(t)
       y_t(i)=r_t(i)*sin(psi(i));
i=i+1;
end
ORS = [x_t' y_t' zeros(length(t), 1)]; % axis z is 0 because the orbital plane
                                       % lays on the x,y plane

% Fill three rotation matrices and rotate from ORS to ITRF
ITRF = zeros(length(t), 3);
ITRF_geod = zeros(length(t), 3);
for i=1:length(t) 
R1=[1 0 0 ; 0 cos(f(i)) -sin(f(i)); 0 sin(f(i)) cos(f(i))];
R31=[cos(W(i)) -sin(W(i)) 0; sin(W(i)) cos(W(i)) 0; 0 0 1];
R32=[cos(w(i)) -sin(w(i)) 0; sin(w(i)) cos(w(i)) 0; 0 0 1];
R=R31*R1*R32;
X_LL=ORS(i, :); %we suppose that the ORS could be seen as a LL RS
X_LC=R*X_LL'; %We transform the LL RS in the LC RS (from ORS to ICRS) with the rotation matrix
ITRF(i, :) = X_LC';
% From Local cartesian to Geodetic 
[lat, lon, h] = Cart2Geod(X_LC(1),X_LC(2),X_LC(3));
ITRF_geod(i, :) = [lat, lon, h];
end 

%% 4. Plot satellite's daily trajectory with basemap
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

%Print results on a file
fid = fopen('GPS_KeplerianOrbit_6parameters.txt','w');

fprintf(fid,'EXPORT FROM MATLAB: GPS_orbit_est.m \n\n');
fprintf(fid,' * Coordinates ORS (xF, yF) || Coordinates ITRF (x, y, z) || Coordinates phi, lambda, h ell\n\n');
for i = 1 : length(Dt)
    fprintf(fid, ' %15.6f  %15.6f %15.6f || %15.6f  %15.6f  %15.6f || %15.6f  %15.6f  %15.6f \n',lat,lon,h);
end
fprintf(fid, '\n');


fclose(fid);        %or fclose('all');

save solution2.mat




  

    