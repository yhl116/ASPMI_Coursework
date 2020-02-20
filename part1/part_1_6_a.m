clc; clear all;
load('PCAPCR.mat');
load('font_size.mat')

[~,S,~]=svd(X);
S=diag(S(1:10,:));
[~,S_noise,~]=svd(Xnoise);
S_noise=diag(S_noise(1:10,:));

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,2,1)
stem(S);
axis([1 10 0 40]);
set(gca);
title('Singular Values of X');
xlabel('Index');
ylabel('Singular Value Magnitude');

subplot(1,2,2)
stem(S_noise);
axis([1 10 0 40]);
set(gca);
title('Singular Values of Xnoise');
xlabel('Index');
ylabel('Singular Value Magnitude');

error=(S-S_noise).^2;

figure(3);
stem(error);
axis([1 10 0 300]);
set(gca);
title('Squared Errors');
xlabel('Index');
ylabel('Squared Error Between Singular Values');