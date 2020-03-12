function [e, h] = CLMS(x,y,mu,N)
order = 2;
h = zeros(order, N);
   for n = order:N
        x1 = [x(n);x(n-1)];
        y_hat(n) = h(:,n)'*x1;
        e(n) = y(n) - y_hat(n);  
        h(:,n+1) = h(:,n) + mu*conj(e(n))*x1;
    end 
end