clc; clear all;
% load('font_size.mat')
load('x_ma.mat')

realisation = 100;
N = 1000;
noise_variance = 0.5;
sd = sqrt(noise_variance);
noise = sd*randn(N, realisation);
order = 1;

% w initialisation
w_ben = zeros(order,N+1, realisation);
w_af = zeros(order,N+1, realisation);
w_mx = zeros(order,N+1, realisation);
w_std = zeros(order,N+1, realisation);
w_std_2 = zeros(order,N+1, realisation);

b = [1 0.9];
a = 1;
x_ma = filter(b,a,noise);

rho = 0.001;

for i = 1:realisation
    [~, ~, w_ben(:,:,i)] = lms_gass(x_ma(:,i), noise(:,i), 0.001, order, 'BE');
    [~, ~, w_af(:,:,i)] = lms_gass(x_ma(:,i), noise(:,i), 0.001, order, 'AF');
    [~, ~, w_mx(:,:,i)] = lms_gass(x_ma(:,i), noise(:,i), 0.001, order, 'MX');
    [~, ~, w_std(:,:,i)] = lms_ar_2(x_ma(:,i), noise(:,i),0.01, order);
    [~, ~, w_std_2(:,:,i)] = lms_ar_2(x_ma(:,i),noise(:,i), 0.1, order);
end

ben_mean = mean(w_ben,3);
af_mean = mean(w_af, 3);
mx_mean = mean(w_mx,3);
std_mean = mean(w_std,3);
std_mean_2 = mean(w_std_2,3);


figure
plot(ben_mean)
hold on
plot(af_mean)
plot(mx_mean)
plot(std_mean)
plot(std_mean_2)
