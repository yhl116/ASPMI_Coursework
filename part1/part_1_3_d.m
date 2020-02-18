clc; clear all;

n = 0:100;
noise = 0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n))); 
x = exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.32*n)+ noise;

[x_periodogram, x_w] = periodogram(x);

figure
plot(x_w, 10*log10(x_periodogram))
% hold on
% 
% n = 0:100;
% noise = 0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n))); 
% x = exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.32*n)+ noise;
% plot(x_w, 10*log10(x_periodogram))
