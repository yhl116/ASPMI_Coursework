clc; clear all;
load('font_size.mat')
load('Nathan_Reading1')
load('Nathan_Reading2')
load('Nathan_Reading3')

nfft = fs*5;         %from hint to have 5 DFT samples per Hz 
noverlap = 0;

%standard periodogram
[pxx_1_std, w] = periodogram(reading1,rectwin(length(reading1)),nfft,fs);
[pxx_2_std, ~] = periodogram(reading2,rectwin(length(reading2)),nfft,fs);
[pxx_3_std, ~] = periodogram(reading3,rectwin(length(reading3)),nfft,fs);

%averaged periodogram with different window lengths
[pxx_1_50, ~] = pwelch(reading1,rectwin(fs*10),noverlap,nfft,fs);
[pxx_1_100, ~] = pwelch(reading1,rectwin(fs*100),noverlap,nfft,fs);
[pxx_1_200, ~] = pwelch(reading1,rectwin(fs*200),noverlap,nfft,fs);
[pxx_2_50, ~] = pwelch(reading2,rectwin(fs*10),noverlap,nfft,fs);
[pxx_2_100, ~] = pwelch(reading2,rectwin(fs*100),noverlap,nfft,fs);
[pxx_2_200, ~] = pwelch(reading2,rectwin(fs*200),noverlap,nfft,fs);
[pxx_3_50, ~] = pwelch(reading3,rectwin(fs*10),noverlap,nfft,fs);
[pxx_3_100, ~] = pwelch(reading3,rectwin(fs*100),noverlap,nfft,fs);
[pxx_3_200, ~] = pwelch(reading3,rectwin(fs*200),noverlap,nfft,fs);

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,3,1)
plot(w/max(w), 10*log10(pxx_1_std))
grid on;
axis([0 0.1 -100 40]);
title('Standard Periodogram, Trial 1','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)

subplot(1,3,2)
plot(w/max(w), 10*log10(pxx_2_std))
grid on;
axis([0 0.1 -100 40]);
title('Standard Periodogram, Trial 2','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)

subplot(1,3,3)
plot(w/max(w), 10*log10(pxx_3_std))
grid on;
axis([0 0.1 -100 40]);
title('Standard Periodogram, Trial 3','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,3,1)
plot(w/max(w), 10*log10(pxx_1_50))
hold on
plot(w/max(w), 10*log10(pxx_1_100))
plot(w/max(w), 10*log10(pxx_1_200))
axis([0 0.1 -100 40]);
title('Bartlett Periodogram, Trial 1')
xlabel('Normalised Frequency')
ylabel('Power (dB)')
legend({'Window Length: 50 samples', 'Window Length: 100 samples', 'Window Length: 200 samples'},'Location','southwest')
grid on

subplot(1,3,2)
plot(w, 10*log10(pxx_2_50))
hold on
plot(w, 10*log10(pxx_2_100))
plot(w, 10*log10(pxx_2_200))
axis([0 500 -100 40]);
title('Bartlett Periodogram, Trial 2')
xlabel('Normalised Frequency')
ylabel('Power (dB)')
legend({'Window Length: 50 samples', 'Window Length: 100 samples', 'Window Length: 200 samples'},'Location','southwest')
grid on

subplot(1,3,3)
plot(w, 10*log10(pxx_3_200))
hold on
plot(w, 10*log10(pxx_3_100))
plot(w, 10*log10(pxx_3_50))
axis([0 500 -100 40]);
title('Bartlett Periodogram, Trial 3')
xlabel('Normalised Frequency')
ylabel('Power (dB)')
legend({'Window Length: 200 samples', 'Window Length: 100 samples', 'Window Length: 50 samples'},'Location','southwest')
grid on

