% This file is a Matlab script generates a PAM modulation
% signal and plots the analog modulator, carriera and the modulated signal 
% in the time domain
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

% Modulator signal
Fmodulator = 2; Am = 1; modulator = Am * sin(2*pi*Fmodulator*t);                    %

% Pulse train (periodic square wave offested and normalized to 1, used as a
% pulse train.
dutycycle=25;
ptrain=0.5.*(1+square(2*pi*30*t,dutycycle));

% Alternative pulse train generation method
%y=pulstran(t,[0:20*Ts:5;sin(2*pi*2.*[0:20*Ts:5])]','rectpuls',5*Ts);

% PAM modulation
PAM = modulator .* ptrain;

figure;
subplot(3,1,1);plot(t,ptrain);title('Pulse train (carrier)');
subplot(3,1,2);plot(t,modulator);title('Modulator (analog sinewave)');
subplot(3,1,3);plot(t,PAM);title('PAM modulation');
