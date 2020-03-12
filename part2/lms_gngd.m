function [x_hat, error, w] = lms_gngd(x_ma, noise, mu, order, rho, beta)
    N = length(x_ma);
    x_hat_pad = zeros(N+order+1,1);
    error_pad = zeros(1,N+order+1);
    x_pad = vertcat(zeros(order+1,1),x_ma);
    w = zeros(order,N+2+order);
    noise_pad = vertcat(zeros(order+1,1),noise);
    epsilon = 1;
    epsilon_prev = 1;
    
    for i = 2+order:N+1+order
        x_vec = noise_pad(i-1:-1:i-order);
        x_vec_prev = noise_pad(i-2:-1:i-order-1);
        x_hat_pad(i) = (w(:, i).')*x_vec;
        error_pad(i) = x_pad(i) - x_hat_pad(i);

        w_denominator = epsilon + x_vec.' * x_vec;
        w(:, i+1) = w(:, i) + beta * error_pad(i) * x_vec / w_denominator;

        temp_epsilon = epsilon;
        epsilon_denominator = epsilon_prev + x_vec_prev.' * x_vec_prev;
        epsilon = epsilon - rho * mu * error_pad(i) * error_pad(i-1) * x_vec.' * x_vec_prev / epsilon_denominator^2;
        epsilon_prev = temp_epsilon;

    end 
    
    error = error_pad(order+2:N+order+1);
    w = w(:, order+2:N+order+2);
    x_hat = x_hat_pad(order+2:N+order+1);
end