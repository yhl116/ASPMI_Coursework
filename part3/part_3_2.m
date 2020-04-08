clear all; clc;
load('font_size.mat')

% parameters of the algorithm
order=1;
K=1024;

% parameters of signal
N=1500;
fs=1600;
noise_power=0.05;

% define frequencies of the signal
f=zeros(N,1);
f(1:500)=100;
f(501:1000)=100+(1:500)./2;
f(1001:1500)=100+((1:500)./25).^2;
phase=cumsum(f);

% generate FM signal
x=exp(1j*(phase*2*pi/fs));

% generate noise
w=wgn(N,1,pow2db(0.05),'complex');

% corrupted signal
y=x+w;

% get aryule coefficients
a1=aryule(y,1);
a2=aryule(y,2);
a3=aryule(y,3);
a4=aryule(y,4);

% get power spectrum
[h_aryule_1, w_aryule_1]=freqz(1, a1, N, fs);
[h_aryule_2, w_aryule_2]=freqz(1, a2, N, fs);
[h_aryule_3, w_aryule_3]=freqz(1, a3, N, fs);
[h_aryule_4, w_aryule_4]=freqz(1, a4, N, fs);

% estimate AR Coefficients using Adaptive filter
[~,~,h_clms_1] = clms_ar(y, 0.1, order);
[~,~,h_clms_01] = clms_ar(y, 0.01, order);
[~,~,h_clms_0025] = clms_ar(y, 0.0025, order);

% initialise vector to holder values 
mu = 0.1;
H_mu_1=zeros(K,N,length(mu));
mu = 0.01;
H_mu_01=zeros(K,N,length(mu));
mu = 0.0025;
H_mu_0025=zeros(K,N,length(mu));


% calculate the power spectrum for each time instance
for n = 1:N
    [h ,~]= freqz(1 , [1; -conj(h_clms_1(n))], K, fs);
    H_mu_1(:, n) = abs(h).^2; 
    [h ,~]= freqz(1 , [1; -conj(h_clms_01(n))], K, fs);
    H_mu_01(:, n) = abs(h).^2; 
    [h ,w]= freqz(1 , [1; -conj(h_clms_0025(n))], K, fs);
    H_mu_0025(:, n) = abs(h).^2; 
end

% remove outliers in the matrix H
medianH=50*median(median(H_mu_1));
H_mu_1(H_mu_1>medianH)=medianH;
medianH=50*median(median(H_mu_01));
H_mu_01(H_mu_01>medianH)=medianH;
medianH=50*median(median(H_mu_0025));
H_mu_0025(H_mu_0025>medianH)=medianH;

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,2,1)
plot(f);
title('Frequency of FM Signal','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)
axis([0 1500 0 600])
grid on

subplot(1,2,2)
plot(w_aryule_1,mag2db(abs(h_aryule_1)));
hold on
plot(w_aryule_2,mag2db(abs(h_aryule_2)));
plot(w_aryule_3,mag2db(abs(h_aryule_3)));
plot(w_aryule_4,mag2db(abs(h_aryule_4)));
title('Power Spectral Density: Aryule Prediction','FontSize',title_font_size)
xlabel('Frequency','FontSize',x_label_font_size)
ylabel('Magnitude (dB)','FontSize',y_label_font_size)
legend({'AR(1)','AR(2)', 'AR(3)', 'AR(4)'},'FontSize',legend_font_size, "Location", "northeast")
grid on

saveas(gcf,'images/3_2_a.png')

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,3,1)
surf(1:N, w, H_mu_1, 'LineStyle', 'none');
view(2);
title('Frequency Spectrum Estimate, \mu = 0.1','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)

subplot(1,3,2)
surf(1:N, w, H_mu_01, 'LineStyle', 'none');
view(2);
set(gca, 'Color', 'none');
title('Frequency Spectrum Estimate, \mu = 0.01','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)

subplot(1,3,3)
surf(1:N, w, H_mu_0025, 'LineStyle', 'none');
view(2);
set(gca, 'Color', 'none');
title('Frequency Spectrum Estimate, \mu = 0.0025','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)

saveas(gcf,'images/3_2_b.png')