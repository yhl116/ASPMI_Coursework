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
title('Singular Values of X','FontSize',title_font_size);
xlabel('Index','FontSize',x_label_font_size);
ylabel('Singular Value Magnitude','FontSize',y_label_font_size);

subplot(1,2,2)
stem(S_noise);
axis([1 10 0 40]);
set(gca);
title('Singular Values of Xnoise','FontSize',title_font_size);
xlabel('Index','FontSize',x_label_font_size);
ylabel('Singular Value Magnitude','FontSize',y_label_font_size);

saveas(gcf,'part1/images/1_6_a_1.png')

error=(S-S_noise).^2;
figure('Renderer', 'painters', 'Position',[200,200,500,300])
stem(error);
axis([1 10 0 300]);
set(gca);
title('Squared Errors','FontSize',title_font_size);
xlabel('Index','FontSize',x_label_font_size);
ylabel('Squared Error Between Singular Values','FontSize',y_label_font_size);

saveas(gcf,'part1/images/1_6_a_2.png')