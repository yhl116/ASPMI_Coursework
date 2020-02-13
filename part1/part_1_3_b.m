clc; clear all;

%generating input signals

fs = 100;   %sampling frequency
dt = 1/fs;  %sampling period
stoptime = 10;
t = (0:dt:stoptime-dt);
fc = 10; %hertz

sine = cos(2*pi*fc*t);
wgn = randn(1,1000);
filtered_wgn = filter([1,1,1,1,1,1,1,1,1], 1, wgn);
noisy_sine = sine + wgn;

for i = 1:length(A)
       disp(A(i))
end