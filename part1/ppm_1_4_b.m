load('font_size.mat')
line_width = 1
axis_font_size = 14
x_axis_font_size = 14
y_axis_font_size = 14

a=[2.76, -3.81, 2.65, -0.92];
model=arima('Constant',0,'AR',a,'Variance',1);
x=simulate(model,1000);
x=x(501:end);

models=[4,8,10,14];

legend_str{1, 1} = char('Ideal Spectrum'); 

for i = 1:length(models)
    % use aryule function to determine coefficients as well as estimated error
    [a_predicted, noise_var] = aryule(x, models(i));

    % generate model based estimate of PSD
    [magnitudes(:, i), ~] = freqz(noise_var^(1/2), a_predicted, length(x));
    
    % create string for legend
    legend_str{1, i+1} = char(sprintf('Model - Based Method: Order %d', models(i))); 
    
end
[ideal, w] = freqz(1^(1/2), [1 -a], length(x));

%% model = 4
figure(1);
plot(w/pi, abs(ideal).^2, 'LineWidth', line_width);
hold on
plot(w/pi, abs(magnitudes(:, 1)).^2, 'LineWidth', line_width);
hold off
set(gca,'fontsize',axis_font_size);
title('Model Order=4, n=500','FontSize',title_font_size*32/24);
xlabel('Normalised Frequency', 'FontSize', x_axis_font_size);
ylabel('Power/Frequency', 'FontSize', y_axis_font_size);
legend({'Ideal Spectrum','Model - Based Method'}, 'Fontsize',legend_font_size);
% graph_saving('../report/images/part2/ar_spectrum_estimate_order_4');

%% model = 8
figure(2)
plot(w/pi, abs(ideal).^2, 'LineWidth', line_width);
hold on
plot(w/pi, abs(magnitudes(:, 2)).^2, 'LineWidth', line_width);
hold off
set(gca,'fontsize',axis_font_size);
title('Model Order=8, n=500','FontSize',title_font_size*32/24);
xlabel('Normalised Frequency', 'FontSize', x_axis_font_size);
ylabel('Power/Frequency', 'FontSize', y_axis_font_size);
legend({'Ideal Spectrum','Model - Based Method'}, 'Fontsize', legend_font_size);
% graph_saving('../report/images/part2/ar_spectrum_estimate_order_8');

%% model = 10
figure(3)
plot(w/pi, abs(ideal).^2, 'LineWidth', line_width);
hold on
plot(w/pi, abs(magnitudes(:, 3)).^2, 'LineWidth', line_width);
hold off
set(gca,'fontsize',axis_font_size);
title('Model Order=10, n=500','FontSize',title_font_size*32/24);
xlabel('Normalised Frequency', 'FontSize', x_axis_font_size);
ylabel('Power/Frequency', 'FontSize', y_axis_font_size);
legend({'Ideal Spectrum','Model - Based Method'}, 'Fontsize', legend_font_size);
% graph_saving('../report/images/part2/ar_spectrum_estimate_order_10');

%% model = 14
figure(4)
plot(w/pi, abs(ideal).^2, 'LineWidth', line_width);
hold on
plot(w/pi, abs(magnitudes(:, 4)).^2, 'LineWidth', line_width);
hold off
set(gca,'fontsize',axis_font_size);
title('Model Order=14, n=500','FontSize',title_font_size*32/24);
xlabel('Normalised Frequency', 'FontSize', x_axis_font_size);
ylabel('Power/Frequency', 'FontSize', y_axis_font_size);
legend({'Ideal Spectrum','Model - Based Method'}, 'Fontsize', legend_font_size);
% graph_saving('../report/images/part2/ar_spectrum_estimate_order_14');