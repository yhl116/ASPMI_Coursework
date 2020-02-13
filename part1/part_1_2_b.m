clc; clear all;
load('EEG_Data_Assignment1')

%shared parameters
nfft = fs*5;         %from hint to have 5 DFT samples per Hz 
noverlap = 0;

%standard periodogram
[pxx_std, w_std] = periodogram(POz,rectwin(length(POz)),nfft,fs);

%averaged periodogram with different window lengths
[pxx_10, w_10] = pwelch(POz,rectwin(fs*10),noverlap,nfft,fs);
[pxx_5, w_5] = pwelch(POz,rectwin(fs*5),noverlap,nfft,fs);
[pxx_1, w_1] = pwelch(POz,rectwin(fs*1),noverlap,nfft,fs);

figure
plot(w_std, 10*log10(pxx_std))
grid on;
axis([0 60 -160 -90]);
title('Standard Periodogram')
xlabel('Frequency(Hz)')
ylabel('Power(dB)')

figure
subplot(1,3,1)
plot(w_10, 10*log10(pxx_10))
axis([0 60 -160 -90]);
title('Bartlett Periodogram with 1 Sec Window Length')
xlabel('Frequency(Hz)')
ylabel('Power(dB)')


grid on
subplot(1,3,2)
plot(w_5, 10*log10(pxx_5))
grid on
axis([0 60 -160 -90]);
title('Bartlett Periodogram with 5 Sec Window Length')
xlabel('Frequency(Hz)')
ylabel('Power(dB)')


subplot(1,3,3)
plot(w_1, 10*log10(pxx_1))
grid on
axis([0 60 -160 -90]);
title('Bartlett Periodogram with 10 Sec Window Length')
xlabel('Frequency(Hz)')
ylabel('Power(dB)')