% This file is a Matlab script that generates a complex chirp
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
Fs=1000;
Ts=1/Fs;
L=1000;
t=[0:L-1]*Ts;
Fc=100;
%Complex chirp parameters and function
F0=0;
F1=10;
t0=0;
t1=1;
T=t1-t0; 
phasor=exp(j*2*pi*( ((F1-F0)/2*T)*t.^2+F0*t ));

%IQ modulation
IQmod=real(phasor).*cos(2*pi*Fc*t)+imag(phasor).*sin(2*pi*Fc*t);

%IQ demodulation and fltering
I=lowpass(IQmod.*cos(2*pi*Fc*t),1,Fs);
Q=lowpass(IQmod.*sin(2*pi*Fc*t),1,Fs);


%Plotting
figure; subplot(3,1,1); plot(t,real(phasor)); hold on; plot(t,imag(phasor)); hold off;

subplot(3,1,2); plot(t,IQmod);

subplot(3,1,3); plot(t,I);hold on;plot(t,Q);hold off;

figure; plot(Fs*t, abs(fft(phasor)/L));

figure; plot(Fs*t, abs(fft(IQmod)/L));
