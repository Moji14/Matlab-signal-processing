% This file is a Matlab script generates a carrier, modulator, AM, FM
% signals and plots them in time domain as well as frequency domain. It is
% a good basic introduction ecercise  for signal processing. 
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
Fs = 1000;                             % Sampling Frequency (samples per second)
Ts = 1/Fs;                            % Sampling Period (seconds per sample)

L=1000;                                % Time vector lenght (total samples)
t = [0:L-1]*Ts;                       % Time vector

%Signals                   
Fcarrier = 75; Ac = 1; carrier = Ac * sin(2*pi*Fcarrier*t);
Fmodulator = 2; Am = 1; modulator = Am * sin(2*pi*Fmodulator*t);
                      
%Modulation
AM = carrier.*modulator;

Kf = 50;                                                                         % Modulator sensitivity
F_delta = Kf * Am;                                                               % Peak deviation
FM= Ac * cos(2*pi*(Fcarrier*t+F_delta*cumtrapz(t,modulator)));                  % Realistic model
%FM = Ac * cos(2*pi*Fcarrier*t + F_delta/Fmodulator * sin(2*pi*Fmodulator*t));   % Sinusoidal continuous wave aproximation
%FM = fmmod(modulator,Fcarrier, Fs, F_delta);                                    % Matlab function

%Time domain plots
subplot(4,2,1); plot(t, carrier); title('Carrier');
subplot(4,2,3); plot(t, modulator); title('Modulator');
subplot(4,2,5); plot(t, AM); title('AM modulation');
subplot(4,2,7); plot(t, FM); title('FM modulation');xlabel('time (s)');

%Frequency domain
freq_vector=Fs/L*[0:L/2-1];

%Magnitude of Fourier transform
abs_carrier=abs(fft(carrier)/L);
abs_modulator=abs(fft(modulator)/L);
abs_AM=abs(fft(AM)/L);
abs_FM=abs(fft(FM)/L);

%Positives frequencies discrimination
carrier_spectrum=abs_carrier(1:L/2); 
modulator_spectrum=abs_modulator(1:L/2);
AM_spectrum=abs_AM(1:L/2); 
FM_spectrum=abs_FM(1:L/2);

%Freq domain plotting   
subplot(4,2,2); plot(freq_vector,carrier_spectrum); title('Carrier');
subplot(4,2,4); plot(freq_vector,modulator_spectrum); title('Modulator');
subplot(4,2,6); plot(freq_vector,AM_spectrum); title('FM full spectrum');
subplot(4,2,8); plot(freq_vector,FM_spectrum); title('FM modulation');xlabel('Frequency (Hz)');
