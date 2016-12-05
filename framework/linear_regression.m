m = 1000;
n = 20;
iterations = 300;
theta_true = rand(n, 1);

% A = randn(m, n);
alpha = 1e-5;
A = 10*(rand(m, n) - .5);
% alpha = 1e-1;
% A = eye(m, n);
y = A*theta_true + randn(m, 1);
% y = A*theta_true;
% y = rand(m, 1);

theta_opt = A\y;
% theta_true = theta_opt;
% residue = y - A*theta_opt;
loss_min = norm(theta_opt - theta_true);


theta = zeros(n, 1);
gd_error = zeros(iterations, 1);
for iter = 1:iterations
   theta = theta - alpha*2*A'*(A*theta - y);
   gd_error(iter) = norm(theta - theta_true);
end
gd_eps = norm(eps(theta));


theta = zeros(n, 1);
sgd_error = zeros(iterations, 1);

for iter = 1:iterations*m
    rInd = randi(m);
    theta = theta - alpha*2*A(rInd, :)'*(A(rInd, :)*theta - y(rInd));
    sgd_error(iter) = norm(theta - theta_true);
end
sgd_eps = norm(eps(theta));

clf
semilogy(1:iterations, gd_error, (1:iterations*m)/m, sgd_error)
hold on
% plot(xlim, gd_eps*[1 1], 'b:', xlim, sgd_eps*[1 1], 'r:')
plot(xlim, loss_min*[1 1], 'k')
legend('GD', 'SGD')
xlabel('iterations')
ylabel('|| \theta - \theta_{true} ||')

