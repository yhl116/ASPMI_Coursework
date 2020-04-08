clear all; clc;
load('font_size.mat')

load('low-wind.mat')
low_wind=complex(v_east,v_north);
low_wind_mean = mean(low_wind);

load('medium-wind.mat')
medium_wind=complex(v_east,v_north);
medium_wind_mean = mean(medium_wind);

load('high-wind.mat')
high_v_east = v_east;
high_wind=complex(v_east,v_north);
high_wind_mean = mean(high_wind);

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,3,1)
plot(real(low_wind),imag(low_wind),'co');
hold on
plot(0,0, 'bx');
plot(real(low_wind_mean),imag(low_wind_mean), 'rx');
axis([-4 4 -4 4])
title('Low Wind','FontSize',title_font_size)
xlabel('Real','FontSize',x_label_font_size)
ylabel('Imag','FontSize',y_label_font_size)
grid on

subplot(1,3,2)
plot(real(medium_wind),imag(medium_wind),'co');
hold on
plot(0,0, 'bx');
plot(real(medium_wind_mean),imag(medium_wind_mean), 'rx');
axis([-4 4 -4 4])
title('Medium Wind','FontSize',title_font_size)
xlabel('Real','FontSize',x_label_font_size)
ylabel('Imag','FontSize',y_label_font_size)
grid on

subplot(1,3,3)
plot(real(high_wind),imag(high_wind),'co');
hold on
plot(0,0, 'bx');
plot(real(high_wind_mean),imag(high_wind_mean), 'rx');
axis([-4 4 -4 4])
title('High Wind','FontSize',title_font_size)
xlabel('Real','FontSize',x_label_font_size)
ylabel('Imag','FontSize',y_label_font_size)
grid on

% saveas(gcf,'images/3_1_b.png')

N=length(low_wind);

mu=[0.00001 0.0001 0.001];
order=1:30;

mpse_clms=zeros(3,length(order),length(mu));
mpse_aclms=zeros(3,length(order),length(mu));

for i=1:length(mu)
    for j=1:length(order)
        [~,e]=clms_ar(low_wind,mu(i),order(j));
        mpse_clms(1,j,i)=sum(abs(e).^2)./N;
        [~,e]=clms_ar(medium_wind,mu(i),order(j));
        mpse_clms(2,j,i)=sum(abs(e).^2)./N;
        [~,e]=clms_ar(high_wind,mu(i),order(j));
        mpse_clms(3,j,i)=sum(abs(e).^2)./N;
        
        [~,e]=aclms_ar(low_wind,mu(i),order(j));
        mpse_aclms(1,j,i)=sum(abs(e).^2)./N;
        [~,e]=aclms_ar(medium_wind,mu(i),order(j));
        mpse_aclms(2,j,i)=sum(abs(e).^2)./N;
        [~,e]=aclms_ar(high_wind,mu(i),order(j));
        mpse_aclms(3,j,i)=sum(abs(e).^2)./N;
    end
end

figure('Renderer', 'painters', 'Position',[200,200,1000,900])
for i=1:length(mu)
    subplot(length(mu), 3, (i-1)*3+1)
    plot(mpse_clms(1,:,i))
    hold on
    plot(mpse_aclms(1,:,i))
    title(sprintf('Low Wind, \n \\mu = %s', mu(i)),'FontSize',title_font_size)
    xlabel('Model Order','FontSize',x_label_font_size)
    ylabel('MPSE','FontSize',y_label_font_size)
    legend({'CLMS','ACLMS'},'FontSize',legend_font_size, "Location", "northeast")
    grid on
    
    subplot(length(mu), 3, (i-1)*3+2)
    plot(mpse_clms(2,:,i))
    hold on
    plot(mpse_aclms(2,:,i))
    title(sprintf('Medium Wind, \n \\mu = %s', mu(i)),'FontSize',title_font_size)
    xlabel('Model Order','FontSize',x_label_font_size)
    ylabel('MPSE','FontSize',y_label_font_size)
    legend({'CLMS','ACLMS'},'FontSize',legend_font_size, "Location", "northeast")
    grid on
    
    subplot(length(mu), 3, (i-1)*3+3)
    plot(mpse_clms(3,:,i))
    hold on
    plot(mpse_aclms(3,:,i))
    title(sprintf('High Wind, \n \\mu = %s', mu(i)),'FontSize',title_font_size)
    xlabel('Model Order','FontSize',x_label_font_size)
    ylabel('MPSE','FontSize',y_label_font_size)
    legend({'CLMS','ACLMS'},'FontSize',legend_font_size, "Location", "northeast")
    grid on
end

% figure('Renderer', 'painters', 'Position',[200,200,1000,300])
% subplot(1, 3, 1)
% plot(mpse_clms(1,:,3))
% hold on
% plot(mpse_aclms(1,:,3))
% legend({'CLMS','ACLMS'},'FontSize',legend_font_size, "Location", "northeast")
% title('Low Wind MPSE, mu = 0.01','FontSize',title_font_size)
% xlabel('Model Order','FontSize',x_label_font_size)
% ylabel('Mean Prediction Seqaured Error, MPSE','FontSize',y_label_font_size)
% grid on
% 
% subplot(1, 3, 2)
% plot(mpse_clms(2,:,2))
% hold on
% plot(mpse_aclms(2,:,2))
% legend({'CLMS','ACLMS'},'FontSize',legend_font_size, "Location", "northeast")
% title('Medium Wind MPSE, mu = 0.001','FontSize',title_font_size)
% xlabel('Model Order','FontSize',x_label_font_size)
% ylabel('Mean Prediction Seqaured Error, MPSE','FontSize',y_label_font_size)
% grid on
% 
% subplot(1, 3, 3)
% plot(mpse_clms(3,:,1))
% hold on
% plot(mpse_aclms(3,:,1))
% legend({'CLMS','ACLMS'},'FontSize',legend_font_size, "Location", "northeast")
% title('High Wind MPSE, mu = 0.0001','FontSize',title_font_size)
% xlabel('Model Order','FontSize',x_label_font_size)
% ylabel('Mean Prediction Seqaured Error, MPSE','FontSize',y_label_font_size)
% grid on

% saveas(gcf,'images/3_1_b_2.png')

