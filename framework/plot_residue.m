% Plots residue vs error scatter plots and saves to disk.
% Requires the following variables to exist prior to script execution:
%  'ms', 'n', 'mu', 'iterations', 'residue_norms', 'gd_errors', 'sgd_errors'

filenameparams = sprintf('n%d_mu%.0e', n, mu);

if ~exist('data', 'dir')
    mkdir('data')
end
save(['data/data_' filenameparams '.mat'], 'ms', 'n', 'mu', 'iterations', 'residue_norms', 'gd_errors', 'sgd_errors')

if ~exist('plots', 'dir')
    mkdir('plots')
end

legend_by_ms = arrayfun(@(x) sprintf('m = %d', x), ms, 'UniformOutput', false);
markers = {'o'; '+'; 's'; '^'; 'x'};

fig1 = figure(1);
clf
gd_plots = plot(residue_norms.^2, gd_errors.^2);
title(sprintf('Gradient descent (n = %d, \\mu = %.1e)', n, mu))
xlabel('||residue||^2')
ylabel(sprintf('|| \\theta^{(%d)} - \\theta_{opt} ||^2', iterations))
legend(legend_by_ms)
set(gd_plots, {'Marker'}, markers(1:numel(ms)), 'LineStyle', 'none')
filename = ['plots/residues_gd_' filenameparams];
savefig(fig1, filename, 'compact')
saveas(fig1, [filename '.eps'])
saveas(fig1, [filename '.png'])

fig2 = figure(2);
clf
sgd_plots = plot(residue_norms.^2, sgd_errors.^2);
title(sprintf('Stochastic gradient descent (n = %d, \\mu = %.1e)', n, mu))
xlabel('||residue||^2')
ylabel(sprintf('|| \\theta^{(%d)} - \\theta_{opt} ||^2', iterations))
legend(legend_by_ms)
set(sgd_plots, {'Marker'}, markers(1:numel(ms)), 'LineStyle', 'none')
filename = ['plots/residues_sgd_' filenameparams];
savefig(fig2, filename, 'compact')
saveas(fig2, [filename '.eps'])
saveas(fig2, [filename '.png'])
