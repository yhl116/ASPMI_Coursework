function [x_hat, e, coeffs] = anc(s, u, mu, order)
    N = length(s);
    coeffs = zeros(order+1, N);
    x_hat = zeros(1, N);
    e = zeros(N-1, 1);

    for i = 1:N-1
        u_current=get_inputs(u,order,i);
        x_hat(i) = coeffs(:, i)' * u_current;        
        e(i) = s(i) - x_hat(i);
        coeffs(:, i+1) = coeffs(:, i) + mu * e(i) * u_current;
    end    
end