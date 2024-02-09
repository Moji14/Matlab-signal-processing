% lisajous.m
% This file is a Matlab script generates a 2 sinusoids signals and plots 
% them simulating the oscilloscope X-Y deflection mode a good basic 
% introduction ecercise  for signal processing. 
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
Fs = 100;                             % Sampling Frequency (samples per second)
Ts = 1/Fs;                            % Sampling Period (seconds per sample)

L=200;                                % Time vector lenght (total samples)
t = [0:L-1]*Ts;                       % Time vector
Phi=pi/2;

%Signals                   
Fx = 1; Ax = 1; X = Ax * sin(2*pi*Fx*t);
Fy = 3; Ay = 1; Y = Ay * sin(2*pi*Fy*t+Phi);
figure; 
plot(X,Y,'green');set(gca,'color','black'); axis([-2 2 -2 2])