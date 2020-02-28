realisations = 10000;
N = 1000;
var = 0.5;
factor = sqrt(var);
noise = factor*randn(N,realisations);

%model = arima('constant', 0, 'MA',{0.9},'MAlags',[1],'Variance',0.5);
%x_MA = simulate(model,N);

b = [1 0.9];
a = [1];
x_MA = filter(b,a,noise);

noise_delay = zeros(N+1,realisations);
for i = 1:realisations
    noise_delay(:,i) = vertcat(0, noise(:,i)); 
end

x_hat_1 = zeros(N,1);
x_hat_2 = zeros(N,1);
x_hat_3 = zeros(N,1);
x_hat_4 = zeros(N,1);
x_hat_5 = zeros(N,1);
x = zeros(N,1);
x2 = zeros(N,1);
x3 = zeros(N,1);
e1 = zeros(N,1);
e2 = zeros(N,1);
e3 = zeros(N,1);
e4 = zeros(N,1);
e5 = zeros(N,1);
phi_B = zeros(N,realisations);
phi_AF = zeros(N,realisations);
phi_MX = zeros(N,realisations);
mu_B = zeros(N,realisations);
mu_AF = zeros(N,realisations);
mu_MX = zeros(N,realisations);
mu_4 = 0.02;
mu_5 = 0.01;
rho = 0.001;
alpha = 0.8;
w11 = 0;
w22 = 0;
w33 = 0;
w44 = 0;
w55 = 0;
w1 = zeros(N,realisations);
w2 = zeros(N,realisations);
w3 = zeros(N,realisations);
w4 = zeros(N,realisations);
w5 = zeros(N,realisations);

% Matthews & Xie
for i = 1:realisations
    for n = 1:N
        if n>1
            phi_MX(n,i) = e1(n-1,i)*x;
        end
        x = noise_delay(n,i);
        x_hat_1(n,i) = (w11.')*x;
        e1(n,i) = x_MA(n,i) - x_hat_1(n,i);  
        w11 = w11 + mu_MX(n,i)*e1(n,i)*x;
        w1(n,i) = w11;
        mu_MX(n+1,i) = mu_MX(n,i) + rho*e1(n,i)*x'*phi_MX(n,i);
    end
     w11 = 0;
end 
   
   mean_w1 = mean(w1,2);
   figure
   plot(mean_w1);

% Ang & Farhang   
for i = 1:realisations
    for n = 1:N
        if n>1
            phi_AF(n,i) = alpha*phi_AF(n-1,i)+e2(n-1,i)*x2;
        end
        x2 = noise_delay(n,i);
        x_hat_2(n,i) = (w22.')*x2;
        e2(n,i) = x_MA(n,i) - x_hat_2(n,i);  
        w22 = w22 + mu_AF(n,i)*e2(n,i)*x2;
        w2(n,i) = w22;
        mu_AF(n+1,i) = mu_AF(n,i) + rho*e2(n,i)*x2'*phi_AF(n,i);
    end
    w22 = 0;
end
    
    mean_w2 = mean(w2,2);
    hold on
    plot(mean_w2);
    
    order = 1;
    identity = zeros(order,order);
    for i=1:order
        identity(i,i) = 1;
    end
    
% Benveniste    
for i = 1:realisations
    for n = 1:N
        if n>1
            phi_B(n,i) = (identity-mu_B(n-1,i)*(x3*x3'))*phi_B(n-1,i) + e3(n-1,i)*x3;
        end
        x3 = noise_delay(n,i);
        x_hat_3(n,i) = (w33.')*x3;
        e3(n,i) = x_MA(n,i) - x_hat_3(n,i);  
        w33 = w33 + mu_B(n,i)*e3(n,i)*x3;
        w3(n,i) = w33;
        mu_B(n+1,i) = mu_B(n,i) + rho*e3(n,i)*x3'*phi_B(n,i);
    end
    w33 = 0;
end
  
 mean_w3 = mean(w3,2);
 hold on
 plot(mean_w3);
 
 % Standard
 for i = 1:realisations
    for n = 1:N
        x4 = noise_delay(n,i);
        x_hat_4(n,i) = (w44.')*x4;
        e4(n,i) = x_MA(n,i) - x_hat_4(n,i);  
        w44 = w44 + mu_4*e4(n,i)*x4;
        w4(n,i) = w44;
    end
    w44 = 0;
 end
 
 mean_w4 = mean(w4,2);
 hold on
 plot(mean_w4);
 
  % Standard 2
 for i = 1:realisations
    for n = 1:N
        x5 = noise_delay(n,i);
        x_hat_5(n,i) = (w55.')*x5;
        e5(n,i) = x_MA(n,i) - x_hat_5(n,i);  
        w55 = w55 + mu_5*e5(n,i)*x5;
        w5(n,i) = w55;
    end
    w55 = 0;
 end
 
 mean_w5 = mean(w5,2);
 hold on
 plot(mean_w5);
 title('Evoluation of Coefficient')
 xlabel('Sample');
 ylabel('Magnitude');
 legend('Matthews','Ang','Benveniste','Standard(\mu=0.02)','Standard(\mu=0.01)')
 grid on;
 grid minor; 
 

 figure
 plot(0.9-mean_w1)
 hold on
 plot(0.9-mean_w2)
 hold on
 plot(0.9-mean_w3)
 hold on
 plot(0.9-mean_w4)
 hold on
 plot(0.9-mean_w5)
 title('Error in Coefficients')
 xlabel('Sample');
 ylabel('Error');
 grid on;
 grid minor;
 legend('Matthews','Ang','Benveniste','Standard(\mu=0.02)','Standard(\mu=0.01)')
 
 figure
 plot(10*log10(mean(e1.^2,2)))
 hold on
 plot(10*log10(mean(e2.^2,2)))
 hold on
 plot(10*log10(mean(e3.^2,2)))
 hold on
 plot(10*log10(mean(e4.^2,2)))
 hold on
 plot(10*log10(mean(e5.^2,2)))
 title('Square Error in Prediction')
 xlabel('Sample');
 ylabel('Square Error (dB)');
 grid on;
 grid minor;
 legend('Matthews','Ang','Benveniste','Standard(\mu=0.02)','Standard(\mu=0.01)')