/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/derivatives/fmriprep-20.2.3/fmriprep/sub-BITS014/ses-s0/func
patientsHDW18 <- list("BITS014","BITS015","BITS021","BITS024","BITS026","BITS027","BITS028","BITS030","BITS031","BITS039","BITS040",
                        "BITS042","BITS054","BITS055","BITS056","BITS057","BITS062","BITS063","BITS020","BITS014","BITS015","BITS021",
                        "BITS024","BITS026","BITS027","BITS028","BITS030","BITS044","BITS045","BITS048","BITS051","BITS060")
patientsHDW18 <- list("BITS014","BITS015","BITS021","BITS024","BITS026","BITS027","BITS028","BITS030","BITS031","BITS039","BITS040",
                      "BITS042","BITS054","BITS055","BITS056","BITS057","BITS062","BITS063","BITS020","BITS014","BITS015","BITS021",
                      "BITS024","BITS026","BITS027","BITS028","BITS030","BITS044","BITS045","BITS048","BITS051","BITS060")
patientsHDW18 <- list("BITS014","BITS015","BITS021","BITS024","BITS026","BITS027","BITS028","BITS030","BITS031","BITS039","BITS040",
                      "BITS042","BITS054","BITS055","BITS056","BITS057","BITS062","BITS063","BITS020","BITS014","BITS015","BITS021",
                      "BITS024","BITS026","BITS027","BITS028","BITS030","BITS044","BITS045","BITS048","BITS051","BITS060")


meanpatientsHDbaseline <- c()
patientsHDbaseline <- list("BITS014","BITS015","BITS021","BITS024","BITS026","BITS027","BITS028","BITS030","BITS031","BITS039","BITS040","BITS042","BITS054","BITS055","BITS056","BITS057","BITS062","BITS063")
for (x in patientsHDbaseline){
  filename <- paste("/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/derivatives/fmriprep-20.2.3/fmriprep/sub-", x,"/ses-s0/func/sub-", x, "_ses-s0_task-gonogo_acq-spiralio_run-0_desc-confounds_timeseries.tsv", sep="")
  confounds <- read.delim(filename)
  average <- mean(na.omit(as.numeric(confounds$framewise_displacement)))
  meanpatientsHDbaseline <- rbind(meanpatientsHDbaseline, c(x, average))
}
write.table(meanpatientsHDbaseline,"meanpatientsHDbaseline.txt",sep="\t")

meanpatientsHCbaseline <- c()
patientsHCbaseline <- list("BITS044","BITS045","BITS048","BITS051","BITS060")
for (x in patientsHCbaseline){
  filename <- paste("/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/derivatives/fmriprep-20.2.3/fmriprep/sub-", x,"/ses-s0/func/sub-", x, "_ses-s0_task-gonogo_acq-spiralio_run-0_desc-confounds_timeseries.tsv", sep="")
  confounds <- read.delim(filename)
  average <- mean(na.omit(as.numeric(confounds$framewise_displacement)))
  meanpatientsHCbaseline <- rbind(meanpatientsHCbaseline, c(x, average))
}
write.table(meanpatientsHCbaseline,"meanpatientsHCbaseline.txt",sep="\t")

meanpatientsHCW18 <- c()
patientsHDW18 <- list("BITS014","BITS015","BITS021","BITS024","BITS026","BITS027","BITS028","BITS030")
for (x in patientsHCW18){
  filename <- paste("/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/derivatives/fmriprep-20.2.3/fmriprep/sub-", x,"/ses-s1/func/sub-", x, "_ses-s1_task-gonogo_acq-spiralio_run-0_desc-confounds_timeseries.tsv", sep="")
  confounds <- read.delim(filename)
  average <- mean(na.omit(as.numeric(confounds$framewise_displacement)))
  meanpatientsHCW18 <- rbind(meanpatientsHCW18, c(x, average))
}
write.table(meanpatientsHCW18,"meanpatientsHCW18.txt",sep="\t")

meanpatientsHDW18 <- c()
patientsHDW18 <- list("BITS014","BITS015","BITS021","BITS024","BITS026","BITS027","BITS028","BITS030")
for (x in patientsHDW18){
  filename <- paste("/oak/stanford/groups/leanew1/SHARED_DATASETS/private/BITS/data/derivatives/fmriprep-20.2.3/fmriprep/sub-", x,"/ses-s1/func/sub-", x, "_ses-s1_task-gonogo_acq-spiralio_run-0_desc-confounds_timeseries.tsv", sep="")
  confounds <- read.delim(filename)
  average <- mean(na.omit(as.numeric(confounds$framewise_displacement)))
  meanpatientsHDW18 <- rbind(meanpatientsHDW18, c(x, average))
}
write.table(meanpatientsHDW18,"meanpatientsHDW18.txt",sep="\t")