clc; clear all;
load('PCAPCR.mat');
load('font_size.mat')

[U_noise,S_noise,V_noise]=svd(Xnoise);

[m,n] = size(Xnoise);

Xnoise_low_rank = U_noise(1:m,1:3)*S_noise(1:3,1:3)*V_noise(1:n,1:3)';
Xlow_rank_X = (norm((X-Xnoise_low_rank), 'fro'))^2
Xnoise_X = (norm((X-Xnoise), 'fro'))^2
Xnoise_Xlow_rank_X = (norm((Xlow_rank_X-Xnoise), 'fro'))^2