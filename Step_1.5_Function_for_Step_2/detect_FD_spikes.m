function [not_complete] = detect_FD_spikes(func_dir, spike_thresh)
not_complete = 0;
for run = 0
    nuis_file = dir(fullfile(func_dir, ['*task-gonogo*run-',num2str(run), '*confounds_timeseries.tsv']));
    if length(nuis_file) > 0
        nuis = tdfread(fullfile(nuis_file.folder, nuis_file.name));
        nuis_header = fieldnames(nuis);
        Index = find(contains(nuis_header,'motion_outlier')); Volumns = length(nuis.global_signal);
        % spike criteria
        if (length(Index)./Volumns) > spike_thresh
            not_complete = 1;
            disp(['   Motion spikes > 25%']);
            return
        end
    else
        not_complete = 1;
        disp(['   Confounds data not complete']);
        return
    end      
end
end
