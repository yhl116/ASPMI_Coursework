clear all; clc;
load('font_size.mat')
legend_font_size=18;
x_label_font_size=18;
y_label_font_size=18;
title_font_size=18;

mu=1;
K=1024;

N=1500;
fs=1600;
noise_power=0.05;

f=zeros(N,1);
f(1:500)=100;
f(501:1000)=100+(1:500)./2;
f(1001:1500)=100+((1:500)./25).^2;
phase=cumsum(f);

x=exp(1j*(phase*2*pi/fs));
w=wgn(N,1,pow2db(0.05),'complex');
y=x+w;

[~,~,dft_clms_h]=dft_clms(y, mu, K, 0);
[~,~,leaky_dft_clms_h]=dft_clms(y, mu, K, 0.05);

figure()
surf(1:N, [0:K-1].*fs/K, abs(dft_clms_h), 'LineStyle', 'none');
view(2);
axis([0 1500 0 600])
title('DFT-CLMS Time-Frequency Prediction','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)

saveas(gcf,'images/3_3_c.png')

figure()
surf(1:N, [0:K-1].*fs/K, abs(leaky_dft_clms_h), 'LineStyle', 'none');
view(2);
axis([0 1500 0 600])
title('Leaky DFT-CLMS Time-Frequency Prediction','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)

saveas(gcf,'images/3_3_c_2.png')