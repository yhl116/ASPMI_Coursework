clc; clear all;
load('font_size.mat')
load ('trials.mat')
title_font_size = 12;
nfft = fs*5;         %from hint to have 5 DFT samples per Hz 
noverlap = 0;
% load('Reading1')
% load('Reading2')
% load('Reading3')
% 
% [xRRI_1, fsRRI_1] = ECG_to_RRI(reading1, fs);
% [xRRI_2, fsRRI_2] = ECG_to_RRI(reading2, fs);
% [xRRI_3, fsRRI_3] = ECG_to_RRI(reading3, fs);

load ('trials.mat')

xRRI_1 = detrend(xRRI_1).*hann(length(xRRI_1))';
xRRI_2 = detrend(xRRI_2).*hann(length(xRRI_2))';
xRRI_3 = detrend(xRRI_3).*hann(length(xRRI_3))';

% [pxx_1_std, w1] = periodogram(xRRI_1,rectwin(length(xRRI_1)),nfft,fsRRI_1);
[pxx_1_std, w1] = periodogram(xRRI_1);
[pxx_2_std, w2] = periodogram(xRRI_2);
[pxx_3_std, w3] = periodogram(xRRI_3);

% [a_predicted, noise_var] = aryule(xRRI_1, 5);
% [magnitudes, w] = freqz(noise_var^(1/2), a_predicted, length(xRRI_1),fsRRI_1);
% 
% figure
% plot(w/max(w), 10*log10(abs(magnitudes).^2))
% hold on
% plot(w1/max(w1),10*log10(pxx_1_std))

[a_trial1_order1, noise_trial1_order1] = aryule(xRRI_1, 1);
[a_trial1_order5, noise_trial1_order5] = aryule(xRRI_1, 5);
[a_trial1_order20, noise_trial1_order20] = aryule(xRRI_1, 20);
[predicted_trial1_order1, w_trial1] = freqz(noise_trial1_order1^(1/2), a_trial1_order1, length(xRRI_1),fsRRI_1);
[predicted_trial1_order5, ~] = freqz(noise_trial1_order5^(1/2), a_trial1_order5, length(xRRI_1),fsRRI_1);
[predicted_trial1_order20, ~] = freqz(noise_trial1_order20^(1/2), a_trial1_order20, length(xRRI_1),fsRRI_1);

[a_trial2_order1, noise_trial2_order1] = aryule(xRRI_2, 1);
[a_trial2_order5, noise_trial2_order5] = aryule(xRRI_2, 5);
[a_trial2_order20, noise_trial2_order20] = aryule(xRRI_2, 20);
[predicted_trial2_order1, w_trial2] = freqz(noise_trial2_order1^(1/2), a_trial2_order1, length(xRRI_2),fsRRI_2);
[predicted_trial2_order5, ~] = freqz(noise_trial2_order5^(1/2), a_trial2_order5, length(xRRI_2),fsRRI_2);
[predicted_trial2_order20, ~] = freqz(noise_trial2_order20^(1/2), a_trial2_order20, length(xRRI_2),fsRRI_2);

[a_trial3_order1, noise_trial3_order1] = aryule(xRRI_3, 1);
[a_trial3_order5, noise_trial3_order5] = aryule(xRRI_3, 5);
[a_trial3_order20, noise_trial3_order20] = aryule(xRRI_3, 20);
[predicted_trial3_order1, w_trial3] = freqz(noise_trial3_order1^(1/2), a_trial3_order1, length(xRRI_3),fsRRI_3);
[predicted_trial3_order5, ~] = freqz(noise_trial3_order5^(1/2), a_trial3_order5, length(xRRI_3),fsRRI_3);
[predicted_trial3_order20, ~] = freqz(noise_trial3_order20^(1/2), a_trial3_order20, length(xRRI_3),fsRRI_3);

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,3,1)
% figure
plot(w_trial1/max(w_trial1), 10*log10(abs(predicted_trial1_order1).^2))
hold on
plot(w_trial1/max(w_trial1), 10*log10(abs(predicted_trial1_order5).^2))
plot(w_trial1/max(w_trial1), 10*log10(abs(predicted_trial1_order20).^2))
plot(w1/max(w1),10*log10(pxx_1_std))
title('ECG Periodogram, Prediction vs Actual, Trial 1','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)
legend({'prediction: p = 1', 'prediction: p = 5', 'prediction: p = 20', 'ideal'},'Location','northeast','FontSize',11)
grid on

% figure
subplot(1,3,2)
plot(w_trial2/max(w_trial2), 10*log10(abs(predicted_trial2_order1).^2))
hold on
plot(w_trial2/max(w_trial2), 10*log10(abs(predicted_trial2_order5).^2))
plot(w_trial2/max(w_trial2), 10*log10(abs(predicted_trial2_order20).^2))
plot(w2/max(w2),10*log10(pxx_2_std))
title('ECG Periodogram, Prediction vs Actual, Trial 2','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)
legend({'prediction: p = 1', 'prediction: p = 5', 'prediction: p = 20', 'ideal'},'Location','northeast','FontSize',11)
grid on

% figure
subplot(1,3,3)
plot(w_trial3/max(w_trial3), 10*log10(abs(predicted_trial3_order1).^2))
hold on
plot(w_trial3/max(w_trial3), 10*log10(abs(predicted_trial3_order5).^2))
plot(w_trial3/max(w_trial3), 10*log10(abs(predicted_trial3_order20).^2))
plot(w3/max(w3),10*log10(pxx_3_std))
title('ECG Periodogram, Prediction vs Actual, Trial 3','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)
legend({'prediction: p = 1', 'prediction: p = 5', 'prediction: p = 20', 'ideal'},'Location','northeast','FontSize',11)
grid on

saveas(gcf,'part1/images/1_5_c.png')