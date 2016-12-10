% Plots residue vs error scatter plots and saves to disk.
% Assumes that all variables named exist; cannot be run standalone.

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
