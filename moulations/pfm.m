% This file is a Matlab script generates a PFM modulation
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
Fs = 100;                            % Sampling Freq. (samples per second)
Ts = 1/Fs;                           % Sampling Period (seconds per sample)
L=fs;                                % Time vector lenght (1 cycle of Fs)
t = [0:L-1]*Ts;                      % Time vector

% Modulator signal
Fmodulator = 1; Am = 0.5; modulator = 0.6 + Am * sin(2*pi*Fmodulator*t); 

% Parameters
int_out=0; % Integrator initial value
integrator_gain=1;
tk=0;
tau=0.001;
oversampling_ratio=10;
f_oversampling=oversampling_ratio*fs;
Ts_oversampling=1/f_oversampling;

% Prealocating space
pulse_train=ones(1,L);
integral_record=zeros(1,L);
bitstream = zeros(1,oversampling_ratio*L);
A=1;

for i = 1:L
    % Reseteable integral and pulse generation 
    if int_out<=A
       int_out=integrator_gain*modulator(i)+int_out;
    else
        tk=t(i);
        pulse_train=pulse_train + sign(int_out)*((t>=tk) - (t>=tk+tau));
        int_out=0;
    end
    integral_record(i)=int_out;
    % Oversampling loop
    for j = 1:oversampling_ratio    
        bitstream((i-1)*oversampling_ratio + j) = pulse_train(i);
    end
end

% Plotting
figure;
subplot(4,1,1);plot(t,modulator);title('Modulator signal');
subplot(4,1,2);plot(t,integral_record);title('integral');
subplot(4,1,3);plot(t,pulse_train);title('Pulse_train');
subplot(4,1,4);plot(bitstream);title('OVERSAMPLED');
