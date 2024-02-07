
%Time specifications:
Fs = 1000;                            % Sampling Frequency (samples per second)
Ts = 1/Fs;                            % Sampling Period (seconds per sample)
L=1000;                               % Time vector lenght (total samples)
t = [0:L-1]*Ts;                       % Time vector

%Signals                   
Fcarrier = 100; Ac = 1; carrier = Ac * sin(2*pi*Fcarrier*t);

%4 Symbol generation
N=2;                                  %Number of levels
Br=Fcarrier/10;                       %Keeps modulator and carrier frequencies related to reduce bandwidth due to discontinuities in frequencies


handle = figure; %Some Figure
%set(gca,'color','black');
%axis([200 825 0 2]);
while isvalid(handle)
    data = randi([0 N-1],1,5);           %N Symbol generation
    modulator=repelem(data,200);

    sigma = 5;
    sz = 30;    % length of gaussFilter vector
    x = linspace(-sz / 2, sz / 2, sz);
    gaussFilter = exp(-x .^ 2 / (2 * sigma ^ 2));
    gaussFilter = gaussFilter / sum (gaussFilter); % normalize

    yfilt = filter (gaussFilter,1, modulator);
    noise=wgn(1,10*L,-27);
    yfilt=0.5*yfilt+0.5*noise(1:L);%0.05*rand(1,L);
    
    %Time domain plots
    
    %subplot(4,1,1);axis([200 825 0 2]);plot(t(200:825), modulator(200:825)); title('Modulator');
    %hold off
    
    %subplot(4,1,2);
    set(gca,'color','black');
    axis([0.15 0.84 -0.2 1]);
    plot(t(200:825), yfilt(200:825)); title('Eye diagram');
    xlabel('Time (s)');
    hold on

    pause(0.1);
end