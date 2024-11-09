% This file is a Matlab script generates an  SSB modulation, USB in this
% case, and plots the modulator and the modulated signal in time and
% frequency domain.
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
freq_vector= t*Fs^2/L;

Fm=10;                                % Modulator frequency
Fc=100;                               % Carrier frequency

modulator=cos(2*pi*Fm*t);                     

analytic_s=imag(hilbert(modulator));

ssb= modulator .* cos(2*pi*Fc*t) - analytic_s.* sin(2*pi*Fc*t);

fft_ssb=abs(fft(ssb)/L);

figure;
subplot(4,1,1);plot(t,modulator);hold on; plot(t,analytic_s);hold off;
title('Modulator (blue) & Analyltic signal (red)');
subplot(4,1,2);plot(freq_vector,mag2db(abs(fft(modulator)/L)));
title('Modulator &/or Analytic signal FFT');
subplot(4,1,3);plot(t, ssb);
title('USB (Upper Side Band)');
subplot(4,1,4);plot(freq_vector,mag2db(fft_ssb));
title('USB FFT');