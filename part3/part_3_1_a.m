clear all; clc;
load('font_size.mat')

mu=0.1;
order=1;
realisations=100;
N=1000;
noise_power=1;
b=[1 1.5+1i 2.5-0.5i];
x = wgn(realisations,N,pow2db(1),'complex');

y=complex(zeros(realisations,N));
x_pad = (vertcat(zeros(order,realisations),x'))';
clms_error = complex(zeros(N,realisations));
aclms_error = complex(zeros(N,realisations));

aclms_h = complex(zeros(realisations, order*4, N+order));
clms_h = complex(zeros(realisations, order*2, N+order));


for k = 1:realisations
    for l = order+1:N+order
        
        %generate y signal
        y(k,l-order) = x_pad(k,l) + b(2)*x_pad(k,l-1) + b(3)*conj(x_pad(k,l-1));
        
    end
    
    %generate prediction
    [~, clms_error(:,k), clms_h(k,:,:)] = clms(y(k,:), x(k,:), mu, order);
    [~, aclms_error(:,k), aclms_h(k,:,:)] = aclms3(y(k,:), x(k,:), mu, order);
end

clms_error_mean = mean(abs(clms_error).^2,2);
aclms_error_mean = mean(abs(aclms_error).^2,2);

figure('Renderer', 'painters', 'Position',[200,200,500,300])
plot(real(y(1,:)), imag(y(1,:)), ".")
hold on
plot(real(x(1,:)), imag(x(1,:)), ".")
title('WGN vs WLMA','FontSize',title_font_size)
xlabel('Real','FontSize',x_label_font_size)
ylabel('Imag','FontSize',y_label_font_size) 
legend({'WLMA','WGN'},'FontSize',legend_font_size, "Location", "northeast")
grid on

saveas(gcf,'images/3_1_a_2.png')

figure('Renderer', 'painters', 'Position',[200,200,500,300])
plot(10*log10(clms_error_mean))
hold on 
plot(10*log10(aclms_error_mean))
title('CLMS vs ACLMS, 100 Realisations','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('w','FontSize',y_label_font_size) 
legend({'CLMS','ACLMS'},'FontSize',legend_font_size, "Location", "southwest")
grid on

saveas(gcf,'images/3_1_a.png')

clms_db = 10*log10(clms_error_mean);
clms_ss = mean(clms_db(500:1000));
aclms_db = 10*log10(aclms_error_mean);
aclms_ss = mean(aclms_db(500:1000));

clms_h_mean = mean(clms_h, 1);
aclms_h_mean = mean(aclms_h, 1);