% Continous Phase Frequency Shift Keying
% This file is a Matlab script generates an FSK modulation and plots the 
% modulator and the modulated signal in time as well as in frequency domain. 
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

%Signals                   
Fcarrier = 100; Ac = 1; carrier = Ac * sin(2*pi*Fcarrier*t);

%4 Symbol generation
N=4;                                  %Number of levels
Br=Fcarrier/10;                       %Keeps modulator and carrier frequencies related to reduce bandwidth due to discontinuities in frequencies

handle = figure; %Some Figure

hold on
while isvalid(handle)
    data = randi([0 N-1],1,Br);           %N Symbol generation
    modulator=repelem(data,Fs/Br);
    
    %Frequency modulation
    Am=1;
    Kf = 70;                                                                         % Modulator sensitivity
    F_delta = Kf * Am;                                                               % Peak deviation
    FSK= Ac * cos(2*pi*(Fcarrier*t+F_delta*modulator.*t));
    
    %Time domain plots
    subplot(4,1,1); plot(t, modulator); title('modulator');set(gca,'color','black')
    subplot(4,1,2); plot(t, FSK); title('PSK');xlabel('time (s)');set(gca,'color','black')
    
    %Frequency domain
    freq_vector=Fs/L*[0:L/2-1];
    
    %Magnitude of Fourier transform
    abs_modulator=abs(fft(modulator)/L);
    abs_FSK=abs(fft(FSK)/L);
    
    %Positives frequencies discrimination
    modulator_spectrum=abs_modulator(1:L/2); 
    
    FSK_spectrum=abs_FSK(1:L/2); 
    
    %Freq domain plotting   
     subplot(4,1,3); plot(freq_vector,modulator_spectrum); title('FFT modulator');set(gca,'color','black')
     subplot(4,1,4); plot(freq_vector,FSK_spectrum); title('FFT FSK');xlabel('Frequency (Hz)');set(gca,'color','black')
    
    pause(0.5)
       
end
