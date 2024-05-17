function copy_func_onset(func_dir, onset_dir, out_dir)
% copy onset and fmri data to out_dir
for run = 0
    % copy data to out_dir
    fmri_key = ['*task-gonogo_acq-spiralio_run-', num2str(run), '_space-MNI152NLin6Asym_desc-smoothAROMAnonaggr_bold.nii*'];
    fmri = dir(fullfile(func_dir, fmri_key));
    if length(dir(fullfile(out_dir, fmri_key))) == 0
        gunzip(fullfile(fmri.folder, fmri.name), out_dir);
    end
    % copy onset
    onset = dir(fullfile(onset_dir, ['*task-gonogo_run-0', num2str(run), '_events.tsv']));
    if length(dir(fullfile(out_dir, onset.name))) == 0
        copyfile(fullfile(onset.folder, onset.name), fullfile(out_dir, onset.name));
    end
end
end
