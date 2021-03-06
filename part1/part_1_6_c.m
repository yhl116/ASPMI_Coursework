clc; clear all;
load('PCAPCR.mat');
load('font_size.mat')

[U_noise,S_noise,V_noise]=svd(Xnoise);
[m,n] = size(Xnoise);
B_ols = (inv(Xnoise'*Xnoise))*Xnoise'*Y;
B_pcr = V_noise(1:n,1:3)*(S_noise(1:3,1:3)^(-1))*((U_noise(1:m,1:3))')*Y;

k=3;

[m,n]=size(Xnoise);

% get low rank approximation
Xnoise_low_rank=U_noise(1:m,1:k)*S_noise(1:k,1:k)*V_noise(1:n,1:k)';
Y_ols = Xnoise*B_ols;
Y_pcr = Xnoise*B_pcr;

Y_ols_error = (norm((Y-Y_ols), 'fro'))^2;
Y_pcr_error = (norm((Y-Y_pcr), 'fro'))^2;


[U_test,S_test,V_test]=svd(Xtest);
Xtest_low_rank = U_test(1:m,1:k)*S_test(1:k,1:k)*V_test(1:n,1:k)';
Ytest_ols = Xtest_low_rank*B_ols;
Ytest_pcr = Xtest_low_rank*B_pcr;

Ytest_ols_error = (norm((Ytest-Ytest_ols), 'fro'))^2;
Ytest_pcr_error = (norm((Ytest-Ytest_pcr), 'fro'))^2;

mse_ols = zeros(100,1);
mse_pcr = zeros(100,1);

for i = 1:100
    [Y, Y_ols] = regval(B_ols);
    mse_ols(i) = (norm((Y-Y_ols), 'fro'))^2;
    
    [Y, Y_pcr] = regval(B_pcr);
    mse_pcr(i) = (norm((Y-Y_pcr), 'fro'))^2;
end    

exp_mse_ols = mean(mse_ols);
exp_mse_pcr = mean(mse_pcr);