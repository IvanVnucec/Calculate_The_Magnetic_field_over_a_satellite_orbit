% Copyright (c) 2019, Ivan Vnuèec
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

% This code uses modified version of Ennio Condoleo program which can be
% found here:
% https://www.mathworks.com/matlabcentral/fileexchange/45573-orbit3d

% NOTICE:
% THIS PROGRAM IS NOT TESTED IN ANY WAY AND IT SHOULD BE USED WITH THAT IN 
% MIND.

%% TEST VALUES
RAAN    =  38;                % Right Ascension of Ascendent Node [deg]
w       =  35;                % Argument of perigee               [deg]
v0      =  54;                % True anomaly at the departure     [deg]
i       =  51.64;             % inclination                       [deg]
a       =  6700;              % Major semi-axis           (>6378) [km]
e       =  0.001;             % Eccentricity
start_time = datetime('now'); % UTC time of sattelite starting point
norb = 5;                     % number of orbits
time_step = 60;               % Calculate point every time_step   [s],
                              %   decrease for faster calculation

%% CALCULATION
[lla, time] = orbit_calc(RAAN, w, v0, i, a, e, start_time, norb, ...
    time_step);

[B, H, D, I, F] = b_calc(lla, time);

%% PLOTTING
subplot(3,1,1)
plot(F);
title('F')
xlabel('point num') 
ylabel('[nT]') 

subplot(3,1,2)
plot(D);
title('D')
xlabel('point num') 
ylabel('[deg]')  

subplot(3,1,3)
plot(I);
title('I')
xlabel('point num') 
ylabel('[deg]') 