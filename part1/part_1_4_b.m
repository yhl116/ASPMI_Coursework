clc; clear all;
load('font_size.mat')

coeff = [2.76, -3.81, 2.65, -0.92];
N = 1000;

model = arima('constant', 0, 'AR', coeff, 'variance', 1);
x = simulate(model,N);
x = x(500:end);

p_2 = aryule(x,2);
p_4 = aryule(x,4);
p_8 = aryule(x,8);
p_14 = aryule(x,14);

[h_ideal, w_ideal] = freqz(1, [1 -coeff],length(x));
[h_2, ~] = freqz(1, p_2,length(x));
[h_4, ~] = freqz(1, p_4,length(x));
[h_8, ~] = freqz(1, p_8,length(x));
[h_14, ~] = freqz(1, p_14,length(x));

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,2,1)
plot(w_ideal/max(w_ideal), 10*log10(abs(h_ideal)));
title('Estimates Using AR Model of Order p, 500 Samples','FontSize',title_font_size)
hold on
plot(w_ideal/max(w_ideal), 10*log10(abs(h_2)));
plot(w_ideal/max(w_ideal), 10*log10(abs(h_4)));
plot(w_ideal/max(w_ideal), 10*log10(abs(h_8)));
plot(w_ideal/max(w_ideal), 10*log10(abs(h_14)));
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)
grid on
legend({'ideal','p = 2', 'p = 4', 'p = 8', 'p = 14'},'FontSize',legend_font_size)

coeff = [2.76, -3.81, 2.65, -0.92];

N = 10000;
model = arima('constant', 0, 'AR', coeff, 'variance', 1);
x = simulate(model,N);
x = x(500:end);

p_2 = aryule(x,2);
p_4 = aryule(x,4);
p_8 = aryule(x,8);
p_14 = aryule(x,14);

[h_ideal, w_ideal] = freqz(1, [1 -coeff],length(x));
[h_2, ~] = freqz(1, p_2,length(x));
[h_4, ~] = freqz(1, p_4,length(x));
[h_8, ~] = freqz(1, p_8,length(x));
[h_14, ~] = freqz(1, p_14,length(x));

subplot(1,2,2)
plot(w_ideal/max(w_ideal), 10*log10(abs(h_ideal)));
title('Estimates Using AR Model of Order p, 9500 Samples','FontSize',title_font_size)
hold on
plot(w_ideal/max(w_ideal), 10*log10(abs(h_2)));
plot(w_ideal/max(w_ideal), 10*log10(abs(h_4)));
plot(w_ideal/max(w_ideal), 10*log10(abs(h_8)));
plot(w_ideal/max(w_ideal), 10*log10(abs(h_14)));
xlabel('Normalised Frequency','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)
grid on
legend({'ideal','p = 2', 'p = 4', 'p = 8', 'p = 14'},'FontSize',legend_font_size)

saveas(gcf,'part1/images/1_4_b.png')
