function [x_hat, error, w] = lms_ar(x, mu, order,a)
    N = length(x);
    w = zeros(order, N);
    x_hat = zeros(N, 1);
    error = zeros(N, 1);
    
    % error(1)  = x(1) - x_hat(1)
    %           = x(1) - w(1)*x_vec(1)
    %           = x(1)  because w(1) = 0
    error(1) = x(1);
    
    for i = 2:order
        x_vec = x(i-1:-1:1);
        x_vec(order) = 0;
        x_vec = reshape(x_vec,[1,order]);
        x_hat(i) = a*tanh((w(:, i).') * x_vec.');
        error(i) = x(i) - x_hat(i);
        w(:, i+1) = w(:, i) + (mu * error(i) * x_vec).';
    end

    for i = order+1:N
        x_vec = x(i-1:-1:i-order);
        x_hat(i) = a*tanh((w(:, i).') * x_vec);
        error(i) = x(i) - x_hat(i);
        w(:, i+1) = w(:, i) + mu * error(i) * x_vec;
    end
end