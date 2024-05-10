function gonogo_first_level_all(out_dir, TR, mask, nsclices) 
%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------
spmdir = fullfile(out_dir, 'all');
if ~exist(fullfile(spmdir, 'con_0003.nii'), 'file')
    matlabbatch{1}.spm.stats.fmri_spec.dir = {spmdir};
    matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
    matlabbatch{1}.spm.stats.fmri_spec.timing.RT = TR;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = nsclices;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = floor(nsclices/2);
    
    for run = 0
        sess = run + 1;
        % find fmri data
        files = []; frames=Inf; filt=['task-gonogo_acq-spiralio_run-', num2str(run), '_space-MNI152NLin6Asym_desc-smoothAROMAnonaggr_bold.nii'];
        [files, ~] = spm_select('ExtFPList',out_dir,filt,frames);
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).scans = cellstr(files);
        % onset files
        onset_file = dir(fullfile(out_dir, ['*task-gonogo_run-0', num2str(run), '_events.tsv']));
        onset = tdfread(fullfile(onset_file.folder, onset_file.name)); onset.trial_type = string(onset.trial_type);
        Go = find(((onset.trial_type == 'cGo  ') | (onset.trial_type == 'iGo  ')) == 1); onset_Go = onset.onset(Go); dur_Go = onset.duration(Go);
        NoGo = find(((onset.trial_type == 'cNoGo') | (onset.trial_type == 'iNoGo')) == 1); onset_NoGo = onset.onset(NoGo); dur_NoGo = onset.duration(NoGo);
        
        % 1. all Go trials
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).name = 'Go';
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).onset = onset_Go;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).duration = dur_Go;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
        
        % 2. all NoGo trials
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).name = 'NoGo';
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).onset = onset_NoGo;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).duration = dur_NoGo;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
        
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).multi = {''};
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).regress = struct('name', {}, 'val', {});
        % load covregressors
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).multi_reg = {fullfile(out_dir, ['covregressors_run-',num2str(run),'.txt'])};
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).hpf = 128;
    end
    
    
    matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
    matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
    matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
    matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
    matlabbatch{1}.spm.stats.fmri_spec.mask = {mask};
    matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
    
    
    %% estimate model
    matlabbatch{2}.spm.stats.fmri_est.spmmat = {fullfile(spmdir, 'SPM.mat')};
    matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
    matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
    
    %% contrast
    matlabbatch{3}.spm.stats.con.spmmat = {fullfile(spmdir, 'SPM.mat')};
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'Go';
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec = [1 0];
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'NoGo';% post-congruent conflict (cI-cC)
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.convec = [0 1];
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = 'NoGo_Go';% post-congruent conflict (cI-cC)
    matlabbatch{3}.spm.stats.con.consess{3}.tcon.convec = [-1 1];
    matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.delete = 1;
    
    spm_jobman('interactive',matlabbatch);
    spm_jobman('run',matlabbatch);
end
enfunction gonogo_first_level_all(out_dir, TR, mask, nsclices) 
%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------
spmdir = fullfile(out_dir, 'all');
if ~exist(fullfile(spmdir, 'con_0003.nii'), 'file')
    matlabbatch{1}.spm.stats.fmri_spec.dir = {spmdir};
    matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
    matlabbatch{1}.spm.stats.fmri_spec.timing.RT = TR;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = nsclices;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = floor(nsclices/2);
    
    for run = 0
        sess = run + 1;
        % find fmri data
        files = []; frames=Inf; filt=['task-gonogo_acq-spiralio_run-', num2str(run), '_space-MNI152NLin6Asym_desc-smoothAROMAnonaggr_bold.nii'];
        [files, ~] = spm_select('ExtFPList',out_dir,filt,frames);
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).scans = cellstr(files);
        % onset files
        onset_file = dir(fullfile(out_dir, ['*task-gonogo_run-0', num2str(run), '_events.tsv']));
        onset = tdfread(fullfile(onset_file.folder, onset_file.name)); onset.trial_type = string(onset.trial_type);
        Go = find(((onset.trial_type == 'cGo  ') | (onset.trial_type == 'iGo  ')) == 1); onset_Go = onset.onset(Go); dur_Go = onset.duration(Go);
        NoGo = find(((onset.trial_type == 'cNoGo') | (onset.trial_type == 'iNoGo')) == 1); onset_NoGo = onset.onset(NoGo); dur_NoGo = onset.duration(NoGo);
        
        % 1. all Go trials
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).name = 'Go';
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).onset = onset_Go;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).duration = dur_Go;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
        
        % 2. all NoGo trials
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).name = 'NoGo';
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).onset = onset_NoGo;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).duration = dur_NoGo;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
        
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).multi = {''};
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).regress = struct('name', {}, 'val', {});
        % load covregressors
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).multi_reg = {fullfile(out_dir, ['covregressors_run-',num2str(run),'.txt'])};
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).hpf = 128;
    end
    
    
    matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
    matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
    matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
    matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
    matlabbatch{1}.spm.stats.fmri_spec.mask = {mask};
    matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
    
    
    %% estimate model
    matlabbatch{2}.spm.stats.fmri_est.spmmat = {fullfile(spmdir, 'SPM.mat')};
    matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
    matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
    
    %% contrast
    matlabbatch{3}.spm.stats.con.spmmat = {fullfile(spmdir, 'SPM.mat')};
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'Go';
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec = [1 0];
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'NoGo';% post-congruent conflict (cI-cC)
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.convec = [0 1];
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = 'NoGo_Go';% post-congruent conflict (cI-cC)
    matlabbatch{3}.spm.stats.con.consess{3}.tcon.convec = [-1 1];
    matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.delete = 1;
    
    spm_jobman('interactive',matlabbatch);
    spm_jobman('run',matlabbatch);
end
end
