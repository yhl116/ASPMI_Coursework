clc; clear all;
load('font_size.mat')

n = 0:30;
noise = 0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n))); 
x_30 = exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.32*n)+ noise;
[psd_x_30, w_30] = periodogram(x_30);

n = 0:100;
noise = 0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n))); 
x_100 = exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.32*n)+ noise;
[psd_x_100, w_100] = periodogram(x_100);

n = 0:10000;
noise = 0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n))); 
x_10000 = exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.32*n)+ noise;
[psd_x_10000, w_10000] = periodogram(x_10000);

figure
subplot(1,3,1)
plot(w_30/max(w_30), 10*log10(psd_x_30))
grid on

subplot(1,3,2)
plot(w_100/max(w_100), 10*log10(psd_x_100))
grid on

subplot(1,3,3)
plot(w_10000/max(w_10000), 10*log10(psd_x_10000))
grid on