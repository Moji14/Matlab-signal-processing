% This file is a Matlab script generates an  ASK modulation
% signals and plots the modulator and the modulated signal in time as well
% as in frequency domain. 
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

%N level encoding symbol generation
N=4;                                  %Number of levels
Br=Fcarrier/10;                       %Keeps modulator and carrier frequencies related to reduce bandwidth due to discontinuities in amplitude

handle = figure; %Some Figure
while isvalid(handle)
    %Modulator generation
    data = randi([0 N-1],1,Br);
    modulator=repelem(data,Fs/Br);
    
    % Modulation
    ASK=carrier.*modulator/max(modulator);
    
    % FFT calculation (positive half)
    freq_vector=Fs/L*[0:L/2-1];
    
    abs_modulator=abs(fft(modulator)/L); 
    modulator_spectrum=abs_modulator(1:L/2);
    
    abs_ASK=abs(fft(ASK)/L); 
    ASK_spectrum=abs_ASK(1:L/2);
    
    %Signals plotting
    subplot(4,1,1);plot(t,modulator,'yellow');title([num2str(N),' level encoding modulator']);xlabel('time (s)');set(gca,'color','black')
    subplot(4,1,2);plot(freq_vector,modulator_spectrum,'yellow');title('FFT modulator');xlabel('Frequency (Hz)');set(gca,'color','black')
    subplot(4,1,3);plot(t,ASK,'yellow');title('ASK modulation');xlabel('time (s)');set(gca,'color','black')
    subplot(4,1,4);plot(freq_vector,ASK_spectrum,'yellow');title('FFT ASK');xlabel('Frequency (Hz)');set(gca,'color','black')
    pause(0.5)
end
