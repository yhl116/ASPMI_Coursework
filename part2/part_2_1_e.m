clc; clear all;
load('font_size.mat')
load('part_2_1.mat')

a1 = 0.1;
a2 = 0.8;
sigma = 0.25;
mu1 = 0.05;
mu2 = 0.01; 
order = 2;

x0 = 0;
coef = [0.1,0.8];
num_samples = 1000;
noise_variance = 0.25;

%x(n) = a1x(n ? 1) + a2x(n ? 2) + ?(n)
model = arima('Constant',randn(1)*noise_variance,'AR',{a1,a2},'Variance',noise_variance);
x = simulate(model,num_samples);

[~, error_5, ~] = leaky_lms(x, mu1, order, 0.1);
[~, error_1, ~] = leaky_lms(x, mu2, order, 0.1);

num_realisations = 100;
e_realisations_5 = zeros(num_samples,num_realisations);
e_realisations_1 = zeros(num_samples,num_realisations);
w_realisations_5 = zeros(2,1001, num_realisations);
w_realisations_1 = zeros(2,1001, num_realisations);


for i=1:num_realisations
    temp_x = simulate(model,num_samples);
    [~,e_realisations_5(:,i),w_realisations_5(:,:,i)] = leaky_lms(temp_x, mu1, 2, 0.1);
    [~,e_realisations_1(:,i),w_realisations_1(:,:,i)] = leaky_lms(temp_x, mu2, 2, 0.1);
end

a_1_5_realisation_mean = mean(w_realisations_5(1,:,:),3);
a_2_5_realisation_mean = mean(w_realisations_5(2,:,:),3);
a_1_1_realisation_mean = mean(w_realisations_1(1,:,:),3);
a_2_1_realisation_mean = mean(w_realisations_1(2,:,:),3);

figure('Renderer', 'painters', 'Position',[200,200,1000,600])
subplot(2,2,1)
plot(w_realisations_5(1,:,1));
hold on
plot(w_realisations_5(2,:,1));
title('AR Coefficients, 1 Realisation, mu = 0.05','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('AR Coefficients','FontSize',y_label_font_size)
legend({'a_1','a_2'},'FontSize',legend_font_size)
grid on

subplot(2,2,2)
plot(w_realisations_1(1,:,1));
hold on
plot(w_realisations_1(2,:,1));
title('AR Coefficients, 1 Realisation, mu = 0.01','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('AR Coefficients','FontSize',y_label_font_size)
legend({'a_1','a_2'},'FontSize',legend_font_size)
grid on

subplot(2,2,3)
plot(a_1_5_realisation_mean);
hold on
plot(a_2_5_realisation_mean);
title('AR Coefficients, 100 Realisations, mu = 0.05','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('AR Coefficients','FontSize',y_label_font_size)
legend({'a_1','a_2'},'FontSize',legend_font_size)
grid on

subplot(2,2,4)
plot(a_1_1_realisation_mean);
hold on
plot(a_2_1_realisation_mean);
title('AR Coefficients, 100 Realisations, mu = 0.01','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('AR Coefficients','FontSize',y_label_font_size)
legend({'a_1','a_2'},'FontSize',legend_font_size)
grid on

% saveas(gcf,'images/2_1_d.png')

% saveas(gcf,'images/2_1_d_2.png')
