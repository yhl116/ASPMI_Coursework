function [r,lag,Pxx,fs] = corr_est(x,bias)
    % calculate auto correlation
    [r,lag]=xcorr(x,bias);
    % make autocorrelation symmetric
    int = ifftshift(r);
    % get power spectrum
    Pxx = real(fftshift(fft(int)))./(2*pi);
    % normalised frequency
    fs=lag./max(lag);
end