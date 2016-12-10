cs = [10 30 100];
ns = [10 30 100];
runs = 700;
iterations = 300;

for c = cs
    for n = ns
        m = c*n;
        mu = 3e-3/n;
        
        fprintf('Started c=%d, m=%d, n=%d, mu=%.0e at %s\n', c, m, n, mu, datestr(now))

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
            [~, gd_error, ~, ~, sgd_error, ~, ~] = run_linear_regression(A, y, mu, iterations);
            gd_errors(i) = gd_error(end); % take just the last error
            sgd_errors(i) = sgd_error(end); % take just the last error

            % Admin stuff
            fprintf('Completed %d out of %d runs\r', i, runs)
            save('data.mat', 'residue_norms', 'gd_errors', 'sgd_errors')
        end

        %% Generate a plot
        filenameparams = sprintf('m%d_n%d_mu%.0e', m, n, mu);

        fig1 = figure(1);
        clf
        plot(residue_norms.^2, gd_errors.^2, '+')
        title(sprintf('Gradient descent (m = %d, n = %d, \\mu = %.1e)', m, n, mu))
        xlabel('||residue||^2')
        ylabel(sprintf('|| \\theta^{(%d)} - \\theta_{opt} ||^2', iterations))
        filename = ['residues_gd_' filenameparams];
        savefig(fig1, filename, 'compact')
        saveas(fig1, [filename '.eps'])
        saveas(fig1, [filename '.png'])

        fig2 = figure(2);
        clf
        plot(residue_norms.^2, sgd_errors.^2, '+')
        title(sprintf('Stochastic gradient descent (m = %d, n = %d, \\mu = %.1e)', m, n, mu))
        xlabel('||residue||^2')
        ylabel(sprintf('|| \\theta^{(%d)} - \\theta_{opt} ||^2', iterations))
        filename = ['residues_sgd_' filenameparams];
        savefig(fig2, filename, 'compact')
        saveas(fig2, [filename '.eps'])
        saveas(fig2, [filename '.png'])
    end
end
