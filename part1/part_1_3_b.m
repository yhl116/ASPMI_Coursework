clc; clear all;
load('font_size.mat')

%generating input signals

fs = 100;   %sampling frequency
dt = 1/fs;  %sampling period
stoptime = 10;
t = (0:dt:stoptime-dt);
fc = 10; %hertz

sine = cos(2*pi*fc*t);
wgn = randn(100,1000);
noisy_sine = sine + wgn;

sine_biased_r = zeros(100,1999);
sine_biased_lag = zeros(100,1999);
sine_biased_Pxx = zeros(100,1999);
sine_biased_fs = zeros(100,1999);

a = noisy_sine(1,:);

figure('Renderer', 'painters', 'Position',[200,200,1000,600])
hold on

subplot(2,2,1)
for i = 1:100
    [sine_biased_r(i,:), sine_biased_lag(i,:), sine_biased_Pxx(i,:), sine_biased_fs(i,:)] = corr_est(noisy_sine(i,:),'biased');
    p1 = plot(sine_biased_fs(i,:), sine_biased_Pxx(i,:), "c");
    hold on
end   

title('PSD Estimate of Noisy Sinewave','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power','FontSize',y_label_font_size)
grid on
mean_Pxx = mean(sine_biased_Pxx, 1);
p2 = plot(sine_biased_fs(i,:), mean_Pxx, 'b');
h = [p1(1);p2];
legend(h, 'Realisations', 'Mean of Realisations','Location','northeast','FontSize',legend_font_size)


std_Pxx = std(sine_biased_Pxx, 1);
subplot(2,2,2)
plot(sine_biased_fs(i,:), std_Pxx)
title('Standard Deviation of Realisation','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power','FontSize',y_label_font_size)
grid on

subplot(2,2,3)
for i = 1:100
    p1 = plot(sine_biased_fs(i,:), 10*log10(sine_biased_Pxx(i,:)), "c");
    hold on
end   

title('Log of PSD Estimate of Noisy Sinewave','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)
grid on
mean_Pxx = mean(sine_biased_Pxx, 1);
p2 = plot(sine_biased_fs(i,:), 10*log10(mean_Pxx), 'b');
h = [p1(1);p2];
legend(h, 'Realisations', 'Mean of Realisations','Location','southwest','FontSize',legend_font_size)


std_Pxx = std(sine_biased_Pxx, 1);
subplot(2,2,4)
plot(sine_biased_fs(i,:), 10*log10(std_Pxx))
title('Log og Standard Deviation of Realisation','FontSize',title_font_size)
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)
grid on

saveas(gcf,'part1/images/1_3_b.png')