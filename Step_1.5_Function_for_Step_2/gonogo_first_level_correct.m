gonogo_first_level_correct (Week 18)


function gonogo_first_level_correct(out_dir, TR, mask, nsclices) 
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
    % loop across 3 runs
    for run = 0
        sess = run + 1;
        % find fmri data
        files = []; frames=Inf; filt=['task-gonogo_acq-spiralio_run-', num2str(run), '_space-MNI152NLin6Asym_desc-smoothAROMAnonaggr_bold.nii'];
        [files, ~] = spm_select('ExtFPList',out_dir,filt,frames);
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).scans = cellstr(files);
        % onset files
        onset_file = dir(fullfile(out_dir, ['*task-gonogo_run-0', num2str(run), '_events.tsv']));
        onset = tdfread(fullfile(onset_file.folder, onset_file.name)); onset.trial_type = string(onset.trial_type);
        cC = find((onset.trial_type == 'cC') == 1); onset_cC = onset.onset(cC); dur_cC = onset.duration(cC);
        iC = find((onset.trial_type == 'iC') == 1); onset_iC = onset.onset(iC); dur_iC = onset.duration(iC);
        cI = find((onset.trial_type == 'cI') == 1); onset_cI = onset.onset(cI); dur_cI = onset.duration(cI);
        iI = find((onset.trial_type == 'iI') == 1); onset_iI = onset.onset(iI); dur_iI = onset.duration(iI);
        ft = find((onset.trial_type == 'ft') == 1); onset_ft = onset.onset(ft); dur_ft = onset.duration(ft);
        aI = find((onset.trial_type == 'aI') == 1);
        
        % 1. CORRECT congruent preceded by congruent (cC)
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).name = 'cC';
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).onset = onset_cC;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).duration = dur_cC;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
        
        % 2. CORRECT congruent preceded by incongruent (iC)
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).name = 'iC';
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).onset = onset_iC;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).duration = dur_iC;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
        
        % 3. CORRECT incongruent preceded by congruent (cI)
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(3).name = 'cI';
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(3).onset = onset_cI;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(3).duration = dur_cI;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(3).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
        
        % 4. CORRECT incongruent preceded by incongruent (iI)
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(4).name = 'iI';
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(4).onset = onset_iI;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(4).duration = dur_iI;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(4).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
        
        % 5: first trial
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(5).name = 'ft';
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(5).onset = onset_ft;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(5).duration = dur_ft;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(5).tmod = 0;
        matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(5).pmod = struct('name', {}, 'param', {}, 'poly', {});
        
        % 6. All incorrect
        if length(aI) > 0
            onset_aI = onset.onset(aI); dur_aI = onset.duration(aI);
            matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(6).name = 'aI';
            matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(6).onset = onset_aI;
            matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(6).duration = dur_aI;
            matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(6).tmod = 0;
            matlabbatch{1}.spm.stats.fmri_spec.sess(sess).cond(6).pmod = struct('name', {}, 'param', {}, 'poly', {});
        end
        
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
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'cI_iI_vs_cC_iC'; % (cI + iI) – (cC + iC)
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.convec = [-1 -1 1 1];
    matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'cI_vs_cC';% post-congruent conflict (cI-cC)
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.convec = [-1 0 1 0];
    matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
    matlabbatch{3}.spm.stats.con.delete = 1;
    
%     spm_jobman('interactive',matlabbatch);
    spm_jobman('run',matlabbatch);
end
end
