clear all; clc;
N = 1000;
realisations = 100;
order = 2;
y = zeros(N,realisations);
x = zeros(N,realisations);
b1 = 1.5 + 1j;
b2 = 2.5 - 0.5j;
mu = 0.1;

for i = 1:realisations
    x(:,i) = wgn(N,1,pow2db(1),'complex');
    for k=order:N
        y(k,:) = x(k,:)+b1*x(k-1,:)+b2*conj(x(k-1,:));
    end
    [e(:,i), h_ACLMS(:,:,i), g_ACLMS(:,:,i)] = ACLMS(x(:,i),y(:,i),mu,N);
    [e2(:,i), h_CLMS(:,:,i)] = CLMS(x(:,i),y(:,i),mu,N);
end

e_ACLMS = abs(e).^2;
e_CLMS = abs(e2).^2;
mean_e_CLMS = mean(e_CLMS,2);
mean_e_ACLMS = mean(e_ACLMS,2);
figure
plot(mean_e_CLMS)
title('test')
figure
plot(10*log10(mean_e_CLMS));
title('CLMS')
hold on
plot(10*log10(mean_e_ACLMS));
title('ACLMS')
grid on
legend('','')

figure
scatter(real(mean(x,2)),imag(mean(x,2)))
hold on
scatter(real(mean(y,2)),imag(mean(y,2)))
grid on;
grid minor;

h_CLMS_mean = mean(h_CLMS,3);
h_ACLMS_mean = mean(h_ACLMS,3);
g_ACLMS_mean = mean(g_ACLMS,3);

