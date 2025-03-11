from generate_onset_1 import format_gonogo
from generate_onset_1 import format_gonogotsv
import numpy as np
# convert xls files from box to tsv for analysis

#Also sample 044 has a problem since its associated to sample 042, so I removedit from the loop otherwise it could not run
subHCs00= ["044","045", "048", "051", "060"]
subHCs01= ["044", "045", "060"]
subHDs00= ["028", "033", "021", "015", "062", "020", "024", "027", "030", "055", "056", "057", "063", "054", "039", "040", "031", "042", "014", "026"]
#Also sample 055 has a problem since its associated to sample 052, so I removedit from the loop otherwise it could not run
subHDs00= ["028", "033", "021", "015", "062", "020", "024", "027", "030", "055", "056", "057", "063", "054", "039", "040", "031", "042", "014", "026"]
subHDs01= ["028", "033", "021", "015", "020", "024", "027", "030", "014", "026"]


#LOOP TO CONVERT xls.files In  tsv. FILES

for x in subHCs00:
	filepath = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/Task_xls/GoNoGoTaskBaselineHC/GoNoGo' + x + 'B.xls'
	outputpath = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s0/git_gonogo'
	filenametsv = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s0/git_gonogo/sub-BITS' + x + '_ses_s0_task-gonogo_run-00_events.tsv'
	filenametxt = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s0/git_gonogo/sub-BITS' + x + '_ses_s0_task-gonogo_run-00_events.txt'
	subname = 'BITS' + x
	newvar = format_gonogo(filepath, subname, 0.2)
	os.mkdir(outputpath)
	newvar.to_csv(filenametsv, sep="\t", index=False)

	np.savetxt(filenametxt, newvar,delimiter="\t",fmt='%s')

for x in subHCs01:
	filepath = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/Task_xls/GoNoGoTaskWeek18HC/GoNoGo' + x + 'W.xls'
	outputpath = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s1/git_gonogo'
	filenametsv = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s1/git_gonogo/sub-BITS' + x + '_ses_s1_task-gonogo_run-00_events.tsv'
	filenametxt = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s1/git_gonogo/sub-BITS' + x + '_ses_s1_task-gonogo_run-00_events.txt'
	subname = 'BITS' + x
	newvar = format_gonogo(filepath, subname, 0.2)
	os.mkdir(outputpath)
	newvar.to_csv(filenametsv, sep="\t", index=False)

	np.savetxt(filenametxt, newvar,delimiter="\t",fmt='%s')

for x in subHDs00:
	filepath = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/Task_xls/GoNoGoTaskBaselineHD/GoNoGo' + x + '-1B.xls'
	outputpath = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s0/git_gonogo'
	filenametsv = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s0/git_gonogo/sub-BITS' + x + '_ses_s0_task-gonogo_run-00_events.tsv'
	filenametxt = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s0/git_gonogo/sub-BITS' + x + '_ses_s0_task-gonogo_run-00_events.txt'
	subname = 'BITS' + x
	newvar = format_gonogo(filepath, subname, 0.2)
	os.mkdir(outputpath)
	newvar.to_csv(filenametsv, sep="\t", index=False)

	np.savetxt(filenametxt, newvar,delimiter="\t",fmt='%s')

for x in subHDs01:
	filepath = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/Task_xls/GoNoGoTaskWeek18HD/GoNoGo' + x + '-2W.xls'
	outputpath = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s1/git_gonogo'
	filenametsv = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s1/git_gonogo/sub-BITS' + x + '_ses_s1_task-gonogo_run-00_events.tsv'
	filenametxt = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s1/git_gonogo/sub-BITS' + x + '_ses_s1_task-gonogo_run-00_events.txt'
	subname = 'BITS' + x
	newvar = format_gonogo(filepath, subname, 0.2)
	os.mkdir(outputpath)
	newvar.to_csv(filenametsv, sep="\t", index=False)

	np.savetxt(filenametxt, newvar,delimiter="\t",fmt='%s')

# AP specific loop. Connectome PTs
subsHCP=["CONN067"]
for x in subsHCP:
	filepath='/oak/stanford/groups/leanew1/SHARED_DATASETS/private/connectome/bids/data/bids-input/sub-' + x + '/ses-BL/func/sub-' + x + '_ses-BL_task-gonogo_acq-sb_dir-pe1_run-00_events.tsv'

