clc; clear all;
load sunspot.dat;
load('font_size.mat')

demean_sunspot = sunspot(:,2) - mean(sunspot(:,2));
detrend_sunspot = detrend(sunspot(:,2));
trend = sunspot(:,2) - detrend_sunspot;
log_sunspot = log(sunspot(:,2) + 1e-20);

[sunspot_periodogram, w1] = periodogram(sunspot(:,2));
[detrend_periodogram, w2] = periodogram(detrend_sunspot);
[demean_periodogram,w3] = periodogram(demean_sunspot);
[log_periodogram,w4] = periodogram(log_sunspot);

figure('Renderer', 'painters', 'Position',[200,200,1000,600])
subplot(2,2,1)
hold on 
axis([0 1 -30 60])
plot(w1/max(w1), 10*log10(sunspot_periodogram))
plot(w3/max(w3), 10*log10(demean_periodogram))
title('Periodogram of Demean Sunspot Data','FontSize',title_font_size)
xlabel('Normalised Frequency (rad/sample)','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size) 
legend({'sunspot','demean sunspot'},'FontSize',legend_font_size)
grid on

subplot(2,2,2)
hold on 
axis([0 1 -30 60])
plot(w1/max(w1), 10*log10(sunspot_periodogram))
plot(w2/max(w2), 10*log10(detrend_periodogram))
title('Periodogram of Detrend Sunspot Data','FontSize',title_font_size)
xlabel('Normalised Frequency (rad/sample)','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size) 
legend({'sunspot','detrend sunspot'},'FontSize',legend_font_size)
grid on

subplot(2,2,3)
plot(w4/max(w4), 10*log10(log_periodogram))
title('Periodogram of Log of Sunspot Data','FontSize',title_font_size)
xlabel('Normalised Frequency (rad/sample)','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size) 
grid on

subplot(2,2,4)
hold on 
plot(sunspot(:,1), 10*log10(trend))
title('Trend of Sunspot Data','FontSize',title_font_size)
xlabel('time (year)','FontSize',x_label_font_size)
ylabel('Sunspot Data','FontSize',y_label_font_size) 
grid on

saveas(gcf,'part1/images/1_2_a.png')