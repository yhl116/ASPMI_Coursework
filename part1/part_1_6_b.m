clc; clear all;
load('PCAPCR.mat');
load('font_size.mat')

[U_noise,S_noise,V_noise]=svd(Xnoise);

[m,n] = size(Xnoise);

Xnoise_low_rank = U_noise(1:m,1:3)*S_noise(1:3,1:3)*V_noise(1:n,1:3)';