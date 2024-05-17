function not_complete = prep_onset(onset_dir)
% copy onsets and only process data with subject's accuracy >
% 65%
not_complete = 0;
for run = 0
    onset = dir(fullfile(onset_dir,['*task-gonogo_run-0', num2str(run), '_events.tsv']));
    if length(onset) > 0
        onset_data = tdfread(fullfile(onset.folder, onset.name));
        % accuracy must be above 65%
        accuracy = length(find(onset_data.correctness == 1))./length(onset_data.correctness);
        if accuracy < 0.65
            not_complete = 1;
            disp(['   Accuracy < 0.65']);
%             if exist(out_dir,'dir'), delete(out_dir), end
            return
        end
    else
        not_complete = 1;
        disp(['   Onset data not complete']);
        return
    end
end

end

