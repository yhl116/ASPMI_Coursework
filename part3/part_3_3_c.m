% parameters of the algorithm
mu=1;
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

% generate circular complex-valued white noise
w=wgn(N,1,pow2db(0.05),'complex');

% corrupt signal with noise
y=x+w;

% implement dft_clms
% non-leaky version
[~,~,dft_clms_non_leaky]=dft_clms(y, mu, K, 0);

% implement dft_clms
% non-leaky version
[~,~,dft_clms_leaky]=dft_clms(y, mu, K, 0.05);



%% Plot Time-Frequency Plot, using dft_clms - NON-Leaky
figure(1)
surf(1:N, [0:K-1].*fs/K, abs(dft_clms_non_leaky), 'LineStyle', 'none');
view(2);
set(gca, 'Color', 'none');
% graph_saving('../report/images/part4/time_frequency_dft_non_leaky');

%% Plot Time-Frequency Plot, using dft_clms - NON-Leaky
figure(2)
surf(1:N, [0:K-1].*fs/K, abs(dft_clms_leaky), 'LineStyle', 'none');
view(2);
set(gca, 'Color', 'none');
% graph_saving('../report/images/part4/time_frequency_dft_leaky');