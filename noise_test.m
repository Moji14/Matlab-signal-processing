%Noise test

Fs=1000;
Ts=1/Fs;

%Signal 1
L1=10000;
t1=[0:L1-1]*Ts;

Fx=1;
x1=square(sin(2*pi*Fx*t1))+0.1*rand(1,L1);
%Time domain plot
subplot(2,1,1);plot(t1(1:Fs),x1(1:Fs));title('X1');xlabel('Time (s)');ylabel('Amplitude (V)');
%Frequency domain plot
freq_vector1=[0:L1-1]*Fs/L1;
FFTx1=abs(fft(x1)/L1);
subplot(2,1,2);semilogx(freq_vector1(1:L1/2),10*log10(FFTx1(1:L1/2)));title('FFT of X1');xlabel('Freq (Hz)');ylabel('Power (dB)');