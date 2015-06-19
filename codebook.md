# Activity Recognition Code Book
###Martin Bontrager
###18 June, 2015

This code book is the companion to the filtered, summarized, and labeled data set for human activity recognition. The raw data are available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). 

R code in the file `run_analysis.R` is for downloading, reading, cleaning, and summarizing the raw data. Available on github.com/mbontrager/activity_recognition.

To read the final "tidy" data set into R you might use the following command:

`tidyData <- read.csv("summarized_Activity_Data.txt")`

The original data from which this smaller summarized  data set is derived is described as follows (from the [project website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)):

##Original data description

>    Data Set Information:
>
>    The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
>
>    The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
>
>    Attribute Information:

>    For each record in the dataset it is provided:
>    - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
>    - Triaxial Angular velocity from the gyroscope.
>    - A 561-feature vector with time and frequency domain variables.
>    - Its activity label.
>    - An identifier of the subject who carried out the experiment.


# Operations on Raw Data

For this smaller dataset, the training and test datasets (561 variables measures on 20 and 10 subjects, respectively) were merged into one large dataset, and only fields including the mean and standard deviation were retained. This was done simply by retaining any variable with the strings "mean" or "std". Activity information was added in a human-readable format (e.g. "WALKING_UPSTAIRS") and subject information was added.

This yielded 10,299 observations on 88 variables including the subject and activity information. Subsequently, the mean value for all of the 86 measurement variables (each mean and std dev) for each subject and for each activity was calculated to produce the final dataset. A brief explanation of the measurement variables (again obtained with the raw data set) follows:

##Feature information from project `features_info.txt`

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
>
>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
>
>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
>
>These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
>
>tBodyAcc-XYZ  
>tGravityAcc-XYZ  
>tBodyAccJerk-XYZ  
>tBodyGyro-XYZ  
>tBodyGyroJerk-XYZ  
>tBodyAccMag  
>tGravityAccMag  
>tBodyAccJerkMag  
>tBodyGyroMag  
>tBodyGyroJerkMag  
>fBodyAcc-XYZ  
>fBodyAccJerk-XYZ  
>fBodyGyro-XYZ  
>fBodyAccMag  
>fBodyAccJerkMag  
>fBodyGyroMag  
>fBodyGyroJerkMag  
>  
>Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
>
>gravityMean
>tBodyAccMean
>tBodyAccJerkMean
>tBodyGyroMean
>tBodyGyroJerkMean

##Variables

The variables in the final dataset are:

subject - **Unique ID for the subject**  
activity - **Human-readable activity name**  
tBodyAcc.meanX  
tBodyAcc.meanY  
tBodyAcc.meanZ  
tBodyAcc.stdX  
tBodyAcc.stdY  
tBodyAcc.stdZ  
tGravityAcc.meanX  
tGravityAcc.meanY  
tGravityAcc.meanZ  
tGravityAcc.stdX  
tGravityAcc.stdY  
tGravityAcc.stdZ  
tBodyAccJerk.meanX  
tBodyAccJerk.meanY  
tBodyAccJerk.meanZ  
tBodyAccJerk.stdX  
tBodyAccJerk.stdY  
tBodyAccJerk.stdZ  
tBodyGyro.meanX  
tBodyGyro.meanY  
tBodyGyro.meanZ  
tBodyGyro.stdX  
tBodyGyro.stdY  
tBodyGyro.stdZ  
tBodyGyroJerk.meanX  
tBodyGyroJerk.meanY  
tBodyGyroJerk.meanZfBodyAcc.stdX  
fBodyAcc.stdY  
fBodyAcc.stdZ  
fBodyAcc.meanFreqX  
fBodyAcc.meanFreqY  
fBodyAcc.meanFreqZ  
fBodyAccJerk.meanX  
fBodyAccJerk.meanY  
fBodyAccJerk.meanZ  
fBodyAccJerk.stdX  
fBodyAccJerk.stdY  
fBodyAccJerk.stdZ  
fBodyAccJerk.meanFreqX  
fBodyAccJerk.meanFreqY  
fBodyAccJerk.meanFreqZ  
fBodyGyro.meanX  
fBodyGyro.meanY  
fBodyGyro.meanZ  
fBodyGyro.stdX  
fBodyGyro.stdY  
fBodyGyro.stdZ     
fBodyGyro.meanFreqX  
fBodyGyro.meanFreqY  
fBodyGyro.meanFreqZ  
fBodyAccMag.mean  
fBodyAccMag.std  
fBodyAccMag.meanFreq  
fBodyBodyAccJerkMag.mean  
fBodyBodyAccJerkMag.std  
fBodyBodyAccJerkMag.meanFreq  
fBodyBodyGyroMag.mean  
fBodyBodyGyroMag.std  
fBodyBodyGyroMag.meanFreq  
fBodyBodyGyroJerkMag.mean  
fBodyBodyGyroJerkMag.std  
fBodyBodyGyroJerkMag.meanFreq  
angle.tBodyAccMean.gravity  
angle.tBodyAccJerkMeangravityMean  
angle.tBodyGyroMean.gravityMean  
angle.tBodyGyroJerkMean.gravityMean  
angle.X.gravityMean  
angle.Y.gravityMean  
angle.Z.gravityMean  

##Summaries

Each of these "mean" and "std" values in the final data table are themselves the mean of the number of observations gathered from measurements on different activities and different subjects. The following table gives the number of observations per subject by activity that were used to generate the mean values in the final table. 

subject|WALKING|WALKING_UPSTAIRS|WALKING_DOWNSTAIRS|SITTING|STANDING|LAYING
---|---|---|---|---|---|---
1|95|53|49|47|53|50
g2|59|48|47|46|54|48
3|58|59|49|52|61|62
4|60|52|45|50|56|54
5|56|47|47|44|56|52
6|57|51|48|55|57|57
7|57|51|47|48|53|52
8|48|41|38|46|54|54
9|52|49|42|50|45|50
10|53|47|38|54|44|58
11|59|54|46|53|47|57
12|50|52|46|51|61|60
13|57|55|47|49|57|62
14|59|54|45|54|60|51
15|54|48|42|59|53|72
16|51|51|47|69|78|70
17|61|48|46|64|78|71
18|56|58|55|57|73|65
19|52|40|39|73|73|83
20|51|51|45|66|73|68
21|52|47|45|85|89|90
22|46|42|36|62|63|72
23|59|51|54|68|68|72
24|58|59|55|68|69|72
25|74|65|58|65|74|73
26|59|55|50|78|74|76
27|57|51|44|70|80|74
28|54|51|46|72|79|80
29|53|49|48|60|65|69
30|65|65|62|62|59|70 