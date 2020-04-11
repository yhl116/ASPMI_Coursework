clc; clear all;
load('font_size.mat')
% load('Reading1')
% load('Reading2')
% load('Reading3')

% [xRRI_1, fsRRI_1] = ECG_to_RRI(reading1, fs);
% [xRRI_2, fsRRI_2] = ECG_to_RRI(reading2, fs);
% [xRRI_3, fsRRI_3] = ECG_to_RRI(reading3, fs);
load ('trials.mat')

% xRRI_1 = detrend(xRRI_1).*hann(length(xRRI_1));
% xRRI_2 = detrend(xRRI_2).*hann(length(xRRI_2));
% xRRI_3 = detrend(xRRI_3).*hann(length(xRRI_3));

xRRI_1 = detrend(xRRI_1).*hann(length(xRRI_1))';
xRRI_2 = detrend(xRRI_2).*hann(length(xRRI_2))';
xRRI_3 = detrend(xRRI_3).*hann(length(xRRI_3))';

% Pxx=pow2db(xf.^2/(N*2*pi));
% Pxx=pow2db(xf.^2/(N*2*pi));
% Pxx=pow2db(xf.^2/(N*2*pi));

nfft = fs*5;         %from hint to have 5 DFT samples per Hz 
noverlap = 0;

%standard periodogram
[pxx_1_std, w] = periodogram(xRRI_1,rectwin(length(xRRI_1)),nfft,fsRRI_1);
[pxx_2_std, ~] = periodogram(xRRI_2,rectwin(length(xRRI_2)),nfft,fsRRI_2);
[pxx_3_std, ~] = periodogram(xRRI_3,rectwin(length(xRRI_3)),nfft,fsRRI_3);

%averaged periodogram with different window lengths
[pxx_1_50, ~] = pwelch(xRRI_1,rectwin(50),noverlap,nfft,fs);
[pxx_1_100, ~] = pwelch(xRRI_1,rectwin(100),noverlap,nfft,fs);
[pxx_1_200, ~] = pwelch(xRRI_1,rectwin(200),noverlap,nfft,fs);
[pxx_2_50, ~] = pwelch(xRRI_2,rectwin(50),noverlap,nfft,fs);
[pxx_2_100, ~] = pwelch(xRRI_2,rectwin(100),noverlap,nfft,fs);
[pxx_2_200, ~] = pwelch(xRRI_2,rectwin(200),noverlap,nfft,fs);
[pxx_3_50, ~] = pwelch(xRRI_3,rectwin(50),noverlap,nfft,fs);
[pxx_3_100, ~] = pwelch(xRRI_3,rectwin(100),noverlap,nfft,fs);
[pxx_3_200, ~] = pwelch(xRRI_3,rectwin(200),noverlap,nfft,fs);

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,3,1)
plot(w, 10*log10(pxx_1_std))
grid on;
axis([0 2 -100 0]);
title('Standard Periodogram, Trial 1','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)

subplot(1,3,2)
plot(w, 10*log10(pxx_2_std))
grid on;
axis([0 2 -100 0]);
title('Standard Periodogram, Trial 2','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)

subplot(1,3,3)
plot(w, 10*log10(pxx_3_std))
grid on;
% axis([0 2 -100 0]);
title('Standard Periodogram, Trial 3','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)
saveas(gcf,'part1/images/1_5_a_1.png')

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,3,1)
plot(w, 10*log10(pxx_1_50))
hold on
plot(w, 10*log10(pxx_1_100))
plot(w, 10*log10(pxx_1_200))
axis([0 2 -100 0]);
title('Bartlett Periodogram, Trial 1','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)
legend({'Window Length: 50 samples', 'Window Length: 100 samples', 'Window Length: 200 samples'},'Location','northeast','FontSize',12)
grid on

subplot(1,3,2)
plot(w, 10*log10(pxx_2_50))
hold on
plot(w, 10*log10(pxx_2_100))
plot(w, 10*log10(pxx_2_200))
axis([0 2 -100 0]);
title('Bartlett Periodogram, Trial 2','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)
legend({'Window Length: 50 samples', 'Window Length: 100 samples', 'Window Length: 200 samples'},'Location','northeast','FontSize',12)
grid on

subplot(1,3,3)
plot(w, 10*log10(pxx_3_200))
hold on
plot(w, 10*log10(pxx_3_100))
plot(w, 10*log10(pxx_3_50))
axis([0 2 -100 0]);
title('Bartlett Periodogram, Trial 3','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)
legend({'Window Length: 200 samples', 'Window Length: 100 samples', 'Window Length: 50 samples'},'Location','northeast','FontSize',12)
grid on
saveas(gcf,'part1/images/1_5_a_2.png')
