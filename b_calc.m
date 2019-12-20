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

%% Copyright (c) 2019, Ivan Vnuèec
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