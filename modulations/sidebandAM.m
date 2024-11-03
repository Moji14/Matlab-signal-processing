% This file is a Matlab script that generates double side band AM
% modulations with carrier and without carrier and compares them.
% signals and plots them in time and frequency domains. It is
% a good basic introduction exercise  for signal processing. 
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
Ac=1;
Am=1;
Fc = 75;
Fm = 2;
carrier=Ac*sin(2*pi*Fc*t);
modulator=Am*sin(2*pi*Fm*t);

%DSB-FC(Double side band full carrier);
m=Am/Ac;                                          % Modulation index
AM=[1+m*modulator].*sin(2*pi*Fc*t);

%DSB-RC(Double side band reduced carrier)
DSB_RC=bandstop(AM,[74.9,75.1],Fs,StopbandAttenuation=23);

%DSB-SC(Double side band supressed carrier)
DSB_SC=modulator.*carrier;


%Time domain plots
subplot(4,2,1); plot(t,horzcat(carrier(1:L/2),modulator(1:L/2))); title('Carrier & Modulator');
subplot(4,2,3); plot(t, AM); title('AM modulation');
subplot(4,2,5); plot(t, DSB_RC); title('DSB-RC modulation');
subplot(4,2,7); plot(t, DSB_SC); title('DSB-SC modulation');xlabel('time (s)');

%Frequency domain
freq_vector=Fs/L*[0:L/2-1];

%Magnitude of Fourier transform
abs_carrier=abs(fft(carrier)/L);
abs_modulator=abs(fft(modulator)/L);
abs_AM=abs(fft(AM)/L);
abs_DSB_RC=abs(fft(DSB_RC)/L);
abs_DSB_SC=abs(fft(DSB_SC)/L);

%Positives frequencies discrimination
carrier_spectrum=abs_carrier(1:L/2);
modulator_spectrum=abs_modulator(1:L/2);
AM_spectrum=abs_AM(1:L/2); 
DSB_RC_spectrum=abs_DSB_RC(1:L/2); 
DSB_SC_spectrum=abs_DSB_SC(1:L/2);

%Freq domain plotting
subplot(4,2,2); plot(freq_vector,carrier_spectrum); title('Carrier & Modulator');
hold on
subplot(4,2,2); plot(freq_vector,modulator_spectrum);
hold off
subplot(4,2,4); plot(freq_vector,AM_spectrum); title('AM modulation');
subplot(4,2,6); plot(freq_vector,DSB_RC_spectrum); title('DSB-RC modulation');
subplot(4,2,8); plot(freq_vector,DSB_SC_spectrum); title('DSB-SC modulation');xlabel('Frequency (Hz)');
