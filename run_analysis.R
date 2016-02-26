You should create one R script called run_analysis.R that does the following.

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Set working directory with Unzipped files
setwd("~/R/Data Sets/UCI HAR Dataset")

## Read in the Data from the files in folder
features <- read.table('./features.txt', header=FALSE); #importing features.txt
activityType <- read.table('./activity_labels.txt', header=FALSE); #Import activity labels
subjectTrain <- read.table('./train/subject_train.txt',header=FALSE); #imports subject_train.txt
xTrain <- read.table('./train/x_train.txt',header=FALSE); #imports x_train.txt
yTrain <- read.table('./train/y_train.txt',header=FALSE); #imports y_train.txt

## Assign the column names to the imported data from above
colnames(activityType) <- c('activityId','activityType');
colnames(subjectTrain) <- "subjectId";
colnames(xTrain) <- features[,2]; 
colnames(yTrain) <- "activityId";

#Create the final Train data set from merging xTrain, yTrain, subjectTrain
trainData <- cbind(xTrain, yTrain, subjectTrain)

# Read in the new test data
subjectTest <- read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt
xTest <- read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
yTest <- read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt

# Assign column names to the test data imported above
colnames(subjectTest) <- "subjectId";
colnames(xTest) <- features[,2]; 
colnames(yTest) <- "activityId";

# Creates the final test set by merging the xTest, yTest and subjectTest data
testData <- cbind(xTest, yTest, subjectTest);

# Combines train and test data to create a final data set called ThaOneData
ThaOneData <- rbind(trainData,testData);

# Creates a vector for the column names from the ThaOneData , which will be used
# to select the desired mean() & stddev() columns
colNames  <- colnames(ThaOneData); 

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# Creates a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others
logicalVector <- (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));

# Subset ThaOneDatatable based on the logicalVector to keep only desired columns
ThaOneData <- ThaOneData [logicalVector==TRUE];

# 3. Use descriptive activity names to name the activities in the data set

# Merge the ThaOneData set with the acitivityType table to include descriptive activity names
ThaOneData <- merge(ThaOneData ,activityType,by='activityId',all.x=TRUE);

# Updating the colNames vector to include the new column names after merge
colNames  <- colnames(ThaOneData ); 

# 4. Appropriately label the data set with descriptive activity names. 

# Cleaning up the variable names to better naming conventions in columns
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Reassigning the new descriptive column names to ThaOneData set
colnames(ThaOneData) = colNames;

## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Create a new table, NeoNoActivityType without the activityType column
NeoNoActivityType  <- ThaOneData[,names(ThaOneData) != 'activityType'];

# Summarizing the ThaOneData NoActivityType table to include just the mean of each variable for each activity and each subject
TidyData <- aggregate(NeoNoActivityType[,names(NeoNoActivityType) != c('activityId','subjectId')],by=list(activityId=NeoNoActivityType$activityId,subjectId = NeoNoActivityType$subjectId),mean);

# Merging the tidyData with activityType to include descriptive acitvity names
TidyData <- merge(TidyData,activityType,by='activityId',all.x=TRUE);

# Export the tidyData set 
write.table(TidyData, './TidyData.txt',row.names=FALSE,sep='\t');