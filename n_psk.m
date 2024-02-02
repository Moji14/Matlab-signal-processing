% N Phase Shift Keying
% This file is a Matlab script that generates a PSK modulation and plots the 
% modulator and the modulated signal in time as well as in the frequency domain. 
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
Fcarrier = 100; Ac = 1; carrier = Ac * cos(2*pi*Fcarrier*t);

%4 Symbol generation
N=4;                                  %Number of levels
Br=Fcarrier/10;                       %Keeps modulator and carrier frequencies related to reduce bandwidth due to discontinuities in frequencies

handle1 = figure(1); %Some Figure
handle2 = figure(2);
%hold on
while isvalid(handle1) && isvalid(handle2)
    data = randi([0 N-1],1,Br);           %N Symbol generation
    modulator=repelem(data,Fs/Br);
    
    %NPSK modulation
    Bp=1*Br;%Bit period
    Eb=modulator*Bp;%sqrt(modulator*Bp);%sqrt((modulator*((Bp)^2))/2);
    Es=Eb*log2(N);%Energy per symbol
    PSK= cos(2*pi*Fcarrier*t + (2*modulator-1)*pi/N); %sqrt(2*Es/Bp) .*
    
    %Time domain plots
    figure(handle1);
    subplot(5,1,1); plot(t, modulator); title('Modulator');xlabel('time (s)');set(gca,'color','black')
    subplot(5,1,2); plot(t, PSK); title('PSK');xlabel('time (s)');set(gca,'color','black')
    
    %Full time signal frequency analysys
    freq_vector=Fs/L*[0:L/2-1];
    avg_modulator=abs(fft(modulator)/L);
    avg_modulator_half=2*avg_modulator(1:L/2);%Positives frequencies discrimination
    avg_PSK=abs(fft(PSK)/L);
    avg_PSK_half=2*avg_PSK(1:L/2);

    
    %Instant frequency analysys
    t2 = [0:L/2-1]*2*Ts;%Time vector with half samples
    for i=1:L/Br
        aux=fft(PSK(((i-1)*Br+1):i*Br))/Br;
        aux=2*aux(1:Br/2);
        fft_PSK(((i-1)*Br/2+1):i*Br/2)=max(aux);
    end
             
    X2=fft_PSK;
    threshold=max(abs(fft_PSK)/10);
    X2(abs(fft_PSK) < threshold)=0; % determines the low-amplitude threshold
        
    %Freq domain plotting   
    subplot(5,1,3); semilogy(freq_vector,avg_modulator_half); title('Modulator and PSK spectrum');xlabel('Frequency (Hz)');
    set(gca,'color','black');axis([0 Fs/2 0.01 1]);hold on;
    subplot(5,1,3); semilogy(freq_vector,avg_PSK_half);hold off;%;set(gca,'color','black')

    subplot(5,1,4); plot(t2,Br*abs(X2)); title('PSK Instant Frequency');xlabel('Time (s)');set(gca,'color','black');
    subplot(5,1,5); plot(t2,angle(X2)*180/pi);title('PSK Instant Phase');xlabel('Time (s)');set(gca,'color','black');

    figure(handle2);polarplot(angle(X2),abs(X2),'*');title('PSK Constellation');
    %scatter(imag(X2),real(X2))  %polarplot(X2,'*')  scatterplot(X)

    pause(0.5);
       
end
