function [lla, time] = orbit_calc( RAAN, w, v0, i, a, ...
    e, start_time, n_orb, step )
% [lla, time] = orbit_calc( RAAN, w, v0, i, a, ...
%   e, start_time, n_of_orb, t_step )
%
% INPUTS:
% RAAN         Right Ascension of Ascendent Node  (0, 360) [deg]
% w            Argument of perigee                (0, 360) [deg]
% v0           True anomaly at the departure      (0, 360) [deg]
% i            Inclination                        (-90, 90)[deg]
% a            Major semi-axis                    (>6378)  [km]
% e            Eccentricity
% start_time   UTC time of sattelite on starting point     [date]
% n_orb        Number of orbits (can be decimal number ex. 0.5)
% step         Every t_step calculate orbit point          [s]
%
% OUTPUTS:
% lla          Row vectors of: latitude, longitude, altitude
% time         Datetime var of every orbit point

RE = 6378;          % Earth's radius                          [km]
muE = 398600.44;    % Earth gravitational parameter           [km^3/sec^2]
ecc_max = 1-RE/a;     % maximum value of eccentricity allowed
if e>ecc_max
    error('e > ecc_max');
end
% --------------------------------- CONV ---------------------------------%
RAAN  = RAAN*pi/180;        % RAAN                          [rad]
w     = w*pi/180;           % Argument of perigee           [rad]
v0    = v0*pi/180;          % True anomaly at the departure [rad]
i     = i*pi/180;           % inclination                   [rad]
% ------------------------------------------------------------------------%
%% ORBIT COMPUTATION
rp = a*(1-e);               % radius of perigee             [km]
ra = a*(1+e);               % radius of apogee              [km]
Vp = sqrt(muE*(2/rp-1/a));  % velocity at the perigee       [km/s]
Va = sqrt(muE*(2/ra-1/a));  % velocity at the  apogee       [km/s]
n  = sqrt(muE./a^3);        % mean motion                   [rad/s]
T  = 2*pi/n;                % period                        [s]
%% PRINT SOME DATAS
hou = floor( T/3600);                
min = floor((T-hou*3600)/60);  
sec = floor( T-hou*3600-min*60); 
fprintf('\n Radius of perigee [%.2f km]'   , rp);
fprintf('\n Altitude of perigee [%.2f km]' , rp-RE);
fprintf('\n Radius of  apogee [%.2f km]'   , ra);
fprintf('\n Altitude of  apogee [%.2f km]' , ra-RE);
fprintf('\n Velocity at the perigee [%.4f km/s]' , Vp);
fprintf('\n Velocity at the apogee [%.4f km/s]'  , Va);
fprintf('\n Orbital Period [%d h: %d m: %d s] ', hou, min, sec);
fprintf('= [%.0f s]\n', T);
%% TIME
t0   = 0;                          % initial time          [s]
tf   = n_orb*T;                    % final   time          [s]
t    = t0:step:tf+step;            % vector of time        [s]
%% DETERMINATION OF THE DYNAMICS
cosE0 = (e+cos(v0))./(1+e.*cos(v0));     % cos of initial eccentric anomaly
sinE0 = (sqrt(1-e^2).*sin(v0))./(1+e.*cos(v0));  % sin of initial e.a.
E0 = atan2(sinE0,cosE0);                         % initial e.a.    [rad]
if (E0<0)                                        % E0 = [0,2pi]
    E0=E0+2*pi;
end
tp = (-E0+e.*sin(E0))./n+t0;            % pass time at the perigee [s]
M  = n.*(t-tp);                         % mean anomaly             [rad]
%% Mk = Ek - e*sin(Ek);
% Eccentric anomaly (must be solved iteratively for Ek)
E = zeros(size(t,2),1);
for j=1:size(t,2)
    E(j) = anom_ecc(M(j),e);                     % eccentric anomaly  [rad]
end
%% True anomaly, Argument of latitude, Radius
sin_v = (sqrt(1-e.^2).*sin(E))./(1-e.*cos(E));  % sin of true anomaly
cos_v = (cos(E)-e)./(1-e.*cos(E));              % cosine of true anomaly
v     = atan2(sin_v,cos_v);                     % true anomaly        [rad]
theta = v + w;                                  % argument of latitude[rad]
r     = (a.*(1-e.^2))./(1+e.*cos(v));           % radius               [km]
%% Satellite coordinates
% "Inertial" reference system ECI (Earth Centered Inertial)
% xp = In-plane x position (node direction)             [km]
% yp = In-plane y position (perpendicular node direct.) [km]
xp = r.*cos(theta);                          
yp = r.*sin(theta);                          
xs = xp.*cos(RAAN)-yp.*cos(i).*sin(RAAN);    % ECI x-coordinate SAT   [km]
ys = xp.*sin(RAAN)+yp.*cos(i).*cos(RAAN);    % ECI y-coordinate SAT   [km]
zs = yp.*sin(i);                             % ECI z-coordinate SAT   [km]

% Datetime var calculation for every orbit point
time = start_time + seconds(t);             
t_year   = year(time);
t_month  = month(time);
t_day    = day(time);
t_hour   = hour(time);
t_minute = minute(time);
t_second = second(time);

lla = zeros(numel(t), 3);

% Notice that for eci2lla funct we need to convert ECI from [km] to [m]
for j = 1:numel(t)
    lla(j,:) = eci2lla([xs(j) ys(j) zs(j)] * 1000, ...
        [t_year(j) t_month(j) t_day(j) t_hour(j) t_minute(j) t_second(j)]);
end

end


% Copyright (c) 2014, Ennio Condoleo
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
%
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in the
%       documentation and/or other materials provided with the distribution
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
% IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
% THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
% PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
% CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
% EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
% PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
% PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
% LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
% NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

% This code is modified version of Ennio Condoleo program which can be
% found here:
% https://www.mathworks.com/matlabcentral/fileexchange/45573-orbit3d
