function [b, h, d, i, f] = b_calc(lla, time)
%function [b, h, d, i, f] = b_calc(lla, time)
% INPUTS:
% lla       Row vectors of: latitude, longitude, altitude [deg], [deg], [m]
% time      Datetime var of every orbit point   [datetime, see matlab]
%
% OUTPUTS:
% b         Column vectors of magnetic field vector     [nT]
% h         Horizontal component of b                   [nT]
% d         Declination                                 [deg]
% i         Inclanation                                 [deg]
% f         Intensity                                   [nT]

latitude  = lla(:, 1);
longitude = lla(:, 2);
altitude  = lla(:, 3);

h =  zeros(1, size(lla, 1));                       
d =  zeros(1, size(lla, 1));                           
i =  zeros(1, size(lla, 1));                           
f =  zeros(1, size(lla, 1));                       
bx = zeros(1, size(lla, 1));       
by = zeros(1, size(lla, 1));       
bz = zeros(1, size(lla, 1));  

for j = 1:size(lla, 1)
    [B, h(j), d(j), i(j), f(j)] = igrfmagm(altitude(j), latitude(j), ...
        longitude(j), decyear(time(j)), 12);
    bx(j) = B(1);
    by(j) = B(2);
    bz(j) = B(3);
end

b = [bx ; by; bz];
end