clc; clear all;

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

figure
hold on

subplot(2,2,1)
for i = 1:100
    [sine_biased_r(i,:), sine_biased_lag(i,:), sine_biased_Pxx(i,:), sine_biased_fs(i,:)] = corr_est(noisy_sine(i,:),'biased');
    p1 = plot(sine_biased_fs(i,:), sine_biased_Pxx(i,:), "c");
    hold on
end   

title('PSD Estimate of Noisy Sinewave')
xlabel('Normalised Frequency')
ylabel('Power')
grid on
mean_Pxx = mean(sine_biased_Pxx, 1);
p2 = plot(sine_biased_fs(i,:), mean_Pxx, 'b');
h = [p1(1);p2];
legend(h, 'Realisations', 'Mean of Realisations','Location','northeast')


std_Pxx = std(sine_biased_Pxx, 1);
subplot(2,2,2)
plot(sine_biased_fs(i,:), std_Pxx)
title('Standard Deviation of Realisation')
xlabel('Normalised Frequency')
ylabel('Power')
grid on

subplot(2,2,3)
for i = 1:100
    p1 = plot(sine_biased_fs(i,:), 10*log10(sine_biased_Pxx(i,:)), "c");
    hold on
end   

title('Log of PSD Estimate of Noisy Sinewave')
xlabel('Normalised Frequency')
ylabel('Power')
grid on
mean_Pxx = mean(sine_biased_Pxx, 1);
p2 = plot(sine_biased_fs(i,:), 10*log10(mean_Pxx), 'b');
h = [p1(1);p2];
legend(h, 'Realisations', 'Mean of Realisations','Location','southwest')


std_Pxx = std(sine_biased_Pxx, 1);
subplot(2,2,4)
plot(sine_biased_fs(i,:), 10*log10(std_Pxx))
title('Log og Standard Deviation of Realisation')
xlabel('Normalised Frequency')
ylabel('Power')
grid on