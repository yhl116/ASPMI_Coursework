clc; clear all;
load('font_size.mat');

order=1;
delta=3;
mu=0.01;
realisations=100;

N=1000;
t=1:N;
f0=0.005;
sine = sin(2*pi*f0*t);
noise_power = 1;
b=[1 0 0.5];
a=1;
y=zeros(N,realisations);

x_hat_ale=zeros(realisations,N);
x_hat_anc=zeros(realisations,N);

ale_error=zeros(realisations,N-1);
anc_error=zeros(realisations,N-1);

mpse=zeros(realisations,2);

for i=1:realisations
    w=get_noise(N,noise_power);
    filtered_noise=filter(b,a,w);

    y(:,i)=sine'+filtered_noise;
    
   [x_hat_ale(i,:),ale_error(i,:)]=ale(y(:,i),mu,delta,order);
   mpse(i,1)=sum((sine-x_hat_ale(i,:)).^2)./N;
   
   [n_hat,anc_error(i,:)]=anc(y(:,i),filtered_noise,mu,order);
   x_hat_anc(i,:)=y(:,i)'-n_hat;
   mpse(i,2)=sum((sine-x_hat_anc(i,:)).^2)./N;
   
end

x_hat_ale_mean=mean(x_hat_ale);
x_hat_anc_mean=mean(x_hat_anc);
mpse_mean=mean(mpse);

x_axis=1:N;

figure('Renderer', 'painters', 'Position',[200,200,500,300])
plot(x_axis, sine, 'g');
hold on;
plot(x_axis,x_hat_anc_mean);
plot(x_axis,x_hat_ale_mean);
title('ALE vs ANC, Mean of 100 Realisations','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Magnitude','FontSize',y_label_font_size)
legend({'Clean Sine Wave', 'ALE Denoised','ANC Denoised'},'FontSize',10);
grid on

saveas(gcf,'images/2_3_c.png')

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,2,1)
for i=1:realisations
    h1=plot(y(:,i),'r');
    if i==1
        hold on;
    end
end
for i=1:realisations
    h2=plot(x_hat_ale(i,:),'b');
end
h3=plot(sine,'g');
hold off;
legend([h1 h2 h3],{'100 Realisation of Noisy Sine Wave','100 Realisations of Denoised Sine Wave','Clean Sine Wave'},'FontSize',10);
title('ALE: Noisy Signal vs Denoised Signal','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Magnitude','FontSize',y_label_font_size)
grid on

subplot(1,2,2)
for i=1:realisations
    h1=plot(y(:,i),'r');
    if i==1
        hold on;
    end
end
for i=1:realisations
    h2=plot(x_hat_anc(i,:),'b');
end
h3=plot(sine,'g');
hold off;
legend([h1 h2 h3],{'100 Realisation of Noisy Sine Wave','100 Realisations of Denoised Sine Wave','Clean Sine Wave'},'FontSize',10);
title('ANC: Noisy Signal vs Denoised Signal','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Magnitude','FontSize',y_label_font_size)
grid on

saveas(gcf,'images/2_3_c_2.png')