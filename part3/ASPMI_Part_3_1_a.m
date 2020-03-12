clear all
N = 1000;
realisations = 100;
order = 2;
y = zeros(N,realisations);
x2 = zeros(N,realisations);
b1 = 1.5 + 1j;
b2 = 2.5 - 0.5j;
mu = 0.1;

for i = 1:realisations
    x2(:,i) = wgn(N,1,pow2db(1),'complex');
    for k=order:N
        y(k,:) = x2(k,:)+b1*x2(k-1,:)+b2*conj(x2(k-1,:));
    end
    [e(:,i), h_ACLMS(:,:,i), g_ACLMS(:,:,i)] = ACLMS(x2(:,i),y(:,i),mu,N);
    [e2(:,i), h_CLMS(:,:,i)] = CLMS(x2(:,i),y(:,i),mu,N);
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
grid minor
legend('','')

figure
scatter(real(mean(x2,2)),imag(mean(x2,2)))
hold on
scatter(real(mean(y,2)),imag(mean(y,2)))
grid on;
grid minor;

h_CLMS_mean = mean(h_CLMS,3);
h_ACLMS_mean = mean(h_ACLMS,3);
g_ACLMS_mean = mean(g_ACLMS,3);

