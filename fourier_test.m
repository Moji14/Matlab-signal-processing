%Time specifications:
f = 1000;                            % Sampling Frequency (samples per second)
Ts = 1/f;                            % Sampling Period (seconds per sample)
N=1000;                               % Time vector lenght (total samples)
time = [0:N-1]*Ts;                       % Time vector

%Signals                   
Fcarrier = 100; Ac = 1; carrier = Ac * sin(2*pi*Fcarrier*time);
A=   cos(2*pi*Fcarrier*time);
X=fft(A);%normalises FFT

X_mag=abs(X);

X_amp=X_mag/N; %normalises magnitude into amplitude
X_ampsingle=X_amp(1:N/2+1); %divides the plot from two-sided to one
X_ampsingle(2:end-1)=2*X_ampsingle(2:end-1); %idem
freq=(0:(N/2))*f/N; %plots the frequency on the x-axis rather than bins
figure('visible','on')
plot(freq,X_ampsingle);
title('Frequency spectrum')
xlabel({'Frequency','[Hertz]'});
ylabel({'Amplitude [MW]'});
figure('visible','on');
plot(time,A); %plots original signal
title('original signal');

X2=X;
threshold=max(abs(X)/10);
X2(abs(X)<threshold)=0; % determines the low-amplitude threshold
phase=atan2(imag(X2),real(X2))*180/pi;
phase_single=phase(1:N/2+1); %turns the plot into a one-sided plot
phase_single(2:end-1)=2*phase_single(2:end-1);
figure('visible','on')
plot(freq,phase_single);
title('Phase information')
xlabel({'frequency','[Hertz]'});
ylabel({'phase [degrees]'});