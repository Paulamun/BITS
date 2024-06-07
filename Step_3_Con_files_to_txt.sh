#FOR HC GROUP BASELINE 
for sample in 044 045 048 051 060 
do
3dROIstats -mask /oak/stanford/groups/leanew1/BITS/PM_Mask.nii /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS"$sample"/ses-s0/gonogo/activation/all/con_0001.nii > /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/txt_Files_GoNoGoTaskBaselineHC/sub-BITS"$sample"_Con_0001.txt
done

for sample in  044 045 048 051 060 
do
3dROIstats -mask /oak/stanford/groups/leanew1/BITS/PM_Mask.nii /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS"$sample"/ses-s0/gonogo/activation/all/con_0002.nii > /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/txt_Files_GoNoGoTaskBaselineHC/sub-BITS"$sample"_Con_0002.txt
done

for sample in 044 045 048 051 060 
do
3dROIstats -mask /oak/stanford/groups/leanew1/BITS/PM_Mask.nii /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS"$sample"/ses-s0/gonogo/activation/all/con_0003.nii > /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/txt_Files_GoNoGoTaskBaselineHC/sub-BITS"$sample"_Con_0003.txt
done


#FOR HD GROUP BASELINE 
for sample in 028 033 021 015 062 020 024 027 030 055 056 057 063 054 039 040 031 042 014 026
do
3dROIstats -mask /oak/stanford/groups/leanew1/BITS/PM_Mask.nii /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS"$sample"/ses-s0/gonogo/activation/all/con_0001.nii > /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/txt_Files_GoNoGoTaskBaselineHD/sub-BITS"$sample"_Con_0001.txt
done

for sample in  028 033 021 015 062 020 024 027 030 055 056 057 063 054 039 040 031 042 014 026
do
3dROIstats -mask /oak/stanford/groups/leanew1/BITS/PM_Mask.nii /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS"$sample"/ses-s0/gonogo/activation/all/con_0002.nii > /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/txt_Files_GoNoGoTaskBaselineHD/sub-BITS"$sample"_Con_0002.txt
done

for sample in 028 033 021 015 062 020 024 027 030 055 056 057 063 054 039 040 031 042 014 026
do
3dROIstats -mask /oak/stanford/groups/leanew1/BITS/PM_Mask.nii /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS"$sample"/ses-s0/gonogo/activation/all/con_0003.nii > /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/txt_Files_GoNoGoTaskBaselineHD/sub-BITS"$sample"_Con_0003.txt
done


#FOR HD GROUP WEEK 18
for sample in 028 033 021 015 020 024 027 030 014 026
do
3dROIstats -mask /oak/stanford/groups/leanew1/BITS/PM_Mask.nii /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS"$sample"/ses-s0/gonogo/activation/all/con_0001.nii > /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/txt_Files_GoNoGoTaskWeek18HD/sub-BITS"$sample"_Con_0001.txt
done

for sample in  028 033 021 015 020 024 027 030 014 026
do
3dROIstats -mask /oak/stanford/groups/leanew1/BITS/PM_Mask.nii /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS"$sample"/ses-s0/gonogo/activation/all/con_0002.nii > /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/txt_Files_GoNoGoTaskWeek18HD/sub-BITS"$sample"_Con_0002.txt
done

for sample in 028 033 021 015 020 024 027 030 014 026
do
3dROIstats -mask /oak/stanford/groups/leanew1/BITS/PM_Mask.nii /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/sub-BITS"$sample"/ses-s0/gonogo/activation/all/con_0003.nii > /oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/bids-input/bids-input/txt_Files_GoNoGoTaskWeek18HD/sub-BITS"$sample"_Con_0003.txt
done
