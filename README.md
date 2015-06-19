#Summarize and Tidy-Up Human Activity Data

This R script takes a large dataset of measurements taken from a smartphone gyroscope on human activities including walking, standing, etc. 

To run the script, you can just source("run_analysis.R") and the script will download, unzip, and proceed to read and summarize the data. 

If you already have the dataset downloaded and unzipped and do not want to re-download it, set the working directory to the "UCI HAR Dataset/" directory, copy "run_analysis.R" into "UCI HAR Dataset/", and comment out the following lines:

```
fileURL <- ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
download.file(fileURL, destfile = "activity.zip", method="curl")
unzip("activity.zip")
```

Then just source("run_analysis.R"). 

The variables in the final tidied dataset as well as rationale, etc. are explained in `codebook.md` in this repository.