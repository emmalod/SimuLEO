function [eta,eta_deg] = sat_altitude(loc_coords)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

eta = zeros(length(loc_coords),1);

for i = 1:length(loc_coords)

    eta(i) = atan(loc_coords(i,3)/sqrt(loc_coords(i,1)^2 + loc_coords(i,2)^2));
    eta_deg(i) = eta(i)*180/pi;

end

end