

# read activity labels, name the columns: activity_id, activity_name
actLabels <- read.table(file="UCI HAR Dataset/activity_labels.txt", 
                        header=F, sep=" ",
                        col.names=c("activity_id", "activity_name"))

# read feature labels, name the columns: feature_id (position), feature (name)
# size: 561 x 2
featLabels <- read.table(file="UCI HAR Dataset/features.txt", 
                         header=F, sep=" ", col.names=c("feture_id", "feature"))


# read training data set (7352 x 561 data frame)
# columns named using feature labels (by name not id)
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names=featLabels[,2])


# read lables for the training set, name the single column: activity_id
# size is: 7352 x 1
yTrain <- read.table(file="UCI HAR Dataset/train/y_train.txt",
                     header=F, col.names=c("activity_id"))

# read subject data for training set (not used)
xTainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                           col.names=c("subject_id"), header=F)

# merge it all for training data

# merge activity labels and the training result (yTrain)
yTrain <- merge(actLabels, yTrain, by.x="activity_id")

# and bind to training data dim: 7352 x 563
trainData <- cbind(yTrain, xTrain)

# bind subject data
trainData <- cbind(xTainSubject, trainData)


#####################################################################
# all of the above repeated for test data
#####################################################################
xTestTrain <- read.table("UCI HAR Dataset/test/X_test.txt", col.names=featLabels[,2])

yTestTrain <- read.table(file="UCI HAR Dataset/test/y_test.txt",
                     header=F, col.names=c("activity_id"))

xTestTainSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", 
                           col.names=c("subject_id"), header=F)

yTestTrain <- merge(actLabels, yTestTrain, by.x="activity_id")

testTrainData <- cbind(yTestTrain, xTestTrain)

testTrainData <-cbind(xTestTainSubject, testTrainData)

# merge test and training data (append rows)
allData <- rbind(trainData, testTrainData)

# get only mean and standard deviation, keep activity label
finalData <- allData[,c(1,2,3, grep("*std*", names(allData)), grep("*mean*", names(allData)))]







