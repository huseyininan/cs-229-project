m = 1000;
n = 20;
alpha = 1e-5;
runs = 1000;

residue_sqnorms = zeros(runs, 1);
gd_errors = zeros(runs, 1);
sgd_errors = zeros(runs, 1);

for i = 1:runs
    % Randomly generate parameters
    A = 10*(rand(m, n) - .5);
    theta_true = 50*rand(n, 1);
    
    % Pick a residue in a random direction, orthogonal to range(A).
    residue_direction = randn(m-n, 1);
    residue_direction = residue_direction / norm(residue_direction);
    residue = null(A')*residue_direction*rand()*1000;
    residue_sqnorms(i) = norm(residue)^2;
    
    y = A*theta_true + residue;
    [~, gd_error, ~, ~, sgd_error, ~, ~] = run_linear_regression(A, y, alpha);
    gd_errors(i) = gd_error(end); % take just the last error
    sgd_errors(i) = sgd_error(end); % take just the last error
    
    % Admin stuff
    display(['Completed ' num2str(i) ' out of ' num2str(runs)])
    save data.mat
end

clf
subplot(1, 2, 1)
plot(residue_sqnorms, gd_errors, '+')
title('Gradient descent')
subplot(1, 2, 2)
plot(residue_sqnorms, sgd_errors, '+')
title('Stochastic gradient descent')
