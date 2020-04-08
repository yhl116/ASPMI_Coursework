clear all; clc;
load('font_size.mat')

N = 1000;
mu = 0.01;
order = 1;
order_plus_one = order+1;

v_a = 1;
v_b = 1;
v_c = 1;
f0 = 50;
fs = 1000;
phi = 0;

delta_b = 0;
delta_c = 0;
A = (sqrt(6)/6)*(v_a +v_b*exp(1j*delta_b) + v_c*exp(1j*delta_c));
B = (sqrt(6)/6)*(v_a +v_b*exp(-1j*(delta_b+(2*pi/3))) + v_c*exp(-1j*(delta_c-(2*pi/3))));
V = A*exp(1j*(2*pi*(f0/fs)*(1:N)+phi)+B*exp(-1j*(2*pi*(f0/fs)*(1:N)+phi)));

[~, h_clms_balanced] = clms2(V,V,mu,N,order_plus_one);
[~, h_aclms_balanced, g_aclms_balanced] = aclms2(V,V,mu,N,order_plus_one);

clms_balanced = (fs/(2*pi))*atan((imag(conj(h_clms_balanced)))./(real(conj(h_clms_balanced))));
aclms_balanced =(fs/(2*pi))*atan((sqrt( (imag(h_aclms_balanced).^2) - (abs(g_aclms_balanced).^2) ))./ (real(h_aclms_balanced)));

delta_b = pi/2;
delta_c = pi/2;
A = (sqrt(6)/6)*(v_a +v_b*exp(1j*delta_b) + v_c*exp(1j*delta_c));
B = (sqrt(6)/6)*(v_a +v_b*exp(-1j*(delta_b+(2*pi/3))) + v_c*exp(-1j*(delta_c-(2*pi/3))));
V = A*exp(1j*(2*pi*(f0/fs)*(1:N)+phi)+B*exp(-1j*(2*pi*(f0/fs)*(1:N)+phi)));

[~, h_clms_unbalanced] = clms2(V,V,mu,N,order_plus_one);
[~, h_aclms_unbalanced,g_aclms_unbalanced] = aclms2(V,V,mu,N,order_plus_one);

clms_unbalanced = (fs/(2*pi))*atan((imag(conj(h_clms_unbalanced)))./(real(conj(h_clms_unbalanced))));
aclms_unbalanced =(fs/(2*pi))*atan((sqrt( (imag(h_aclms_unbalanced).^2) - (abs(g_aclms_unbalanced).^2) ))./ (real(h_aclms_unbalanced)));

delta_b = 0;
delta_c = 0;
v_a = 1;
v_b = 0.2;
v_c = 1.8;
A = (sqrt(6)/6)*(v_a +v_b*exp(1j*delta_b) + v_c*exp(1j*delta_c));
B = (sqrt(6)/6)*(v_a +v_b*exp(-1j*(delta_b+(2*pi/3))) + v_c*exp(-1j*(delta_c-(2*pi/3))));
V = A*exp(1j*(2*pi*(f0/fs)*(1:N)+phi)+B*exp(-1j*(2*pi*(f0/fs)*(1:N)+phi)));

[~, h_clms_unbalanced2] = clms2(V,V,mu,N,order_plus_one);
[~, h_aclms_unbalanced2,g_aclms_unbalanced2] = aclms2(V,V,mu,N,order_plus_one);

clms_unbalanced2 = (fs/(2*pi))*atan((imag(conj(h_clms_unbalanced2)))./(real(conj(h_clms_unbalanced2))));
aclms_unbalanced2 =(fs/(2*pi))*atan((sqrt( (imag(h_aclms_unbalanced2).^2) - (abs(g_aclms_unbalanced2).^2) ))./ (real(h_aclms_unbalanced2)));

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,3,1)
plot(clms_balanced(2,:))
hold on
plot(abs(aclms_balanced(2,:)))
axis([0 1000 0 300])
title('Balanced System','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)
legend('clms','aclms','FontSize',legend_font_size)
grid on;
grid minor;

subplot(1,3,2)
plot(clms_unbalanced(2,:))
hold on
plot(abs(aclms_unbalanced(2,:)))
axis([0 1000 0 300])
title({'Unbalanced System (Phase)', '\Delta_b = \pi/2, \Delta_c = \pi/2'},'FontSize',title_font_size)
% title({'Unbalanced System (Phase) Frequency Estimation \n \Delta_{b} = \pi/2, \Delta_{c} = \pi/2'},'FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)
legend('clms','aclms','FontSize',legend_font_size)
grid on;
grid minor;

subplot(1,3,3)
plot(clms_unbalanced2(2,:))
hold on
plot(abs(aclms_unbalanced2(2,:)))
axis([0 1000 0 300])
title({'Unbalanced System (Magnitude)','V_{a}=1, V_{b}=0.2, V_{c}=1.8'},'FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)
legend('clms','aclms','FontSize',legend_font_size)
grid on;
grid minor;

saveas(gcf,'images/3_1_e.png')

magnitude_multiplier_ls=[1 1; 2 2; 2.5 2.5];

figure('Renderer', 'painters', 'Position',[200,200,1000,600])
subplot(2,2,1)
for i=1:length(magnitude_multiplier_ls)
    delta_b = 0;
    delta_c = 0;
    v_a = 1;
    v_b = magnitude_multiplier_ls(i,1);
    v_c = magnitude_multiplier_ls(i,2);
    A = (sqrt(6)/6)*(v_a +v_b*exp(1j*delta_b) + v_c*exp(1j*delta_c));
    B = (sqrt(6)/6)*(v_a +v_b*exp(-1j*(delta_b+(2*pi/3))) + v_c*exp(-1j*(delta_c-(2*pi/3))));
    V = A*exp(1j*(2*pi*(f0/fs)*(1:N)+phi)+B*exp(-1j*(2*pi*(f0/fs)*(1:N)+phi)));

    [~, h_clms_unbalanced] = clms2(V,V,mu,N,order_plus_one);
    clms_unbalanced = (fs/(2*pi))*atan((imag(conj(h_clms_unbalanced)))./(real(conj(h_clms_unbalanced))));

    plot(abs(clms_unbalanced(2,:)))
    if i==1
        hold on
    end
end
axis([0 1000 0 100])
legend('V_b = V_c = 1','V_b = V_c = 2','V_b = V_c = 2.5','FontSize',legend_font_size)
title('clms: Magnitude Distortion','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)
grid on

subplot(2,2,2)
for i=1:length(magnitude_multiplier_ls)
    delta_b = 0;
    delta_c = 0;
    v_a = 1;
%     v_b = 0.2;
%     v_c = 0.6;
    v_b = magnitude_multiplier_ls(i,1);
    v_c = magnitude_multiplier_ls(i,2);
    A = (sqrt(6)/6)*(v_a +v_b*exp(1j*delta_b) + v_c*exp(1j*delta_c));
    B = (sqrt(6)/6)*(v_a +v_b*exp(-1j*(delta_b+(2*pi/3))) + v_c*exp(-1j*(delta_c-(2*pi/3))));
    V = A*exp(1j*(2*pi*(f0/fs)*(1:N)+phi)+B*exp(-1j*(2*pi*(f0/fs)*(1:N)+phi)));

    [~, h_clms_unbalanced] = aclms2(V,V,mu,N,order_plus_one);
    clms_unbalanced = (fs/(2*pi))*atan((imag(conj(h_clms_unbalanced)))./(real(conj(h_clms_unbalanced))));

    plot(abs(clms_unbalanced(2,:)))
    if i==1
        hold on
    end
end
axis([0 1000 0 100])
legend('V_b = V_c = 0','V_b = V_c = 1.5','V_b = V_c = 2.5','FontSize',legend_font_size)
title('aclms: Magnitude Distortion','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)
grid on

delta_ls = [0 pi/2 pi];

subplot(2,2,3)
for i=1:length(delta_ls)
    delta_c = delta_ls(i);
    delta_b = -delta_ls(i);
    v_a = 1;
    v_b = 1;
    v_c = 1;
    A = (sqrt(6)/6)*(v_a +v_b*exp(1j*delta_b) + v_c*exp(1j*delta_c));
    B = (sqrt(6)/6)*(v_a +v_b*exp(-1j*(delta_b+(2*pi/3))) + v_c*exp(-1j*(delta_c-(2*pi/3))));
    V = A*exp(1j*(2*pi*(f0/fs)*(1:N)+phi)+B*exp(-1j*(2*pi*(f0/fs)*(1:N)+phi)));

    [~, h_clms_unbalanced] = clms2(V,V,mu,N,order_plus_one);
    clms_unbalanced = (fs/(2*pi))*atan((imag(conj(h_clms_unbalanced)))./(real(conj(h_clms_unbalanced))));

    plot(abs(clms_unbalanced(2,:)))
    if i==1
        hold on
    end
end
axis([0 1000 0 100])
title('clms: Phase Distortion','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)
legend('\Delta_b = \Delta_a = 0','-\Delta_b = \Delta_a = \pi/2','-\Delta_b = \Delta_a = \pi','FontSize',legend_font_size)
grid on

subplot(2,2,4)
for i=1:length(delta_ls)
    delta_c = delta_ls(i);
    delta_b = -delta_ls(i);
    v_a = 1;
    v_b = 1;
    v_c = 1;
    A = (sqrt(6)/6)*(v_a +v_b*exp(1j*delta_b) + v_c*exp(1j*delta_c));
    B = (sqrt(6)/6)*(v_a +v_b*exp(-1j*(delta_b+(2*pi/3))) + v_c*exp(-1j*(delta_c-(2*pi/3))));
    V = A*exp(1j*(2*pi*(f0/fs)*(1:N)+phi)+B*exp(-1j*(2*pi*(f0/fs)*(1:N)+phi)));

    [~, h_clms_unbalanced] = aclms2(V,V,mu,N,order_plus_one);
    clms_unbalanced = (fs/(2*pi))*atan((imag(conj(h_clms_unbalanced)))./(real(conj(h_clms_unbalanced))));

    plot(abs(clms_unbalanced(2,:)))
    if i==1
        hold on
    end
end
axis([0 1000 0 100])
legend('\Delta_b = \Delta_a = 0','-\Delta_b = \Delta_a = \pi/2','-\Delta_b = \Delta_a = \pi','FontSize',legend_font_size)
title('aclms: Phase Distortion','FontSize',title_font_size)
xlabel('n','FontSize',x_label_font_size)
ylabel('Frequency (Hz)','FontSize',y_label_font_size)
grid on

saveas(gcf,'images/3_1_e_2.png')

