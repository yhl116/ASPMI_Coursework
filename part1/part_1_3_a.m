clc; clear all;
load('font_size.mat')

%generating input signals

fs = 100;   %sampling frequency
dt = 1/fs;  %sampling period
stoptime = 10;
t = (0:dt:stoptime-dt);
fc = 10; %hertz

sine = cos(2*pi*fc*t);
wgn = randn(1,1000);
filtered_wgn = filter([1,1,1,1,1,1,1,1,1], 1, wgn);
noisy_sine = sine + wgn;

[wgn_biased_r, wgn_biased_lag, wgn_biased_Pxx, wgn_biased_fs] = corr_est(wgn,'biased');
[wgn_unbiased_r, wgn_unbiased_lag, wgn_unbiased_Pxx, wgn_unbiased_fs] = corr_est(wgn,'unbiased');

[sine_biased_r, sine_biased_lag, sine_biased_Pxx, sine_biased_fs] = corr_est(noisy_sine,'biased');
[sine_unbiased_r, sine_unbiased_lag, sine_unbiased_Pxx, sine_unbiased_fs] = corr_est(noisy_sine,'unbiased');

[filtered_wgn_biased_r, filtered_wgn_biased_lag, filtered_wgn_biased_Pxx, filtered_wgn_biased_fs] = corr_est(filtered_wgn,'biased');
[filtered_wgn_unbiased_r, filtered_wgn_unbiased_lag, filtered_wgn_unbiased_Pxx, filtered_wgn_unbiased_fs] = corr_est(filtered_wgn,'unbiased');

figure('Renderer', 'painters', 'Position',[200,200,1000,900])
subplot(3,2,1)
plot(wgn_unbiased_lag, wgn_unbiased_r)
hold on
plot(wgn_biased_lag, wgn_biased_r)
% axis([0 60 -160 -90]);
title('WGN: ACF','FontSize',title_font_size)
xlabel('Lag','FontSize',x_label_font_size)
ylabel('Autocorrelation Coefficient','FontSize',y_label_font_size)
legend({'Unbiased','Biased'},'FontSize',legend_font_size)
grid on

subplot(3,2,2)
plot(wgn_unbiased_fs, wgn_unbiased_Pxx)
hold on
plot(wgn_biased_fs, wgn_biased_Pxx)
% axis([0 60 -160 -90]);
title('WGN: Correlogram','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power','FontSize',y_label_font_size)
legend({'Unbiased','Biased'},'FontSize',legend_font_size)
grid on

subplot(3,2,3)
plot(sine_unbiased_lag, sine_unbiased_r)
hold on
plot(sine_biased_lag, sine_biased_r)
% axis([0 60 -160 -90]);
title('Noisy Sinewave: ACF','FontSize',title_font_size)
xlabel('Lag','FontSize',x_label_font_size)
ylabel('Autocorrelation Coefficient','FontSize',y_label_font_size)
legend({'Unbiased','Biased'},'FontSize',legend_font_size)
grid on

subplot(3,2,4)
plot(sine_unbiased_fs, sine_unbiased_Pxx)
hold on
plot(sine_biased_fs, sine_biased_Pxx)
% axis([0 60 -160 -90]);
title('Noisy Sinewave: Correlogram','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power','FontSize',y_label_font_size)
legend({'Unbiased','Biased'},'FontSize',legend_font_size)
grid on

subplot(3,2,5)
plot(filtered_wgn_unbiased_lag, filtered_wgn_unbiased_r)
hold on
plot(filtered_wgn_biased_lag, filtered_wgn_biased_r)
% axis([0 60 -160 -90]);
title('Filtered WGN: ACF','FontSize',title_font_size)
xlabel('Lag','FontSize',x_label_font_size)
ylabel('Autocorrelation Coefficient','FontSize',y_label_font_size)
legend({'Unbiased','Biased'},'FontSize',legend_font_size)
grid on

subplot(3,2,6)
plot(filtered_wgn_unbiased_fs, filtered_wgn_unbiased_Pxx)
hold on
plot(filtered_wgn_biased_fs, filtered_wgn_biased_Pxx)
% axis([0 60 -160 -90]);
title('Filtered WGN: Correlogram','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power','FontSize',y_label_font_size)
legend({'Unbiased','Biased'},'FontSize',legend_font_size)
grid on

saveas(gcf,'part1/images/1_3_a.png')