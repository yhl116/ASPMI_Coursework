clear all; clc;

mu=0.1;
order=1;
realisations=100;
N=1000;
noise_power=1;
b=[1 1.5+1i 2.5-0.5i];
x = wgn(realisations,N,pow2db(1),'complex');

y=complex(zeros(realisations,N));
x_pad = (vertcat(zeros(order,realisations),x'))';
h_pad = complex(zeros(order+1, N+order, realisations));
error = complex(zeros(N,realisations));

%generate y signal
for k = 1:realisations
    for l = order+1:N+order
        y(k,l-order) = x_pad(k,l) + b(2)*x_pad(k,l-1) + b(3)*conj(x_pad(k,l-1));
    end
end

for k = 1:realisations
    for l = order+1:N+order
        x_vec = x_pad(k,l:-1:l-order);
        y_hat = h_pad(:,l-order,k)' * x_vec';
        e = y(k,l-order) - y_hat;
        error(l-order,k) = abs(e).^2;
        h_pad(:,l+1-order,k) = h_pad(:,l-order,k) + mu*conj(e)*x_vec';
    end
end

error_mean = mean(error,2);
figure
plot(10*log10(error_mean))