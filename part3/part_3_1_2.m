clear all; clc;

N = 1000;
realisations = 100;
y = zeros(N,realisations);
sd = 1;

x = wgn(N,realisations,pow2db(1),'complex');
b = [1 1.5 + 1j 2.5 - 0.5j];
order = 1;
mu = 0.1;

w_pad = zeros((order+1)*2, N+order, realisations);
h_pad = zeros(order+1, N+order, realisations);
g_pad = zeros(order+1, N+order, realisations);
x_pad = vertcat(zeros(order,realisations),x);
error = zeros(N,realisations);

%generate y signal
for k = 1:realisations
    for l = order+1:N+order
        y(l-order,k) = x_pad(l,k) + b(2)*x_pad(l-1,k) + b(3)*conj(x_pad(l-1,k));
    end
end

%ACLMS
for k = 1:realisations
    for l = order+1:N+order
        x_vec_ori = x_pad(l:-1:l-order,k);
        x_vec_conj = conj(x_pad(l:-1:l-order,k));
%         x_vec = vertcat(x_vec_ori, x_vec_conj); 
        
%         y_hat = w_pad(:,l-order,k)' * x_vec;
        y_hat = h_pad(:,l-order,k)'* x_vec_ori + g_pad(:,l-order,k)' * x_vec_conj;
        e = y(l-order,k) - y_hat;
        error(l-order,k) = abs(e).^2;
        
        h_pad(:,l-order+1,k) = h_pad(:,l-order,k) + mu*conj(e)*x_vec_ori;
        g_pad(:,l-order+1,k) = g_pad(:,l-order,k) + mu*e*x_vec_conj;
%         w_pad(:,l-order+1,k) = vertcat(h_pad(:,l-order+1,k), g_pad(:,l-order+1,k)); 
    end
end

h_mean = mean(h_pad,3);
g_mean = mean(g_pad,3);
error_mean = mean(error,2);
w_mean = mean(w_pad,3);

figure
plot(10*log10(error_mean))

