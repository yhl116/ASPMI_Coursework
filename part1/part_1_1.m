clc; clear all;
load sunspot.dat;
fs = 100;   %sampling frequency
dt = 1/fs;  %sampling period
stoptime = 10;
t = (0:dt:stoptime-dt);
fc = 10; %hertz

demean_sunspot = sunspot(:,2) - mean(sunspot(:,2));
detrend_sunspot = detrend(sunspot(:,2));
trend = sunspot(:,2) - detrend_sunspot;
log_sunspot = log(sunspot(:,2) + 1e-20);

sine = cos(2*pi*fc*t) + t;
logging = t.^(4) + 5;
noisy_sine = sine;

[sine_unbiased_r, sine_unbiased_lag, sine_unbiased_Pxx, sine_unbiased_fs] = corr_est(sunspot(:,2),'unbiased');
[log_unbiased_r, log_unbiased_lag, log_unbiased_Pxx, log_unbiased_fs] = corr_est(demean_sunspot,'unbiased');
[a, b, log_unbiased, log_unbiased] = corr_est(detrend_sunspot,'unbiased');

figure
plot(sine_unbiased_lag, sine_unbiased_r)
hold on
plot(log_unbiased_lag, log_unbiased_r)
plot(b, a)
legend({'normal','demean', 'detrend'})
