#Codebook for Getting and Cleaning Data
#####Sunjay Myneni

##Introduction

#####The script run_analysis.R performs the 5 steps described in the course project's definition.

  1. First, all the similar data is merged using the rbind() function. By similar, we address those files having the same number of columns and referring to the same entities.
  2. Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt.
  3. As activity data is addressed with values 1:6, we take the activity names and IDs from activity_labels.txt and they are substituted in the dataset.
  4. On the whole dataset, those columns with vague column names are corrected.
  5. Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows). The output file is called averages_data.txt, and uploaded to this repository.

  ##Transformations

  1. Datasets was initially loaded by Test and Train folder. Each of these were further cleaned into test and train sets with required columns. 
  2. The data sets were further cleaned up by labeling the require columns and extracting the required columns in testData and trainData.
  3. ThaOneData variable was used for merging everything in one dataset.
  4. Create a logical vector function to extract all the columns and data instances with mean, standard deviation, and other descriptive variables. 
  5. Relabeled the column names to reflect which parameter's mean and standard deviation were represented in each column.
  6. NeoNoActivityType was labeled to create the cleaner Datset with ThaOneData set and removing the activityID.
  5. An average was added per group of subject, activity, and feature with the aggregate function.
  7. The dataset is then written to Tidy.txt file.

## Variables
  * xTrain, yTrain, xTest, yTest,subjectTrain, subjectTest are the variables for the files downloaded from source. 
  * testData, trainData variables that are the data frames with the indexed columns
  * ThaOneData is the merged data that is the combination of both test and train data frames. 
  * NeoNoActivityType is the new data set of merged data without the activityId.
  * TidyData is the variable used to extract the data required to make the Tidy data set. 
  
## Data
######Copied over from the README.txt file from zip
 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws
  