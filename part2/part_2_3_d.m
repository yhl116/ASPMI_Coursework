load('EEG_Data_Assignment2');

N=length(POz);
K=16382;
L=4096;
overlap=0.8; 

% generate sinewave
t=1:N;
f0=50;
f=f0/fs;        % standarise frequency
sine=sin(2*pi*f*t);
w=get_noise(N,1);
noisy_sine=sine'+w;

mu=[0.025 0.01 0.005 0.001];
order=[10 15 20 25];

POz=POz-mean(POz);
POz_denoise=zeros(N,length(mu),length(order));

for i=1:length(mu)
    for j=1:length(order)
        [noise_estimate,~,~]=lms_anc(POz,noisy_sine,mu(i),order(j));
        POz_denoise(:,i,j)=POz-noise_estimate';
    end
end

figure('Renderer', 'painters', 'Position',[200,200,500,300])
spectrogram(POz, rectwin(L),round(overlap*L),K,fs,'yaxis');
ylim([0 100]);
set(gca,'fontsize',axis_font_size);
title({'Orginal POz Signal'}, 'FontSize', title_font_size);
xlabel('Time','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)
grid on

saveas(gcf,'images/2_3_d.png')

figure('Renderer', 'painters', 'Position',[200,200,1000,600])
for i=1:length(order)
    subplot(2,2,i)
    spectrogram(POz_denoise(:,2,i), rectwin(L),round(overlap*L),K,fs,'yaxis');
    ylim([0 100]);
    title("\mu = 0.01, 25, M = " + order(i), 'FontSize', title_font_size);
    xlabel('Time','FontSize',x_label_font_size)
    ylabel('Frequency (Hz)','FontSize',y_label_font_size)
    grid on
end

saveas(gcf,'images/2_3_d_2.png')

figure('Renderer', 'painters', 'Position',[200,200,1000,600])
for i=1:length(order)
    subplot(2,2,i)
    spectrogram(POz_denoise(:,i,4), rectwin(L),round(overlap*L),K,fs,'yaxis');
    ylim([0 100]);
    xlabel('Time','FontSize',x_label_font_size)
    ylabel('Frequency (Hz)','FontSize',y_label_font_size)
    title("M = 25, \mu = " + mu(i), 'FontSize', title_font_size);
end

saveas(gcf,'images/2_3_d_3.png')

%shared parameters
nfft = fs*5;   
noverlap = 0;

%standard periodogram with 10 sample window
[pxx, w] = pwelch(POz,rectwin(fs*10),noverlap,nfft,fs);
[pxx_denoise, w_denoise] = pwelch(POz_denoise(:,4,4),rectwin(fs*10),noverlap,nfft,fs);

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,2,1)
plot(w, 10*log10(pxx))
hold on
plot(w_denoise, 10*log10(pxx_denoise))
grid on;
axis([0 60 -140 -90]);
title('Periodogram: Original vs Denoise','FontSize',title_font_size)
xlabel('Frequency (Hz)','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)
legend({'Original POz Signal','Denoised POz Signal'},'Location','northeast','FontSize',legend_font_size)

error_power=(pxx-pxx_denoise).^2;

subplot(1,2,2)
plot(w, 10*log10(error_power))
grid on;
title('Periodogram: Error Signal','FontSize',title_font_size)
axis([0 60 -320 -180])
xlabel('Frequency (Hz)','FontSize',x_label_font_size)
ylabel('Power (dB)','FontSize',y_label_font_size)

saveas(gcf,'images/2_3_d_4.png')