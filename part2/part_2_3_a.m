clc; clear all;
load('font_size.mat');
legend_font_size = 10;

f=0.005;
N=1000;
t=1:N;
sine = sin(2*pi*f*t);

noise_power = 1;
b=[1 0 0.5];
a=1;

realisations=100;
mu=0.01;
order=1;

y=zeros(N,realisations);

x_hat_1=zeros(realisations,N);
x_hat_2=zeros(realisations,N);
x_hat_3=zeros(realisations,N);
x_hat_4=zeros(realisations,N);
x_hat_25=zeros(realisations,N);

error_delta_1=zeros(realisations,N-1);
error_delta_2=zeros(realisations,N-1);
error_delta_3=zeros(realisations,N-1);
error_delta_4=zeros(realisations,N-1);
error_delta_25=zeros(realisations,N-1);

mpse=zeros(realisations,4);
delay=[1,2,3,4];

for i=1:realisations
    w=get_noise(N,noise_power);
    filtered_noise=filter(b,a,w);
    y(:,i)=sine'+filtered_noise;
    
    [x_hat_1(i,:), error_delta_1(i,:)] = ale(y(:,i),mu,delay(1),order);
    mpse(i,1)=sum((sine-x_hat_1(i,:)).^2)/N;
    [x_hat_2(i,:), error_delta_2(i,:)] = ale(y(:,i),mu,delay(2),order);
    mpse(i,2)=sum((sine-x_hat_2(i,:)).^2)/N;
    [x_hat_3(i,:), error_delta_3(i,:)] = ale(y(:,i),mu,delay(3),order);
    mpse(i,3)=sum((sine-x_hat_3(i,:)).^2)/N;
    [x_hat_4(i,:), error_delta_4(i,:)] = ale(y(:,i),mu,delay(4),order);
    mpse(i,4)=sum((sine-x_hat_4(i,:)).^2)/N;
    [x_hat_25(i,:), error_delta_25(i,:)] = ale(y(:,i),mu,25,order);
    mpse_25=sum((sine-x_hat_25(i,:)).^2)/N;
end

x_hat_1_mean=mean(x_hat_1);
x_hat_2_mean=mean(x_hat_2);
x_hat_3_mean=mean(x_hat_3);
x_hat_4_mean=mean(x_hat_4);

error_delta_1_mean=mean(error_delta_1);
error_delta_2_mean=mean(error_delta_2);
error_delta_3_mean=mean(error_delta_3);
error_delta_4_mean=mean(error_delta_4);

mpse_mean=mean(mpse);

%% Plot Mean Denoised Signal 2_3_a
figure('Renderer', 'painters', 'Position',[200,200,1000,600])
subplot(2,2,1)
plot(t,x_hat_1_mean);
title('Denoised Signal, \Delta = 1','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Magnitude','FontSize',y_label_font_size)
axis([0 1000 -1 1])
grid on

subplot(2,2,2)
plot(t,x_hat_2_mean);
title('Denoised Signal, \Delta = 2','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Magnitude','FontSize',y_label_font_size)
axis([0 1000 -1 1])
grid on

subplot(2,2,3)
plot(t,x_hat_3_mean);
title('Denoised Signal, \Delta = 3','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Magnitude','FontSize',y_label_font_size)
axis([0 1000 -1 1])
grid on

subplot(2,2,4)
plot(t,x_hat_4_mean);
title('Denoised Signal, \Delta = 4','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Magnitude','FontSize',y_label_font_size)
axis([0 1000 -1 1])
grid on

saveas(gcf,'images/2_3_a.png')

%% Plot Denoise vs Noisy 2_3_a_2
figure('Renderer', 'painters', 'Position',[200,200,1000,600])
subplot(2,2,1)
for i=1:realisations
    h1=plot(y(:,i), 'red');
    if i==1
        hold on;
    end
end
for i=1:realisations
    h2=plot(x_hat_1(i,:), 'blue');
end
h3=plot(sine, 'g');
title('Noisy Signal vs Denoised Signal, \Delta = 1','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Magnitude','FontSize',y_label_font_size)
legend([h1 h2 h3],{'100 Realisation of Noisy Sine Wave','100 Realisations of Denoised Sine Wave','Clean Sine Wave'},'FontSize',legend_font_size);
axis([0 1000 -7 7])
grid on

subplot(2,2,2)
for i=1:realisations
    h1=plot(y(:,i), 'r');
    if i==1
        hold on;
    end
end
for i=1:realisations
    h2=plot(x_hat_2(i,:), 'b');
end
h3=plot(sine, 'g');
title('Noisy Signal vs Denoised Signal, \Delta = 2','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Magnitude','FontSize',y_label_font_size)
legend([h1 h2 h3],{'100 Realisation of Noisy Sine Wave','100 Realisations of Denoised Sine Wave','Clean Sine Wave'},'FontSize',legend_font_size);
axis([0 1000 -7 7])
grid on

subplot(2,2,3)
for i=1:realisations
    h1=plot(y(:,i), 'r');
    if i==1
        hold on;
    end
end
for i=1:realisations
    h2=plot(x_hat_3(i,:), 'b');
end
h3=plot(sine, 'g');
title('Noisy Signal vs Denoised Signal, \Delta = 3','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Magnitude','FontSize',y_label_font_size)
legend([h1 h2 h3],{'100 Realisation of Noisy Sine Wave','100 Realisations of Denoised Sine Wave','Clean Sine Wave'},'FontSize',legend_font_size);
axis([0 1000 -7 7])
grid on

subplot(2,2,4)
for i=1:realisations
    h1=plot(y(:,i), 'r');
    if i==1
        hold on;
    end
end
for i=1:realisations
    h2=plot(x_hat_4(i,:), 'b');
end
h3=plot(sine, 'g');
title('Noisy Signal vs Denoised Signal, \Delta = 4','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Magnitude','FontSize',y_label_font_size)
legend([h1 h2 h3],{'100 Realisation of Noisy Sine Wave','100 Realisations of Denoised Sine Wave','Clean Sine Wave'},'FontSize',legend_font_size);
axis([0 1000 -7 7])
grid on

saveas(gcf,'images/2_3_a_2.png')

%% Plot Delta = 25; 2_3_b_2
figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,2,1)
for i=1:realisations
    h1=plot(y(:,i), 'r');
    if i==1
        hold on;
    end
end
for i=1:realisations
    h2=plot(x_hat_3(i,:), 'b');
end
h3=plot(sine, 'g');
title('Noisy Signal vs Denoised Signal, \Delta = 3','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Magnitude','FontSize',y_label_font_size)
legend([h1 h2 h3],{'100 Realisation of Noisy Sine Wave','100 Realisations of Denoised Sine Wave','Clean Sine Wave'},'FontSize',legend_font_size);
axis([0 1000 -7 7])
grid on

subplot(1,2,2)
for i=1:realisations
    h1=plot(y(:,i), 'r');
    if i==1
        hold on;
    end
end
for i=1:realisations
    h2=plot(x_hat_25(i,:), 'b');
end
h3=plot(sine, 'g');
title('Noisy Signal vs Denoised Signal, \Delta = 25','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Magnitude','FontSize',y_label_font_size)
legend([h1 h2 h3],{'100 Realisation of Noisy Sine Wave','100 Realisations of Denoised Sine Wave','Clean Sine Wave'},'FontSize',legend_font_size);
axis([0 1000 -7 7])
grid on

saveas(gcf,'images/2_3_b_2.png')

%% MPSE vs Delta; 2_3_b Calculations

deltas=1:25;
orders=[5 10 15 20];
delta_mpse=zeros(length(deltas),length(orders));

for i=1:length(deltas)
    for j=1:length(orders)
        mpse_ls = zeros(1,realisations);
        for k=1:realisations
            w=get_noise(N,noise_power);
            filtered_noise=filter(b,a,w);
            y=sine'+filtered_noise;
            
            [x_hat, ~] = ale(y,mu,deltas(i),orders(j));
            mpse_ls(k)=sum((sine-x_hat).^2)/N;
        end
        delta_mpse(i,j)=mean(mpse_ls);
    end
end

%% Plot MPSE vs Delta; 2_3_b

figure('Renderer', 'painters', 'Position',[200,200,500,300])
for i=1:length(orders)
    plot(deltas,delta_mpse(:,i));
    if i==1
        hold on
    end
end    

title('MPSE vs \Delta','FontSize',title_font_size)
xlabel('\Delta','FontSize',x_label_font_size)
ylabel('MPSE','FontSize',y_label_font_size)
legend({'Model Order = 5','Model Order = 10','Model Order = 15','Model Order = 20'},'FontSize',legend_font_size, 'Location', "SouthEast");
grid on

saveas(gcf,'images/2_3_b.png')

%% MPSE vs M; 2_3_b Calculations
mu=[0.005 0.01 0.015 0.02 0.025];
orders=1:15;
order_mpse=zeros(length(mu),length(orders));

for i=1:length(mu)
    for j=1:length(orders)
        mpse_ls = zeros(1,realisations);
        for k=1:realisations
            w=get_noise(N,noise_power);
            filtered_noise=filter(b,a,w);
            y=sine'+filtered_noise;
            
            [x_hat, ~] = ale(y,mu(i),3,orders(j));
            mpse_ls(k)=sum((sine-x_hat).^2)/N;
        end
        order_mpse(i,j)=mean(mpse_ls);
    end
end

%% Plot MPSE vs M; 2_3_b_3

figure('Renderer', 'painters', 'Position',[200,200,500,300])
for i=1:length(mu)
    plot(orders,order_mpse(i,:));
    if i==1
        hold on
    end
end    

title('MPSE vs Model Order','FontSize',title_font_size)
xlabel('Model Order, M','FontSize',x_label_font_size)
ylabel('MPSE','FontSize',y_label_font_size)
legend({'\mu = 0.005','\mu = 0.010','\mu = 0.015','\mu = 0.020', '\mu = 0.025'},'FontSize',legend_font_size, 'Location', "NorthWest");
grid on

saveas(gcf,'images/2_3_b_3.png')

