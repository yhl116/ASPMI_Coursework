clc; clear all;

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

[~, error_5, ~] = lms_ar_2(x, mu1, order);
[~, error, ~] = lms_ar(x, mu1, order);
[~, error_1, ~] = lms_ar_2(x, mu2, order);

num_realisations = 100;
e_realisations_5 = zeros(num_samples,num_realisations);
e_realisations_1 = zeros(num_samples,num_realisations);
for i=1:num_realisations
    temp_x = simulate(model,num_samples);
    [~,e_realisations_5(:,i),~] = lms_ar(temp_x, mu1, 2);
    [~,e_realisations_1(:,i),~] = lms_ar(temp_x, mu2, 2);
end

mean_error_5 = mean(e_realisations_5,2);
mean_error_1 = mean(e_realisations_1,2);

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,2,1)
title('LMS Estimator, Trial 1','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Squared Error (dB)','FontSize',y_label_font_size)
plot(10*log10(error_5.^2));
hold on
plot(10*log10(error_1.^2));
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
steady_state_5_mean = ones(1,length(steady_state_5)).*mean(steady_state_5);
steady_state_1_mean = ones(1,length(steady_state_1)).*mean(steady_state_1);
x_axis = linspace(700,1000,301);

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,2,1)
title('Steady State Mean, mu = 0.05','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Squared Error (dB)','FontSize',y_label_font_size)
plot(x_axis, 10*log10(steady_state_5.^2));
hold on
plot(x_axis, 10*log10(steady_state_5_mean.^2));
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