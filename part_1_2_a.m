clc; clear all;
load sunspot.dat;

demean_sunspot = sunspot(:,2) - mean(sunspot(:,2));
detrend_sunspot = detrend(sunspot(:,2));

figure

plot(sunspot(:,1), sunspot(:,2))
grid on
title('Sunspot data')
xlabel('Time (year)') 

figure 
plot(sunspot(:,1), demean_sunspot)
grid on
title('Sunspot - mean')
xlabel('Time (year)') 

figure
plot(sunspot(:,1), detrend_sunspot)
grid on
title('Sunspot Detrend')
xlabel('Time (year)') 

%whats the difference between different autocorrelation function call?

figure
trend = sunspot(:,2) - detrend_sunspot;
plot(sunspot(:,1), trend)
grid on
title('Trend of Sunspot')
xlabel('Time (year)') 


log_sunspot = arrayfun(@(x) log(x), sunspot(:,2));

figure
plot(sunspot(:,1), log_sunspot, sunspot(:,1), sunspot(:,2))
legend({'log of sunspot','sunspot'})
grid on
title('Log of Sunspot')
xlabel('Time (year)') 

sunspot_periodogram = periodogram(sunspot(:,2));
detrend_periodogram = periodogram(detrend_sunspot);
demean_periodogram = periodogram(demean_sunspot);

figure
subplot(1,3,1)
plot(sunspot_periodogram)
grid on
subplot(1,3,2)
plot(detrend_periodogram)
grid on
subplot(1,3,3)
plot(demean_periodogram)
grid on
