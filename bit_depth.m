% This file is a Matlab script that generates a reference signal and then
% analyzes the derived quantized signals with different bit depths.
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
Fs=1000;
Ts=1/Fs;
L=1000;
t=[0:L-1]*Ts;
freq_vector=t*Fs;
Fc=10;
% Reference signal
sinewave_64b=sinpi(2*Fc*t);

% Quantized signals
sinewave_32b=round(sinewave_64b*(2^31-1))/(2^31);
sinewave_16b=round(sinewave_64b*(2^15-1))/(2^15);
sinewave_8b=round(sinewave_64b*(2^6-1))/(2^6-1);

figure; snr(sinewave_64b);txt = ('\leftarrow Ref. signal 64bits'); text(25,-150,txt);
figure, snr(sinewave_32b);txt=('\leftarrow Quantized signal 32bits');text(25,-100,txt);
figure; snr(sinewave_16b);txt=('\leftarrow Quantized signal 16bits');text(25,-50,txt);
figure; snr(sinewave_8b);txt=('\leftarrow Quantized signal 8bits');text(25,-20,txt);
