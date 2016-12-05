n = 100;
m = 5;
theta_true = rand(m, 1);

%A = randn(n, m);
A = 10*(rand(n, m) - .5);

y = A*theta_true;

theta = zeros(m, 1);
alpha = 0.01;

for iter = 1:5000
    rInd = ceil(rand*n);
    theta = theta - alpha*A(rInd, :)'*(A(rInd, :)*theta - y(rInd));
    norm(theta-theta_true)
end


