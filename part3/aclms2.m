function [e, h, g] = aclms2(x,y,mu,N,order)
h = zeros(order, N);
g = zeros(order, N);  
    for n = order+1:N
        x1 = [x(n);x(n-1)];
        x1_conj = [conj(x(n));conj(x(n-1))];
        y_hat(n) = h(:,n)'*x1 + g(:,n)'*x1_conj;
        e(n) = y(n) - y_hat(n);  
        h(:,n+1) = h(:,n) + mu*conj(e(n))*x1;
        g(:,n+1) = g(:,n) + mu*conj(e(n))*x1_conj;
    end 
end