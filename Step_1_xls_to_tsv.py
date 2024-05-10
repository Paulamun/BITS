from generate_onset import format_gonogo
import numpy as np
# convert xls files from box to tsv for analysis

#Also sample 044 has a problem since its associated to sample 042, so I removedit from the loop otherwise it could not run
subHCs00= ["044","045", "048", "051", "060"]
subHCs01= ["044", "045", "060"]
subHDs00= ["028", "033", "021", "015", "062", "020", "024", "027", "030", "055", "056", "057", "063", "054", "039", "040", "031", "042", "014", "026"]
#Also sample 055 has a problem since its associated to sample 052, so I removedit from the loop otherwise it could not run
subHDs00= ["028", "033", "021", "015", "062", "020", "024", "027", "030", "055", "056", "057", "063", "054", "039", "040", "031", "042", "014", "026"]
subHDs01= ["028", "033", "021", "015", "020", "024", "027", "030", "014", "026"]

# AP - commented out lists for BITS above
# and below

#LOOP TO CONVERT xls.files In  tsv. FILES

for x in subHCs00:
	filepath = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/Task_xls/GoNoGoTaskBaselineHC/GoNoGo' + x + 'B.xls'
	filename = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s0/func/sub-BITS' + x + '_ses_s0_task-gonogo_run-00_events.tsv'
	subname = 'BITS' + x
	newvar = format_gonogo(filepath, subname, 0.2)
	newvar.to_csv(filename, sep="\t", index=False)

	np.savetxt(filename, newvar,delimiter="\t",fmt='%s')

for x in subHCs01:
	filepath = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/Task_xls/GoNoGoTaskWeek18HC/GoNoGo' + x + 'W.xls'
	filename = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s1/func/sub-BITS' + x + '_ses_s1_task-gonogo_run-00_events.tsv'
	subname = 'BITS' + x
	newvar = format_gonogo(filepath, subname, 0.2)
	newvar.to_csv(filename, sep="\t", index=False)

	np.savetxt(filename, newvar,delimiter="\t",fmt='%s')


# AP - is there a reason this single for loop reads in run-00 while the others read in run-01? If there are two runs (everyone has run-00 and run-01) that is HUGE benefit statistically and we should be using both. It's likely to be more beneficial than having 2x the number of subejects.

for x in subHDs00:
	filepath = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/Task_xls/GoNoGoTaskBaselineHD/GoNoGo' + x + '-1B.xls'
	filename = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s0/func/sub-BITS' + x + '_ses_s0_task-gonogo_run-00_events.tsv'
	subname = 'BITS' + x
	newvar = format_gonogo(filepath, subname, 0.2)
	newvar.to_csv(filename, sep="\t", index=False)

	np.savetxt(filename, newvar,delimiter="\t",fmt='%s')

for x in subHDs01:
	filepath = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/Task_xls/GoNoGoTaskWeek18HD/GoNoGo' + x + '-2W.xls'
	filename = '/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS' + x + '/ses-s1/func/sub-BITS' + x + '_ses_s1_task-gonogo_run-00_events.tsv'
	subname = 'BITS' + x
	newvar = format_gonogo(filepath, subname, 0.2)
	newvar.to_csv(filename, sep="\t", index=False)

	np.savetxt(filename, newvar,delimiter="\t",fmt='%s')

# AP specific loop. Connectome PTs
subsHCP=["CONN067"]
for x in subsHCP:
	filepath='/oak/stanford/groups/leanew1/SHARED_DATASETS/private/connectome/bids/data/bids-input/sub-' + x + '/ses-BL/func/sub-' + x + '_ses-BL_task-gonogo_acq-sb_dir-pe1_run-00_events.tsv'

