addpath (genpath('/home/users/paulamun/230502_JP_Paula_GoNoGo_level1/'))

addpath (genpath('/oak/stanford/groups/leanew1/users/paulamun/'))

fmriprep_dir = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/derivatives/fmriprep-20.2.3/fmriprep';
bidsinput_dir = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input';
model_dir = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/';

mask = ['BrainMask_05_91x109x91.img'];

subject_all = {'BITS045'};

session_all = {'s1'};
for isub = 1: length(subject_all)
TR = 2; nsclices = 32; spike_thresh = 0.25;
    subject = subject_all{isub};

 for ises = 1: length(session_all)
        session = session_all{1};
        disp(['Analyzing subject ', subject, ' session ', session]);
        func_dir = fullfile(fmriprep_dir, ['sub-', subject], ['ses-', session], 'func'); 
        if ~exist(func_dir, 'dir')
            disp(['   Data not collected for session ', session]);
            continue
        end
       
        onset_dir = fullfile(['/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-' subject '/ses-' session '/func/']);
        out_dir = fullfile(model_dir, ['sub-', subject], ['ses-', session], 'gonogo', 'activation')
       
        not_complete_func = prep_func(func_dir); 
       
        not_complete_onset = prep_onset(onset_dir);

        [not_complete_spikes] = detect_FD_spikes(func_dir, spike_thresh);
        if (not_complete_func == 1) || (not_complete_onset == 1) || (not_complete_spikes == 1)
            continue
        else
        	disp(['copiying func_onset'])
    
            copy_func_onset(func_dir, onset_dir, out_dir);

disp(func_dir)
disp(out_dir)
            generate_FD_regressors(func_dir, out_dir);

            disp(['   Modeling subject ', subject, ' session ', session]);

            gonogo_first_level_all(out_dir, TR, mask, nsclices);

            %gonogo_first_level_correct(out_dir, TR, mask, nsclices) 
        end
        
    end
end