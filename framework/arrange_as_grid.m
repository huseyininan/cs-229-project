source_dir = '../../../Dropbox/CS 229 Plots/grid-2/plots';
dest_fig = figure;
ms = [100 300 1000];
ns = [10 30 100];

% dir_list = arrayfun(@(x) x.name, dir(source_dir), 'UniformOutput', false);
% dir_list = dir_list(arrayfun(@(x) endsWith(x, '.png') && startsWith(x, 'residues_sgd'), dir_list));

for i = 1:numel(ms)
    for j = 1:numel(ns)
        m = ms(i);
        n = ns(j);
        c = m/n;
        mu = 3e-3/n;
        
        % Code taken from
        % https://www.mathworks.com/matlabcentral/answers/101806-how-can-i-insert-my-matlab-figure-fig-files-into-multiple-subplots
        
        filenameparams = sprintf('m%d_n%d_mu%.0e', m, n, mu);
        source_fig = openfig(fullfile(source_dir, ['residues_sgd_' filenameparams]));
        source_axes = gca;
        source_objects = source_axes.Children;
        source_title = source_axes.Title.String;
        
        figure(dest_fig);
        dest_subplot = subplot(3,3,(i-1)*numel(ns)+j);
        copyobj(source_objects, dest_subplot);
        title(source_title);
        
        close(source_fig)
    end
end
