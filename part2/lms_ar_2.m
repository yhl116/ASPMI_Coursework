function [y_hat, e, coeffs] = lms_ar(x, mu, order)
    N = length(x);
    coeffs = zeros(order, N-1);
    y_hat = zeros(N, 1);
    e = zeros(N, 1);
    
    for i = order+1:N
        x_hat = x(i-1:-1:i-order);
        y_hat(i) = (coeffs(:, i-order).') * x_hat;
        e(i) = x(i) - y_hat(i);
        coeffs(:, i-order+1) = coeffs(:, i-order) + mu * e(i) * x_hat;
    end
end