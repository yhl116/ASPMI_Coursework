clc; clear all;
coeff = [2.76, -3.81, 2.65, -0.92];
N = 10000;

model = arima('constant', 0, 'AR', coeff, 'variance', 1);
x = simulate(model,N);
x = x(500:end);

p_2 = aryule(x,2);
p_4 = aryule(x,4);
p_8 = aryule(x,8);
p_14 = aryule(x,14);

[h_ideal, w_ideal] = freqz(1, [1 -coeff],9500);
[h_2, ~] = freqz(1, p_2,9500);
[h_4, ~] = freqz(1, p_4,9500);
[h_8, ~] = freqz(1, p_8,9500);
[h_14, ~] = freqz(1, p_14,9500);

figure
title('Log of PSD Estimate of Noisy Sinewave')
plot(w_ideal, abs(h_ideal));
hold on
plot(w_ideal, abs(h_2));
plot(w_ideal, abs(h_4));
plot(w_ideal, abs(h_8));
plot(w_ideal, abs(h_14));
xlabel('Normalised Frequency')
ylabel('Power')
grid on
legend({'ideal','p = 2', 'p = 4', 'p = 8', 'p = 14'})

figure
plot(w_ideal, abs(h_8));

figure
plot(w_ideal, abs(h_ideal));