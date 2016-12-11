m = 100;
n = 10;
iterations = 300;
theta_true = rand(n, 1);

mu = 1e-5;
A = 10*randn(m, n);
% A = 10*(rand(m, n) - .5);
% A = A*rand(n, n);
% alpha = 1e-1;
% A = eye(m, n);
% y = A*theta_true + randn(m, 1);
y = A*theta_true;
% y = rand(m, 1);

theta_opt = A\y;
% theta_true = theta_opt;
loss_min = norm(theta_opt - theta_true) %#ok<NOPTS>

[gd_loss, gd_error, gd_eps, sgd_loss, sgd_error, sgd_eps, opt_loss] ...
    = run_linear_regression(A, y, mu, iterations);

%% plot

clf
semilogy(1:iterations, gd_error, (1:iterations*m)/m, sgd_error)
hold on
% plot(xlim, gd_eps*[1 1], 'b:', xlim, sgd_eps*[1 1], 'r:')
% plot(xlim, loss_min*[1 1], 'k')
legend('GD', 'SGD')
xlabel('iterations')
ylabel('|| \theta - \theta_{opt} ||')

