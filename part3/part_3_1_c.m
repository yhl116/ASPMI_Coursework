clear all; clc;
load('font_size.mat')

f0=50;
fs=10000;
N=1000;

phi=0;

v_balanced=clarke_transform(N,f0,fs,phi,ones(1,N),ones(1,N),ones(1,N),0,0);

delta_ls = [pi pi/2 pi/3 pi/4];
v_unbalanced_phase = complex(zeros(N,length(delta_b)));

v_multipliers=[0.8 1 1.2;0.6 1 1.4;0.4 1 1.6;0.2 1 1.8];
v_unbalanced_magnitude = complex(zeros(N,length(v_multipliers)));

for i=1:length(delta_c_unbalanced)
    v_unbalanced_phase(:,i)=clarke_transform(N,f0,fs,phi,ones(1,N),ones(1,N),ones(1,N),delta_ls(i),delta_ls(i));
end

for i=1:length(v_multipliers)
    v_unbalanced_magnitude(:,i)=clarke_transform(N,f0,fs,phi,ones(1,N)*v_multipliers(i,1),ones(1,N)*v_multipliers(i,2),ones(1,N)*v_multipliers(i,3),0,0);
end

figure('Renderer', 'painters', 'Position',[200,200,1000,300])
subplot(1,3,1)
plot(real(v_balanced), imag(v_balanced), 'o');
axis([-3 3 -3 3])
title('Balanced','FontSize',title_font_size)
xlabel('Real','FontSize',x_label_font_size)
ylabel('Imag','FontSize',y_label_font_size)
grid on

subplot(1,3,2)
plot(real(v_unbalanced_phase(:,1)),imag(v_unbalanced_phase(:,1)),'o');
hold on
plot(real(v_unbalanced_phase(:,2)),imag(v_unbalanced_phase(:,2)),'o');
plot(real(v_unbalanced_phase(:,3)),imag(v_unbalanced_phase(:,3)),'o');
plot(real(v_unbalanced_phase(:,4)),imag(v_unbalanced_phase(:,4)),'o');
axis([-3 3 -3 3])
title('Unbalanced (Phase Distortion)','FontSize',title_font_size)
xlabel('Real','FontSize',x_label_font_size)
ylabel('Imag','FontSize',y_label_font_size)
legend({'\Delta_{b}=\pi, \Delta_{c}=\pi','\Delta_{b}=\pi/2, \Delta_{c}=\pi/2', '\Delta_{b}=\pi/3, \Delta_{c}=\pi/3','\Delta_{b}=\pi/4, \Delta_{c}=\pi/4'},'FontSize',7, "Location", "northeast")
grid on

subplot(1,3,3)
plot(real(v_unbalanced_magnitude(:,1)),imag(v_unbalanced_magnitude(:,1)),'o');
hold on
plot(real(v_unbalanced_magnitude(:,2)),imag(v_unbalanced_magnitude(:,2)),'o');
plot(real(v_unbalanced_magnitude(:,3)),imag(v_unbalanced_magnitude(:,3)),'o');
plot(real(v_unbalanced_magnitude(:,4)),imag(v_unbalanced_magnitude(:,4)),'o');
axis([-4 4 -4 4])
title('Unbalanced (Magnitude Distortion)','FontSize',title_font_size)
xlabel('Real','FontSize',x_label_font_size)
ylabel('Imag','FontSize',y_label_font_size)
legend({'V_a = 0.8, V_b = 1, V_c = 1.2','V_a = 0.6, V_b = 1, V_c = 1.4', 'V_a = 0.4, V_b = 1, V_c = 1.6','V_a = 0.2, V_b = 1, V_c = 1.8'},'FontSize',7, "Location", "northeast")
grid on

saveas(gcf,'images/3_1_c.png')