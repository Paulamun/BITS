function generate_FD_regressors(func_dir, out_dir)
%% get nuisance regressors: motion spikes, 12 motion regressors, 
%% non-steady state regressor, and top 5 compcor regressors
for run = 0
    regressor_file = fullfile(out_dir, ['covregressors_run-',num2str(run),'.txt']);
    if ~exist(regressor_file, 'file')
        nuis_file = dir(fullfile(func_dir, ['*task-gonogo*run-',num2str(run), '*confounds_timeseries.tsv']));
        nuis = tdfread(fullfile(nuis_file.folder, nuis_file.name));
        nuis_header = fieldnames(nuis);
        nuis_reg = {'motion_outlier', 'non_steady_state_outlier', 'a_comp_cor_00', ...
            'a_comp_cor_01', 'a_comp_cor_02', 'a_comp_cor_03', 'a_comp_cor_04'};
        for group = {'trans', 'rot'}
            for axis = {'x', 'y', 'z'}
                for delta = {'', 'derivative1'}
                    for power = {'', 'power2'}
                        col = [group{:}, '_', axis{:}];
                        if ~isempty(delta{:})
                            col = [col, '_', delta{:}];
                        end
                        if ~isempty(power{:})
                            col = [col, '_', power{:}];
                        end
                        nuis_reg = [nuis_reg, col];
                    end
                end
            end
        end
        nuis_names_cell = cellfun(@(x) nuis_header(contains(nuis_header, x)), nuis_reg, 'UniformOutput', false);
        nuis_names = cat(1, nuis_names_cell{:});
        nuis_select = [];
        for i_nuis = 1: length(nuis_names)
            nuis_i = nuis.(nuis_names{i_nuis});
            if ~isnumeric(nuis_i)
                nuis_i = str2num(standardizeMissing(nuis_i,'n/a'));
                nuis_i = [0; nuis_i];
            end
            nuis_select = [nuis_select, nuis_i];
        end
        % save the nuis_select to the output folder
        dlmwrite(regressor_file, nuis_select);
    end
end
end
