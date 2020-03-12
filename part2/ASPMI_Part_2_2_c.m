clear all; clc;

realisations = 1;
N = 1000;
b = [1 0.9];
a = [1];
var = 0.5;
factor = sqrt(var);
noise = factor*randn(N,realisations);
x_MA = filter(b,a,noise);
beta = 1;
epsilon = ones(N,realisations);
mu = 0.01;
rho = 0.1;
rho_3 = 0.001;
phi_B = zeros(N,realisations);
x_hat_3 = zeros(N,realisations);
e3 = zeros(N,realisations);
w3 = zeros(N,realisations);
mu_B = zeros(N,realisations);

x_hat_1 = zeros(N,realisations);
e1 = zeros(N,realisations);
w1 = zeros(N,realisations);
w11 = 0;

noise_delay = zeros(N+1,realisations);
for i = 1:realisations
    noise_delay(:,i) = vertcat(0, noise(:,i)); 
end


x = noise_delay;
% NLMS
for i = 1:realisations
    for n = 2:N
        x_hat_1(n,i) = (w11.')*x(n,i);
        e1(n,i) = x_MA(n,i) - x_hat_1(n,i); 
        w11 = w11 + (beta/(epsilon(n,i)+(x(n,i)'*x(n,i))))*e1(n,i)*x(n,i);    
        w1(n,i) = w11;
        epsilon(n+1,i) = epsilon(n,i) - (rho*mu)*(e1(n,i)*e1(n-1,i)*x(n,i)'*x(n-1,i)/(epsilon(n-1,i)+x(n-1,i)^2)^2);
        
     end
     w11 = 0;
end 



% % Benveniste
% order = 1;
%     identity = zeros(order,order);
%     for i=1:order
%         identity(i,i) = 1;
%     end
% 
% for i = 1:realisations
%     for n = 1:N
%         if n>1
%             phi_B(n,i) = (identity-mu_B(n-1,i)*(x3*x3'))*phi_B(n-1,i) + e3(n-1,i)*x3;
%         end
%         x3 = noise_delay(n,i);
%         x_hat_3(n,i) = (w33.')*x3;
%         e3(n,i) = x_MA(n,i) - x_hat_3(n,i);  
%         w33 = w33 + mu_B(n,i)*e3(n,i)*x3;
%         w3(n,i) = w33;
%         mu_B(n+1,i) = mu_B(n,i) + rho_3*e3(n,i)*x3'*phi_B(n,i);
%     end
%     w33 = 0;
% end

mean_w1 = mean(w1,2);
mean_w3 = mean(w3,2);
figure
plot(mean_w1)

% hold on
% plot(mean_w3)
% title('Convergence of Coefficient')
% xlabel('Sample')
% ylabel('Magnitude')
% grid on;
% grid minor;
% legend('GNGD', 'Benveniste', 'location', 'best')