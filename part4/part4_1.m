clear all; clc;
load('time-series.mat')

y_detrend = detrend(y);
y_demean = y - mean(y);

mu = 10^-5;
order = 4;

[x_hat, error, w] = lms_ar(y_demean, mu, order);

figure
plot(y_demean)
hold on
plot(x_hat)
legend(["x_hat","y_mean"])

mse = sum(error.^2)/length(error);
Rp = 10*log10(var(x_hat)/var(error));

%% question2

[x_hat_tanh, error_tanh, w_tanh] = lms_tanh(y_demean, mu, order,1);

figure
plot(y_demean)
hold on
plot(x_hat_tanh)
legend(["x_hat_tanh","y_mean"])

%% question3

[x_hat_tanh, error_tanh, w_tanh] = lms_tanh(y_demean, mu, order,30);

figure
plot(y_demean)
hold on
plot(x_hat_tanh)
legend(["x_hat_tanh","y_mean"])

%% question4

[x_hat_bias, error_bias, w_bias] = lms_tanh(y, mu, order,40);

figure
plot(y)
hold on
plot(x_hat_bias)
legend(["x_hat_tanh","y_mean"])

%% question 5









