clc; clear all;

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

figure
subplot(3,2,1)
plot(wgn)

subplot(3,2,3)
plot(filtered_wgn)

subplot(3,2,5)
plot(noisy_sine)

[wgn_biased_r, wgn_biased_lag, wgn_biased_Pxx, wgn_biased_fs] = corr_est(wgn,'biased');
[wgn_unbiased_r, wgn_unbiased_lag, wgn_unbiased_Pxx, wgn_unbiased_fs] = corr_est(wgn,'unbiased');

subplot(3,2,2)

plot(wgn_unbiased_fs, wgn_unbiased_Pxx)
hold on
plot(wgn_biased_fs, wgn_biased_Pxx)
