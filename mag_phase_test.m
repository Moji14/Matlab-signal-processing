% Magnitude and Phase test
% This file is a Matlab script that compares different methods to calculate
% and plot magnitude and phase of a given signal.
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
f = 1000;                            % Sampling Frequency (samples per second)
Ts = 1/f;                            % Sampling Period (seconds per sample)
N=1000;                              % Time vector lenght (total samples)
time = [0:N-1]*Ts;                   % Time vector

%Signals                   
Fcarrier = 10; Ac = 1; carrier = Ac * cos(2*pi*Fcarrier*time);

%Time domain plotting
subplot(4,2,1);plot(time(1:f/Fcarrier),carrier(1:f/Fcarrier));title('A (single period)');xlabel('Time (s)');ylabel('Amplitude (V)');
subplot(4,2,2);plot(time,carrier);title('A (full length)');xlabel('Time (s)');ylabel('Amplitude (V)');

%FFT calculation
X=fft(carrier)/N;
X=fftshift(X);

freq=linspace(-N/2,N/2,N);%Frequency vector

%Real and imaginary parts of X
subplot(4,2,3);plot(freq,real(X));title('Real(FFT(A))');xlabel('Freq (Hz)');
subplot(4,2,5);plot(freq,imag(X));title('Imaginary(FFT(A))');xlabel('Freq (Hz)');

%Module and phase of X
subplot(4,2,4);plot(freq,abs(X));title('Module(FFT(A))');xlabel('Freq (Hz)');
subplot(4,2,6);plot(freq,angle(X));title('"Noisy" Phase(FFT(A))');xlabel('Freq (Hz)');


X2=X;
threshold=max(abs(X)/10);
X2(abs(X)<threshold)=0; % determines the low-amplitude threshold
phase=atan2d(imag(X2),real(X2));

%Phase of X (2 methods)
subplot(4,2,7);plot(freq,phase);title('"Clean" Phase(FFT(A)) atan2 method');xlabel('Freq (Hz)');
subplot(4,2,8);plot(freq,angle(X2)*180/pi);title('"Clean" Phase(FFT(A)) angle method');xlabel('Freq (Hz)');