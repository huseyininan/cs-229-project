ms = [100 300 1000];
ns = [10 30];
runs = 10;
iterations = 300;
M = numel(ms);

for n = ns

    residue_norms = zeros(runs, M);
    gd_errors = zeros(runs, M);
    sgd_errors = zeros(runs, M);

    for j = 1:M
        m = ms(j);
        c = m/n;
        mu = 3e-3/n;

        fprintf('Started c=%d, m=%d, n=%d, mu=%.0e at %s\n', c, m, n, mu, datestr(now))

        for i = 1:runs
            % Randomly generate parameters
            A = 10*(rand(m, n) - .5);
            theta_true = 50*rand(n, 1);

            % Pick a residue in a random direction, orthogonal to range(A).
            residue_direction = randn(m-n, 1);
            residue_direction = residue_direction / norm(residue_direction);
            residue = null(A')*residue_direction*sqrt(rand())*1000;
            residue_norms(i,j) = norm(residue);

            y = A*theta_true + residue;
            [~, gd_error, ~, ~, sgd_error, ~, ~] = run_linear_regression(A, y, mu, iterations);
            gd_errors(i,j) = gd_error(end); % take just the last error
            sgd_errors(i,j) = sgd_error(end); % take just the last error

            % Admin stuff
            fprintf('Completed %d out of %d runs\r', i, runs)
            save('data_backup.mat', 'i', 'm', 'ms', 'n', 'mu', 'iterations', 'residue_norms', 'gd_errors', 'sgd_errors')
        end
    end
    
    %% Generate a plot
    plot_residue
end

fprintf('Finished at %s\n', datestr(now))
