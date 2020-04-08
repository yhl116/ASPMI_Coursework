clear all; clc;
load('time-series.mat')
load('font_size.mat')

y_detrend = detrend(y);
y_demean = y - mean(y);

mu = 10^-5;
order = 4;

[x_hat, error, w] = lms_ar(y_demean, mu, order);

figure('Renderer', 'painters', 'Position',[100,100,500,300])
plot(y_demean)
hold on
plot(x_hat)
title('Zero-mean Signal and LMS Prediction','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('y','FontSize',y_label_font_size) 
legend({'Zero-mean Signal','LMS Prediction'},'FontSize',legend_font_size)
grid on

saveas(gcf,'images//LMSy.png')

mse = sum(error.^2)/length(error);
Rp = 10*log10(var(x_hat)/var(error));

%% question2

[x_hat_tanh, error_tanh, w_tanh] = lms_tanh(y_demean, mu, order,1);

figure('Renderer', 'painters', 'Position',[100,100,500,300])
plot(y_demean)
hold on
plot(x_hat_tanh)
title('Zero-mean Signal and Tanh LMS Prediction','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('y','FontSize',y_label_font_size) 
legend({'Zero-mean Signal','Tanh LMS Prediction'},'FontSize',legend_font_size)
grid on

saveas(gcf,'images/TanhLMSy.png')

mse_2 = sum(error_tanh.^2)/length(error_tanh);
Rp_2 = 10*log10(var(x_hat_tanh)/var(error_tanh));

%% question3

[x_hat_tanh, error_tanh, w_tanh] = lms_tanh(y_demean, mu, order,50);

figure('Renderer', 'painters', 'Position',[100,100,500,300])
plot(y_demean)
hold on
plot(x_hat_tanh)
title('Zero-mean Signal and Tanh LMS Prediction','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('y','FontSize',y_label_font_size) 
legend({'Zero-mean Signal','Tanh LMS Prediction'},'FontSize',legend_font_size)
grid on

saveas(gcf,'images/aTanhLMSy.png')

mse_3 = sum(error_tanh.^2)/length(error_tanh);
Rp_3 = 10*log10(var(x_hat_tanh)/var(error_tanh));

%% question4

[x_hat_bias, error_bias, w_bias] = lms_tanh_bias(y, mu, order,50);

figure('Renderer', 'painters', 'Position',[100,100,500,300])
plot(y)
hold on
plot(x_hat_bias)
title('Biased Signal and Tanh LMS Prediction','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('y','FontSize',y_label_font_size) 
legend({'True Signal','Tanh LMS Prediction'},'FontSize',legend_font_size)
grid on

saveas(gcf,'images/biasTanhLMSy.png')

mse_4 = sum(error_bias.^2)/length(error_bias);
Rp_4 = 10*log10(var(x_hat_bias)/var(error_bias));

%% question 5
N = length(y);
x = y;
w = zeros(order+1, N);
x_hat = zeros(N, 1);
error = zeros(N, 1);
a = 50;
v = zeros(order+1, 1);

for iterations = 1:100
    N = length(x);

    error(1) = x(1);
    [x_hat_bias, error_bias, w] = train_all(y, x_hat, w, error, mu, order,50);
    w = ones(order+1, N).*w(:,end);
end
[x_hat_bias, error_bias, w_bias2] = train_all(y, x_hat, w, error, mu, order,50);

mse_5 = sum(error_bias.^2)/length(error_bias);
Rp_5 = 10*log10(var(x_hat_bias)/var(error_bias));


figure('Renderer', 'painters', 'Position',[100,100,500,300])
plot(y)
hold on
plot(x_hat_bias)
title('Biased Signal and Tanh LMS Prediction with Pre-Trained Weights','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('y','FontSize',y_label_font_size) 
legend({'True Signal','Tanh LMS Prediction'},'FontSize',legend_font_size)
grid on

saveas(gcf,'images/iterations.png')








