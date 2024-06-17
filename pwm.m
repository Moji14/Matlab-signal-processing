% This file is a Matlab script generates a PWM modulation
% signal and plots the analog modulator, carrier and the modulated signal 
% in the time domain
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


% Modulator signal
Fmodulator = 1; Am = 0.6; modulator = 0.5+(Am * sin(2*pi*Fmodulator*t));                    %

% Periodic sawtooth wave 0 offested and normalized to 1 
% (Matlab sawtoothfunction is not amplitude consistent)
%lead_carrier=0.5.*(1+sawtooth(2*pi*40*t,0));
%trail_carrier=0.5.*(1+sawtooth(2*pi*40*t,1));
%center_carrier=0.5.*(1+sawtooth(2*pi*40*t,0.5));

Fsaw=20;
Tsaw=1/Fsaw;
t2 = [-1/2:Ts/Tsaw:1/2-Ts/Tsaw]*Tsaw;
skewtype=-1;
lead_carrier=repmat(tripuls(t2,Tsaw,skewtype),[1,Fsaw/Fmodulator]);
skewtype=1;
trail_carrier=repmat(tripuls(t2,Tsaw,skewtype),[1,Fsaw/Fmodulator]);
skewtype=0;
center_carrier=repmat(tripuls(t2,Tsaw,skewtype),[1,Fsaw/Fmodulator]);

% PWM modulation
pwm_lead = comparator(modulator, lead_carrier,L);
pwm_trail = comparator(modulator, trail_carrier,L);
pwm_center = comparator(modulator,center_carrier,L);


figure;
subplot(2,3,1);plot(t,lead_carrier);hold on;%title('Modulator analog signal');
subplot(2,3,1);plot(t,modulator);title('Modulator and Lead sawtooth carrier');hold off;

subplot(2,3,2);plot(t,trail_carrier);hold on; %title('Modulator analog signal');
subplot(2,3,2);plot(t,modulator);title('Modulator and Trail sawtooth carrier');hold off;

subplot(2,3,3);plot(t,center_carrier);hold on;% title('Modulator analog signal');
subplot(2,3,3);plot(t,modulator);title('Modulator and Center sawtooth carrier');hold off;

subplot(2,3,4);plot(t,pwm_lead);title('PWM (lead sawtooth)');axis([0 1 -0.05 1.05]);
subplot(2,3,5);plot(t,pwm_trail);title('PWM (trail sawtooth)');axis([0 1 -0.05 1.05]);
subplot(2,3,6);plot(t,pwm_center);title('PWM (sawtooth sawtooth)');axis([0 1 -0.05 1.05]);

% Comparator
function pwm_mod =  comparator(modulator, carrier,size)
    pwm_mod = zeros(size);
    for i = 1:size
        if modulator(i)>carrier(i)
            pwm_mod(i)=1;
        else
            pwm_mod(i)=0;
        end

    end
end