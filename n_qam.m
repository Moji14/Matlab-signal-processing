% This file is a Matlab script generates an  QAM modulation
% signals and plots the modulator and the modulated signal in time
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2, or (at your option)
% any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.

%Time specifications:
Fs = 1000;                            % Sampling Frequency (samples per second)
Ts = 1/Fs;                            % Sampling Period (seconds per sample)
L=1000;                               % Time vector lenght (total samples)
t = [0:L-1]*Ts;                       % Time vector

% Local oscillators for IQ modulation  
FLO = 100; ALO = 1;
LO_inpahse = ALO * cos(2*pi*FLO*t);
LO_90 = ALO * sin(2*pi*FLO*t);

%4 Symbol generation
N=4;                                  %Number of levels
Br=FLO/10;                       %

% Generic random signal
data = randi([0 N-1],1,Br);           %N Symbol generation

% Calculate the size of the new I and Q vectors (half the original size, rounded down)
newSize = floor(length(data) / 2);

% I and Q signals generation
% Pre-allocate the new vectors for efficiency
Idata = zeros(1, newSize);
Qdata= zeros(1, newSize);

% Loop through the original vector in pairs
for i = 1:2:length(data)
    % Check for even or odd number of elements (handle last element if odd)
    if i + 1 <= length(data)
        Idata((i + 1)/2) = data(i);
        Qdata((i + 1)/2) = data(i + 1);
    else
        Idata(i/2) = data(i);
    end
end

Idata_mod= repelem(Idata,2*Fs/Br);
Qdata_mod= repelem(Qdata,2*Fs/Br);

nQAM = LO_inpahse .* Idata_mod + LO_90 .* Qdata_mod;

% Data
subplot(4,2,[1,2]); plot(repelem(data,2*Fs/Br));title('Random data');

% I and Q modulators
subplot(4,2,3); plot(Idata_mod);title('I data');
subplot(4,2,4); plot(Qdata_mod);title('Q data');

% I and Q modulated by LO's
subplot(4,2,5); plot(LO_inpahse .* Idata_mod);title('Modulated I component');
subplot(4,2,6); plot(LO_90 .* Qdata_mod);title('Modulated Q component');

% n-QAM modulation
subplot(4,2,[7,8]); plot(nQAM);title('nQAM modulation');