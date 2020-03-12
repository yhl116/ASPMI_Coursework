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
    [~, ~, w_gngd(:,:,i)] = lms_gngd(x_ma(:,i), noise(:,i), 0.01, 1, 0.001, 1);
    [~, ~, w_ben(:,:,i)] = lms_gngd(x_ma(:,i), noise(:,i), 0.01, 1, 0.001, 0.1);
end

gngd_mean = mean(w_gngd,3);
ben_mean = mean(w_ben,3);

figure('Renderer', 'painters', 'Position',[200,200,500,300])
plot(gngd_mean)
hold on 
plot(ben_mean)
axis([0 1000 0 1.1])
title('Benveniste?s GASS vs GNGD','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('w','FontSize',y_label_font_size) 
legend({'GNGD','Benveniste?s GASS'},'FontSize',legend_font_size, "Location", "southeast")
grid on