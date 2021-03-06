function [x_hat, error, w] = lms_gass(x_ma, noise, rho, order, method)
    N = length(x_ma);
    x_hat_pad = zeros(N+order+1,1);
    error_pad = zeros(1,N+order+1);
    x_pad = vertcat(zeros(order+1,1),x_ma);
    mu_pad = zeros(N+2+order,1);
    w = zeros(order,N+2+order);
    noise_pad = vertcat(zeros(order+1,1),noise);
    phi = 0;

    if method == 'MX'
        for i = 2+order:1001+order
            x_vec = noise_pad(i-1:-1:i-order);
            x_hat_pad(i) = (w(:, i).')*x_vec;
            error_pad(i) = x_pad(i) - x_hat_pad(i);

            phi = error_pad(i-1) * noise_pad(i-2:-1:i-order-1);
            mu_pad(i+1) = mu_pad(i) + rho * error_pad(i) * x_vec'* phi;
%             a = mu_pad(i)*error_pad(i)*x_vec;
            w(:, i+1) = w(:, i) + mu_pad(i)*error_pad(i)*x_vec;
        end
        
    elseif method == 'AF'    
        alpha = 0.8;
        for i = 2+order:1001+order
            x_vec = noise_pad(i-1:-1:i-order);
            x_hat_pad(i) = (w(:, i).')*x_vec;
            error_pad(i) = x_pad(i) - x_hat_pad(i);

            mu_pad(i+1) = mu_pad(i) + rho * error_pad(i) * x_vec'* phi;
%             a = mu_pad(i)*error_pad(i)*x_vec;
            w(:, i+1) = w(:, i) + mu_pad(i)*error_pad(i)*x_vec;
            phi = alpha*phi + error_pad(i)*noise_pad(i-1:-1:i-order);
        end
        
    elseif method == 'BE'  
        for i = 2+order:1001+order
            x_vec = noise_pad(i-1:-1:i-order);
            x_hat_pad(i) = (w(:, i).')*x_vec;
            error_pad(i) = x_pad(i) - x_hat_pad(i);
            
            mu_pad(i+1) = mu_pad(i) + rho * error_pad(i) * x_vec'* phi;
%             a = mu_pad(i)*error_pad(i)*x_vec;
            w(:, i+1) = w(:, i) + mu_pad(i)*error_pad(i)*x_vec;
            phi = (eye(order) - mu_pad(i) * noise_pad(i-1:-1:i-order) * noise_pad(i-1:-1:i-order).') * phi + error_pad(i) * noise_pad(i-1:-1:i-order);
        end
    end    
    
    error = error_pad(order+2:N+order+1);
    w = w(:, order+2:N+order+2);
    x_hat = x_hat_pad(order+2:N+order+1);
end