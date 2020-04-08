function v=clarke_transform(N,f0,fs,phi,V_a,V_b,V_c,delta_b,delta_c)
    exponential=2*pi*f0*(1:N)/fs+phi;
    A_n=sqrt(6)./6 * ( V_a + V_b * exp(1j * delta_b) + V_c * exp(1j*delta_c) );
    B_n=sqrt(6)./6 * ( V_a + V_b * exp(-1j * ( delta_b + (2*pi/3) ) ) + V_c * exp(-1j * ( delta_c - (2*pi/3) )) );
    v=A_n.*exp(1j*exponential)+B_n.*exp(-1j*exponential);
end