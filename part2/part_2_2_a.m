% load('font_size.mat')
load('x_ma.mat')

realisation = 1;
N = 1000;
noise_variance = 0.5;
sd = sqrt(noise_variance);
noise = sd*randn(N, realisation);
order = 1;

b = [1 0.9];
a = 1;
x_ma = filter(b,a,noise);



[x_hat, error, w] = lms_gass(x_ma, noise, 0.001, order, 'AF');
[x_hat, error, w] = lms_ar(x_ma, 0.01, 1);

figure
plot(w)
