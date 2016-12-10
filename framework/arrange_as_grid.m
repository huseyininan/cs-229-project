dest_fig = figure;
cs = [10 30 100];
ns = [10 30 100];

for i = 1:numel(cs)
    for j = 1:numel(ns)
        c = cs(i);
        n = ns(j);
        m = c*n;
        mu = 3e-3/n;
        
        % Code taken from
        % https://www.mathworks.com/matlabcentral/answers/101806-how-can-i-insert-my-matlab-figure-fig-files-into-multiple-subplots
        
        filenameparams = sprintf('m%d_n%d_mu%.0e', m, n, mu);
        source_fig = openfig(['../../coursework/cs229/project/plots/grid/residues_sgd_' filenameparams], 'reuse');
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
