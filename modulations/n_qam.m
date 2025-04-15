% This file is a Matlab script generates an  QAM modulation
% signals and plots the modulator and the modulated signal in time
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

% Local oscillators for IQ modulation
FLO = 100; ALO = 1;
LO_inpahse = ALO * cos(2*pi*FLO*t);
LO_90 = ALO * sin(2*pi*FLO*t);

%4 Symbol generation
N=4;                                  %Number of levels
Br=FLO/10;                            %Bit rate

% Generic random signal
data = randi([0 N-1],1,Br);           %N Symbol generation

% Gray code map for 4-QAM
I_map = [1, -1, -1, 1];
Q_map = [1, 1, -1, -1];

% IQ mapping
Idata=I_map(data+1);
Qdata=Q_map(data+1);

%wind=tukeywin(Fs/Br).';
% Upscaling
Idata_mod= 1+repelem(Idata,Fs/Br);
Qdata_mod= repelem(Qdata,Fs/Br);

%for i=1:Fs/Br:L
%  Idata_mod(i:i+Fs/Br-1)=wind.*Idata_mod(i:i+Fs/Br-1);
%  Qdata_mod(i:i+Fs/Br-1)=wind.*Qdata_mod(i:i+Fs/Br-1);
%  end

% QAM modulation
nQAM = LO_inpahse .* Idata_mod + LO_90 .* Qdata_mod;

% Data Plot
subplot(4,2,[1,2]); plot(repelem(data,Fs/Br));title('Random data');

% I and Q data Plot
subplot(4,2,3); plot(Idata_mod);title('I data');
subplot(4,2,4); plot(Qdata_mod);title('Q data');

% I and Q modulated by LO's
subplot(4,2,5); plot(LO_inpahse .* Idata_mod);title('Modulated I component');
subplot(4,2,6); plot(LO_90 .* Qdata_mod);title('Modulated Q component');

% QAM modulation plot
subplot(4,2,[7,8]); plot(nQAM);title('nQAM modulation');

%wind=tukeywin(Fs/Br).';

win_vector=zeros(1,Fs/Br);
inst_spec=zeros(1,L);
theta=zeros(1,L);
p=[];
for i=1:Fs/Br:L
  win_vector(i:i+Fs/Br-1)=nQAM(i:i+Fs/Br-1);
  inst_spec(i:i+Fs/Br-1)=fft(win_vector(i:i+Fs/Br-1),Fs/Br)/(Fs/Br);
  [B,I]=max(inst_spec(i:i+Fs/(2*Br)-1));
  theta(i:i+Fs/Br-1) =angle(B)*180/pi;
  inst_spec(i:i+Fs/Br-1)=abs(B);
  p=[p B];

end
figure;
subplot(4,1,1); plot(nQAM);
subplot(4,1,2);plot(win_vector);
subplot(4,1,3);plot(abs(inst_spec));
subplot(4,1,4);plot(theta);
figure; scatter(Idata, Qdata);

% n-QAM modulation
subplot(4,2,[7,8]); plot(nQAM);title('nQAM modulation');
