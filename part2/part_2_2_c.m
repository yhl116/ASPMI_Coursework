clear all; clc;
load('font_size.mat')

order = 1;
realisation = 100;
N = 1000;
noise_variance = 0.5;
sd = sqrt(noise_variance);
noise = sd*randn(N, realisation);
w_gngd = zeros(order,N+1, realisation);
w_ben = zeros(order,N+1, realisation);

b = [1 0.9];
a = 1;
x_ma = filter(b,a,noise);

for i = 1:realisation
    [~, ~, w_gngd(:,:,i)] = lms_gngd(x_ma(:,i), noise(:,i), 0.001, 1, 0.001, 1);
    [~, ~, w_ben(:,:,i)] = lms_gass(x_ma(:,i), noise(:,i), 0.001, order, 'BE');
end

gngd_mean = mean(w_gngd,3);
ben_mean = mean(w_ben,3);

figure('Renderer', 'painters', 'Position',[200,200,500,300])
plot(gngd_mean)
hold on 
plot(ben_mean)
axis([0 1000 0 1.1])
title('Benvenistes GASS vs GNGD, 100 Realisations','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('w','FontSize',y_label_font_size) 
legend({'GNGD','Benvenistes GASS'},'FontSize',legend_font_size, "Location", "southeast")
grid on

saveas(gcf,'images/2_2_c.png')

steady_state_ben = mean(ben_mean(500:1000));
steady_state_gngd = mean(gngd_mean(500:1000));
ssvariance_ben = var(ben_mean(500:1000));
ssvariance_gngd = var(gngd_mean(500:1000));