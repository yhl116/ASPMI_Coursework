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
subplot(2,2,4)
plot(w_10, 10*log10(pxx_10))
hold on
plot(w_5, 10*log10(pxx_5))
plot(w_1, 10*log10(pxx_1))
grid on;
axis([0 60 -160 -90]);
title('Standard Periodogram')
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
legend({'10 sec window','5 sec window', '1 sec window'},'Location','southwest')

subplot(2,2,1)
plot(w_std, 10*log10(pxx_std))
hold on
plot(w_10, 10*log10(pxx_10))
axis([0 60 -160 -90]);
title('Bartlett Periodogram with 10 Sec Window Length')
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
legend({'Unbiased','Biased'})
legend({'standard', '10 sec window'},'Location','southwest')

grid on
subplot(2,2,2)
plot(w_std, 10*log10(pxx_std))
hold on
plot(w_5, 10*log10(pxx_5))
grid on
axis([0 60 -160 -90]);
title('Bartlett Periodogram with 5 Sec Window Length')
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
legend({'standard', '5 sec window'},'Location','southwest')

subplot(2,2,3)
plot(w_std, 10*log10(pxx_std))
hold on
plot(w_1, 10*log10(pxx_1))
grid on
axis([0 60 -160 -90]);
title('Bartlett Periodogram with 1 Sec Window Length')
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
legend({'standard', '1 sec window'},'Location','southwest')
