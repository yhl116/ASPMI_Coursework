function x = generate_x(x0, coef, num_samples, noise_variance)
    for i = 1:order
        if i == 1
            curr_x = randn(1)*noise_variance;
        else
            curr_x = randn(1)*noise_variance;
            for j = 1:(i-1)
                curr_x = curr_x + x(i-j)*coef(j);
            end
        end
        x(i) = curr_x;
    end

    for i = order+1:num_samples
        curr_x = randn(1)*noise_variance;
        for j = 1:order
            curr_x = curr_x + coef(j)*x(i-j);
        end
        x(i) = curr_x;
    end
end
