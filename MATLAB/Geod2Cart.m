function [X,Y,Z] = Geod2Cart(phi,lambda,h)

%This function converts the geodetic ITRF coordinates to global cartesian
%coordinates

    a = 6378137; %major semiaxis
    e = 0.0818191908426215; %eccentricy
    b = a*sqrt(1-e^2); %minor semiaxis
    
    X = zeros(length(phi), 1);
    Y = zeros(length(phi), 1);
    Z = zeros(length(phi), 1);

    for i = 1:length(phi)
    
        Rn = a/sqrt(1-(e^2*(sin(phi(i)))^2));
        
        X(i) = (Rn+h(i))*cos(phi(i))*cos(lambda(i));
        Y(i) = (Rn+h(i))*cos(phi(i))*sin(lambda(i));
        Z(i) = (Rn*(1-e^2)+h(i))*sin(phi(i));
    
    end

end