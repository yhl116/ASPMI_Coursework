clc; clear all;
load('font_size.mat')
load('ideal_2_1.mat')

% a1 = 0.1;
% a2 = 0.8;
% sigma = 0.25;
% mu1 = 0.05;
% mu2 = 0.01; 
% order = 2;
% 
% x0 = 0;
% coef = [0.1,0.8];
% num_samples = 1000;
% noise_variance = 0.25;
% 
% %x(n) = a1x(n ? 1) + a2x(n ? 2) + ?(n)
% model = arima('Constant',randn(1)*noise_variance,'AR',{a1,a2},'Variance',noise_variance);
% x = simulate(model,num_samples);
% 
% [~, error_5, ~] = leaky_lms(x, mu1, order, 0.1);
% [~, error_1, ~] = leaky_lms(x, mu2, order, 0.1);
% 
num_realisations = 100;
e_realisations_5_1 = zeros(num_samples,num_realisations);
e_realisations_1_1 = zeros(num_samples,num_realisations);
w_realisations_5_1 = zeros(2,1001, num_realisations);
w_realisations_1_1 = zeros(2,1001, num_realisations);
e_realisations_5_5 = zeros(num_samples,num_realisations);
e_realisations_1_5 = zeros(num_samples,num_realisations);
w_realisations_5_5 = zeros(2,1001, num_realisations);
w_realisations_1_5 = zeros(2,1001, num_realisations);
e_realisations_5_9 = zeros(num_samples,num_realisations);
e_realisations_1_9 = zeros(num_samples,num_realisations);
w_realisations_5_9 = zeros(2,1001, num_realisations);
w_realisations_1_9 = zeros(2,1001, num_realisations);


for i=1:num_realisations
    temp_x = simulate(model,num_samples);
    [~,e_realisations_5_1(:,i),w_realisations_5_1(:,:,i)] = leaky_lms(temp_x, mu1, 2, 0.1);
    [~,e_realisations_1_1(:,i),w_realisations_1_1(:,:,i)] = leaky_lms(temp_x, mu2, 2, 0.1);
    [~,e_realisations_5_5(:,i),w_realisations_5_5(:,:,i)] = leaky_lms(temp_x, mu1, 2, 0.5);
    [~,e_realisations_1_5(:,i),w_realisations_1_5(:,:,i)] = leaky_lms(temp_x, mu2, 2, 0.5);
    [~,e_realisations_5_9(:,i),w_realisations_5_9(:,:,i)] = leaky_lms(temp_x, mu1, 2, 0.9);
    [~,e_realisations_1_9(:,i),w_realisations_1_9(:,:,i)] = leaky_lms(temp_x, mu2, 2, 0.9);
end

a_1_5_1_realisation_mean = mean(w_realisations_5_1(1,:,:),3);
a_2_5_1_realisation_mean = mean(w_realisations_5_1(2,:,:),3);
a_1_1_1_realisation_mean = mean(w_realisations_1_1(1,:,:),3);
a_2_1_1_realisation_mean = mean(w_realisations_1_1(2,:,:),3);
a_1_5_5_realisation_mean = mean(w_realisations_5_5(1,:,:),3);
a_2_5_5_realisation_mean = mean(w_realisations_5_5(2,:,:),3);
a_1_1_5_realisation_mean = mean(w_realisations_1_5(1,:,:),3);
a_2_1_5_realisation_mean = mean(w_realisations_1_5(2,:,:),3);
a_1_5_9_realisation_mean = mean(w_realisations_5_9(1,:,:),3);
a_2_5_9_realisation_mean = mean(w_realisations_5_9(2,:,:),3);
a_1_1_9_realisation_mean = mean(w_realisations_1_9(1,:,:),3);
a_2_1_9_realisation_mean = mean(w_realisations_1_9(2,:,:),3);

figure('Renderer', 'painters', 'Position',[200,200,1000,600])
subplot(2,3,1)
plot(a_1_1_1_realisation_mean);
hold on
plot(a_2_1_1_realisation_mean);
title('AR Coefficients, mu = 0.01, gamma = 0.1','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('AR Coefficients','FontSize',y_label_font_size)
legend({'a_1','a_2'},'FontSize',legend_font_size)
grid on

subplot(2,3,2)
plot(a_1_1_5_realisation_mean);
hold on
plot(a_2_1_5_realisation_mean);
title('AR Coefficients, mu = 0.01, gamma = 0.5','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('AR Coefficients','FontSize',y_label_font_size)
legend({'a_1','a_2'},'FontSize',legend_font_size)
grid on

subplot(2,3,3)
plot(a_1_1_9_realisation_mean);
hold on
plot(a_2_1_9_realisation_mean);
title('AR Coefficients, mu = 0.01, gamma = 0.9','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('AR Coefficients','FontSize',y_label_font_size)
legend({'a_1','a_2'},'FontSize',legend_font_size)
grid on

subplot(2,3,4)
plot(a_1_5_1_realisation_mean);
hold on
plot(a_2_5_1_realisation_mean);
title('AR Coefficients, 1 Realisation, mu = 0.05','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('AR Coefficients','FontSize',y_label_font_size)
legend({'a_1','a_2'},'FontSize',legend_font_size)
grid on

subplot(2,3,5)
plot(a_1_5_1_realisation_mean);
hold on
plot(a_2_5_1_realisation_mean);
title('AR Coefficients, 1 Realisation, mu = 0.05','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('AR Coefficients','FontSize',y_label_font_size)
legend({'a_1','a_2'},'FontSize',legend_font_size)
grid on

subplot(2,3,6)
plot(a_1_5_1_realisation_mean);
hold on
plot(a_2_5_1_realisation_mean);
title('AR Coefficients, 1 Realisation, mu = 0.05','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('AR Coefficients','FontSize',y_label_font_size)
legend({'a_1','a_2'},'FontSize',legend_font_size)
grid on

% saveas(gcf,'images/2_1_d.png')

% saveas(gcf,'images/2_1_d_2.png')
