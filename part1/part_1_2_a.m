clc; clear all;
load sunspot.dat;

demean_sunspot = sunspot(:,2) - mean(sunspot(:,2));
detrend_sunspot = detrend(sunspot(:,2));
trend = sunspot(:,2) - detrend_sunspot;
log_sunspot = log(sunspot(:,2) + 1e-20);

[sunspot_periodogram, w1] = periodogram(sunspot(:,2));
[detrend_periodogram, w2] = periodogram(detrend_sunspot);
[demean_periodogram,w3] = periodogram(demean_sunspot);
[log_periodogram,w4] = periodogram(log_sunspot);

figure
subplot(2,2,1)
hold on 
axis([0 1 -30 60])
plot(w1/max(w1), 10*log10(sunspot_periodogram))
plot(w3/max(w3), 10*log10(demean_periodogram))
title('Periodogram of Demean Sunspot Data')
xlabel('Normalised Frequency (rad/sample)')
ylabel('Power (dB)') 
legend({'sunspot','demean sunspot'})
grid on

subplot(2,2,2)
hold on 
axis([0 1 -30 60])
plot(w1/max(w1), 10*log10(sunspot_periodogram))
plot(w2/max(w2), 10*log10(detrend_periodogram))
title('Periodogram of Detrend Sunspot Data')
xlabel('Normalised Frequency (rad/sample)')
ylabel('Power (dB)') 
legend({'sunspot','detrend sunspot'})
grid on

subplot(2,2,3)
plot(w4/max(w4), 10*log10(log_periodogram))
title('Periodogram of Log of Sunspot Data')
xlabel('Normalised Frequency (rad/sample)')
ylabel('Power (dB)') 
grid on

subplot(2,2,4)
hold on 
plot(sunspot(:,1), 10*log10(trend))
title('Trend of Sunspot Data')
xlabel('time (year)')
ylabel('Sunspot Data') 
grid on