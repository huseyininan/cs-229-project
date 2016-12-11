source_dir = '../../../Dropbox/CS 229 Plots/PLOTS_huseyin';

dest_fig = figure;

dir_list = arrayfun(@(x) x.name, dir(source_dir), 'UniformOutput', false);
dir_list = dir_list(arrayfun(@(x) endsWith(x, '.fig'), dir_list));

for i = 1:9
    filename = dir_list{i};

    % Code taken from
    % https://www.mathworks.com/matlabcentral/answers/101806-how-can-i-insert-my-matlab-figure-fig-files-into-multiple-subplots

    source_fig = openfig(fullfile(source_dir, filename));
    source_axes = gca;
    source_objects = source_axes.Children;
    source_title = source_axes.Title.String;

    figure(dest_fig);
    dest_subplot = subplot(3,3,i);
    copyobj(source_objects, dest_subplot);
    title(source_title);

    close(source_fig)
end
