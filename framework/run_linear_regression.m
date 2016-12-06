function [gd_loss, gd_error, gd_eps, sgd_loss, sgd_error, sgd_eps, opt_loss] ...
    = run_linear_regression(A, y, alpha, iterations)
    
    if nargin < 4
        iterations = 300;
    end
    [m, n] = size(A);

    theta_opt = A\y;
    opt_loss = norm(A*theta_opt - y)^2;

    theta = zeros(n, 1);
    gd_error = zeros(iterations, 1);
    for iter = 1:iterations
       theta = theta - alpha*2*A'*(A*theta - y);
       gd_error(iter) = norm(theta - theta_opt);
    end
    gd_eps = norm(eps(theta));
    gd_loss = norm(A*theta - y)^2;

    theta = zeros(n, 1);
    sgd_error = zeros(iterations, 1);
    sgd_loss = norm(A*theta - y)^2;

    for iter = 1:iterations*m
        rInd = randi(m);
        theta = theta - alpha*2*A(rInd, :)'*(A(rInd, :)*theta - y(rInd));
        sgd_error(iter) = norm(theta - theta_opt);
    end
    sgd_eps = norm(eps(theta));

end