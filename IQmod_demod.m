% This file is a Matlab script generates an IQ modulation and demodulation
% signals and plots the modulator, modulated and demod signals in time.
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

% Time specifications:
Fs = 1000;                            % Sampling Frequency (samples per second)
Ts = 1/Fs;                            % Sampling Period (seconds per sample)
L=1000;                               % Time vector lenght (total samples)
t = [0:L-1]*Ts;                       % Time vector

% Generic signal
Fsignal=1; AI=1; AQ=1;
I = AI * cos(2*pi*Fsignal*t);
Q = AQ * sin(2*pi*Fsignal*t);

% Local oscillators for IQ modulation  
FLO = 100; ALO = 1;
LO_inpahse = ALO * cos(2*pi*FLO*t);
LO_90 = ALO * sin(2*pi*FLO*t);

% IQ Modulator
IQ = I .* LO_inpahse + Q .* LO_90;

% IQ Demodulator
Idem = IQ .* LO_inpahse;
Qdem = IQ .* LO_90;

% Plotting
subplot(3,3,1);plot(t,I,'white');title(' I signal');xlabel('time (s)');set(gca,'color','black')
subplot(3,3,4);plot(t,Q,'blue');title('Q signal');xlabel('Frequency (Hz)');set(gca,'color','black')

subplot(3,3,2);plot(t,I.*LO_inpahse,'white');title(' I*LO signal');xlabel('time (s)');set(gca,'color','black')
subplot(3,3,5);plot(t,Q.*LO_90,'blue');title('Q*LO-90 signal');xlabel('Frequency (Hz)');set(gca,'color','black')

subplot(3,3,7);plot(t,I+Q,'yellow');title('I+Q');xlabel('time (s)');set(gca,'color','black')
subplot(3,3,8);plot(t,IQ,'yellow');title('IQ modulation');xlabel('time (s)');set(gca,'color','black')

subplot(3,3,3);plot(t,lowpass(Idem,1,Fs),'white');title(' I dem signal');xlabel('time (s)');set(gca,'color','black')
subplot(3,3,6);plot(t,lowpass(Qdem,1,Fs),'blue');title('Q dem signal');xlabel('Frequency (Hz)');set(gca,'color','black')
