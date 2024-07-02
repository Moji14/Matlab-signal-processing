% This file is a Matlab script generates a Delta-Sigma PWM modulation
% signal and plots the modulator, output signal, integrator output, the 
% error signal (sum)and the oversampled output in the time domain.
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
fs = 100;                            % Sampling Frequency (samples per second)
Ts = 1/fs;                            % Sampling Period (seconds per sample)
L=100;                               % Time vector lenght (total samples)
t = [0:L-1]*Ts;                      % Time vector

% Modulator signal
Fmodulator = 1; Am = 0.5; modulator = 0.5+Am * sin(2*pi*Fmodulator*t); 

% Parameters
int_out=0; % Integrator initial value
integrator_gain=0.1;
oversampling_ratio=5;
f_oversampling=oversampling_ratio*fs;
Ts_oversampling=1/f_oversampling;
t2= [0:oversampling_ratio*L-1]*Ts_oversampling;

% Prealocating space
suma=zeros(1,L);
q_out=zeros(1,L);
integral_record=zeros(1,L);
bitstream = zeros(1,oversampling_ratio*L);

% Delta modulator loop
for i = 1:L
    if i<=1
        suma(i)=modulator(i);
    else
        suma(i)=modulator(i)-q_out(i-1);
    end
    int_out=integrator_gain*(suma(i)+int_out);
    if int_out>0
        q_out(i)=1;
    elseif int_out<=0
        q_out(i)=0;
    end
    % Oversampling loop
    for j = 1:oversampling_ratio    
        bitstream((i-1)*oversampling_ratio + j) = q_out(i);
    end  
    integral_record(i)=int_out;
end

% Plotting
figure;
subplot(5,1,1);plot(t,modulator);title('Modulator signal');
subplot(5,1,2);plot(t,q_out);title('Delta-Sigma modulation output');
subplot(5,1,3);plot(t,integral_record);title('Integrator output');
subplot(5,1,4);plot(t,suma);title('Error (sum) output');
subplot(5,1,5);plot(t2,bitstream);title('Delta modulation oversampled');
