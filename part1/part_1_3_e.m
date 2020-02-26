clc; clear all;
load('font_size.mat')

n = 0:30;
noise = 0.2/sqrt(2)*(randn(size(n))+1j*randn(size(n)));
x = exp(1j*2*pi*0.3*n)+exp(1j*2*pi*0.32*n)+ noise;

figure('Renderer', 'painters', 'Position',[200,200,500,300])
[X,R] = corrmtx(x,14,'mod');
[S,F] = pmusic(R,2,[ ],1,'corr'); 
plot(F,S,'linewidth',2); 
set(gca,'xlim',[0.25 0.40]); 
grid on; 
title('Pseudospectrum','FontSize',title_font_size)
xlabel('Hz','FontSize',x_label_font_size)
ylabel('Pseudospectrum','FontSize',y_label_font_size)

saveas(gcf,'part1/images/1_3_e.png')