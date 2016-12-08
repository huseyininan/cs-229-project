m = 1000;
n = 25;
alpha = 1e-5;
runs = 1000;
iterations = 300;

residue_norms = zeros(runs, 1);
gd_errors = zeros(runs, 1);
sgd_errors = zeros(runs, 1);

for i = 1:runs
    % Randomly generate parameters
    A = 10*(rand(m, n) - .5);
    theta_true = 50*rand(n, 1);
    
    % Pick a residue in a random direction, orthogonal to range(A).
    residue_direction = randn(m-n, 1);
    residue_direction = residue_direction / norm(residue_direction);
    residue = null(A')*residue_direction*sqrt(rand())*1000;
    residue_norms(i) = norm(residue);
    
    y = A*theta_true + residue;
    [~, gd_error, ~, ~, sgd_error, ~, ~] = run_linear_regression(A, y, alpha, iterations);
    gd_errors(i) = gd_error(end); % take just the last error
    sgd_errors(i) = sgd_error(end); % take just the last error
    
    % Admin stuff
    fprintf('Completed %d out of %d runs\r', i, runs)
    save('data.mat', 'residue_norms', 'gd_errors', 'sgd_errors')
end

%% Generate a plot
fig1 = figure(1);
clf
plot(residue_norms.^2, gd_errors.^2, '+')
title(sprintf('Gradient descent (m = %d, n = %d)', m, n))
xlabel('||residue||^2')
ylabel(sprintf('|| \theta^{(%d)} - \theta_{opt} ||^2', iterations))
savefig(fig1, 'residues_gd', 'compact')
saveas(fig1, 'residues_gd.eps')
saveas(fig1, 'residues_gd.png')

fig2 = figure(2);
clf
plot(residue_norms.^2, sgd_errors.^2, '+')
title(sprintf('Stochastic gradient descent (m = %d, n = %d)', m, n))
xlabel('||residue||^2')
ylabel(sprintf('|| \theta^{(%d)} - \theta_{opt} ||^2', iterations))
savefig(fig2, 'residues_sgd', 'compact')
saveas(fig2, 'residues_sgd.eps')
saveas(fig2, 'residues_sgd.png')
