clc; clear all;
load('font_size.mat')

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

[~, error_5, ~] = lms_ar(x, mu1, order);
[~, error_1, ~] = lms_ar(x, mu2, order);

num_realisations = 100;
e_realisations_5 = zeros(num_samples,num_realisations);
e_realisations_1 = zeros(num_samples,num_realisations);
w_realisations_5 = zeros(2,1001, num_realisations);
w_realisations_1 = zeros(2,1001, num_realisations);


for i=1:num_realisations
    temp_x = simulate(model,num_samples);
    [~,e_realisations_5(:,i),w_realisations_5(:,:,i)] = lms_ar(temp_x, mu1, 2);
    [~,e_realisations_1(:,i),w_realisations_1(:,:,i)] = lms_ar(temp_x, mu2, 2);
end

mean_error_5 = mean(e_realisations_5,2);
mean_error_1 = mean(e_realisations_1,2);

figure
plot(mean_error_5.^2)

% load("ideal_2_1.mat");

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,2,1)
plot(10*log10(error_5.^2));
hold on
plot(10*log10(error_1.^2));
title('LMS Estimator, Trial 1','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Squared Error (dB)','FontSize',y_label_font_size)
legend({'mu = 0.05','mu = 0.01'},'FontSize',legend_font_size,'Location','southeast')
grid on

subplot(1,2,2)
plot(10*log10(mean_error_5.^2));
hold on
plot(10*log10(mean_error_1.^2));
title('LMS Estimator, 100 Realisations','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Squared Error (dB)','FontSize',y_label_font_size)
legend({'mu = 0.05','mu = 0.01'},'FontSize',legend_font_size,'Location','southeast')
grid on

% saveas(gcf,'images/2_1_b.png')

steady_state_5 = mean_error_5(700:num_samples);
steady_state_1 = mean_error_1(700:num_samples);
mean_5 = 10*log10(mean(steady_state_5)^2);
mean_1 = 10*log10(mean(steady_state_1)^2);
steady_state_5_mean = ones(1,length(steady_state_5)).*mean(steady_state_5);
steady_state_1_mean = ones(1,length(steady_state_1)).*mean(steady_state_1);
x_axis = linspace(700,1000,301);

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,2,1)
plot(x_axis, 10*log10(steady_state_5.^2));
hold on
plot(x_axis, 10*log10(steady_state_5_mean.^2));
title('Steady State Mean, mu = 0.05','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Squared Error (dB)','FontSize',y_label_font_size)
axis([700 1000 -30 -20]);
legend({'Signal','Mean of signal accross time'},'FontSize',legend_font_size,'Location','northeast')
grid on

subplot(1,2,2)
plot(x_axis, 10*log10(steady_state_1.^2));
hold on
plot(x_axis, 10*log10(steady_state_1_mean.^2));
title('Steady State Mean, mu = 0.01','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Squared Error (dB)','FontSize',y_label_font_size)
axis([700 1000 -30 -20]);
legend({'Signal','Mean of signal accross time'},'FontSize',legend_font_size,'Location','northeast')
grid on

% saveas(gcf,'images/2_1_c.png')

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

steady_state_a_1_5 = a_1_5_realisation_mean(700:num_samples);
steady_state_a_2_5 = a_2_5_realisation_mean(700:num_samples);
steady_state_a_1_1 = a_1_1_realisation_mean(900:num_samples);
steady_state_a_2_1 = a_2_1_realisation_mean(900:num_samples);
x_1 = linspace(700,1000,301);
x_5 = linspace(900,1000,101);
steady_state_a_1_5_mean = mean(steady_state_a_1_5);
steady_state_a_2_5_mean = mean(steady_state_a_2_5);
steady_state_a_1_1_mean = mean(steady_state_a_1_1);
steady_state_a_2_1_mean = mean(steady_state_a_2_1);
a_1_5_mean = ones(1,101).*steady_state_a_1_5_mean;
a_2_5_mean = ones(1,101).*steady_state_a_2_5_mean;
a_1_1_mean = ones(1,101).*steady_state_a_1_1_mean;
a_2_1_mean = ones(1,101).*steady_state_a_2_1_mean;

figure('Renderer', 'painters', 'Position',[200,200,1000,450])
subplot(1,2,1)
plot(x_5, steady_state_a_1_5(200:300));
hold on
plot(x_5, steady_state_a_1_1);
plot(x_5,a_1_5_mean);
plot(x_5,a_1_1_mean);
title('a_1 Steady State Mean','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('a_1','FontSize',y_label_font_size)
axis([900 1000 0.07 0.15]);
legend({'a_1, mu = 0.05','a_1, mu = 0.01', 'a_1 mean, mu = 0.05','a_1 mean, mu = 0.01'},'FontSize',legend_font_size,'Location','northeast')
grid on

subplot(1,2,2)
plot(x_5, steady_state_a_2_5(200:300));
hold on
plot(x_5, steady_state_a_2_1);
plot(x_5,a_2_5_mean);
plot(x_5,a_2_1_mean);
title('a_2 Steady State Mean','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('a_2','FontSize',y_label_font_size)
axis([900 1000 0.73 0.9]);
legend({'a_2, mu = 0.05','a_2, mu = 0.01', 'a_2 mean, mu = 0.05','a_2 mean, mu = 0.01'},'FontSize',legend_font_size,'Location','northeast')
grid on

% saveas(gcf,'images/2_1_d_2.png')
