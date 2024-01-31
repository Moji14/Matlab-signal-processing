%sampling test
% This file is a Matlab script that compares how signal length affect the
% result of the FFT accuracy.
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
Fs=100;
Ts=1/Fs;

%Signal 1
L1=100;
t1=[0:L1-1]*Ts;

Fx=10;
x1=square(sin(2*pi*Fx*t1));
%Time domain plot
subplot(3,2,1);plot(t1,x1);title('X1');xlabel('Time (s)');ylabel('Amplitude (V)');
%Frequency domain plot
freq_vector1=[0:L1-1]*Fs/L1;
FFTx1=abs(fft(x1)/L1);
subplot(3,2,2);semilogx(freq_vector1(1:L1/2),10*log10(FFTx1(1:L1/2)));title('FFT of X1');xlabel('Freq (Hz)');ylabel('Power (dB)');

%Signal2

L2=100;
t2=[0:L2-1]*Ts;

Fx2=10;
x2=square(sin(2*pi*Fx2*t2));

subplot(3,2,3);plot(t2,x2);title('X2=X1');xlabel('Time (s)');ylabel('Amplitude (V)');

n_point=10*L2;
freq_vector2=[0:n_point-1]*Fs/n_point;
FFTx2=abs(fft(x2,n_point)/L2);
subplot(3,2,4);semilogx(freq_vector2(1:n_point/2),10*log10(FFTx2(1:n_point/2)));title('FFT of X1 with zero padding');ylabel('Power (dB)');

%Signal 3
L3=1000;
t3=[0:L3-1]*Ts;

Fx=10;
x3=square(sin(2*pi*Fx*t3));
%Time domain plot
subplot(3,2,5);plot(t3,x3);title('X3=X1 10x longer');xlabel('Time (s)');ylabel('Amplitude (V)');
%Frequency domain plot
freq_vector3=[0:L3-1]*Fs/L3;
FFTx3=abs(fft(x3)/L3);
subplot(3,2,6);semilogx(freq_vector3(1:L3/2),10*log10(FFTx3(1:L3/2)));title('FFT of X3=X1 10x longer');xlabel('Freq (Hz)');ylabel('Power (dB)');
