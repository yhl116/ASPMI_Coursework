load('EEG_Data_Assignment1')
load('font_size.mat')

K = 8192;
N = 1200;
mu = 1;
y=POz(1000:1000+N-1);
[~,~,h]=dft_clms(y, 1, K, 0);
[~,~,leaky_h]=dft_clms(y, mu, K, 0.001);

figure()
surf(1:N, [0:K-1].*fs/K, abs(h), 'LineStyle', 'none');
axis([0 1200 0 100])
view(2);
title('DFT-CLMS of EEG Data','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)

saveas(gcf,'images/3_3_d.png')

figure()
surf(1:N, [0:K-1].*fs/K, abs(leaky_h), 'LineStyle', 'none');
axis([0 1200 0 100])
view(2);
title('Leaky DFT-CLMS of EEG Data','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)

saveas(gcf,'images/3_3_d_2.png')

