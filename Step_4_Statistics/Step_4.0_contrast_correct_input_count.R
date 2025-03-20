# Load necessary libraries
library(dplyr)

# Set the folder path where the files are located
folder_path <- "allegati/TaskPerformance/TaskPerformance/"

# Get a list of all the files that match the pattern
file_list <- list.files(path = folder_path, pattern = "sub-.*_ses-BL_task-gonogo_acq-sb_dir-pe1_run-00_events_fixed.tsv", full.names = TRUE)

# Initialize an empty data frame to store the counts for each patient ID
summary_counts <- data.frame()

# Loop through each file in the list
for (file in file_list) {
  # Extract patient ID from the filename
  patient_id <- sub("sub-(.*)_ses-BL_task-gonogo_acq-sb_dir-pe1_run-00_events_fixed.tsv", "\\1", basename(file))
  
  # Load the data
  data <- read.delim(file, header = TRUE, sep = "\t")
  
  # Count the number of occurrences of each trial type
  counts <- table(data$trial_type)
  
  # Ensure all trial types are represented
  trial_types <- c("cGo", "iGo", "cNoGo", "iNoGo")
  counts <- counts[trial_types]
  counts[is.na(counts)] <- 0
  
  # Add the total count of events
  counts <- c(counts, Total = sum(counts))
  
  # Add the counts to the summary data frame
  summary_counts <- rbind(summary_counts, setNames(as.list(counts), c(trial_types, "Total")))
  rownames(summary_counts)[nrow(summary_counts)] <- patient_id
}

# Transpose the summary data frame
transposed_summary_counts <- t(summary_counts)

# Optionally, write the summary tables to CSV files
write.csv(summary_counts, file = "summary_counts_by_patient.csv", row.names = TRUE)
write.csv(transposed_summary_counts, file = "transposed_summary_counts_by_patient.csv", row.names = TRUE)
