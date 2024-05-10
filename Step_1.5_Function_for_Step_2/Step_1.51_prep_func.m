function not_complete = prep_func(func_dir)
% unzip fmri data  to out_dir and move them to out_dir
% if not exist, then skip the session
not_complete = 0;
for run = 0
    fmri = dir(fullfile(func_dir, ['*task-gonogo_acq-spiralio_run-', num2str(run), '_space-MNI152NLin6Asym_desc-smoothAROMAnonaggr_bold.nii*']));
    if length(fmri) == 0
        not_complete = 1;
        disp(['   fMRI data not complete for']);
        return
    end
end
