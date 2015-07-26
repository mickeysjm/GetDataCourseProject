### Load necessary packages
library(dplyr)
library(reshape2)

### Load data
# get feature names mapping
feature.info = read.table("features.txt",stringsAsFactors = FALSE, 
                          col.names = c("id","featureNames"))
feature.name = feature.info$featureNames
# get activity names mapping
activity.info = read.table("activity_labels.txt", stringsAsFactors = FALSE,
                           col.names = c("id","activityNames"))
activity.name = activity.info$activityNames
# get training and testing data, labels:activity / subjects: person id 
train.features <- read.table("./train/X_train.txt")
train.labels <- read.table("./train/y_train.txt")
train.subjects <- read.table("./train/subject_train.txt")

test.features <- read.table("./test/X_test.txt")
test.labels <- read.table("./test/y_test.txt")
test.subjects <- read.table("./test/subject_test.txt")

### Workflow: getting tidy data
# Step-1: Merges the training and the test sets to create one data set.
mergedData <- rbind(train.features, test.features)
mergedlabels <- rbind(train.labels, test.labels)
mergedsubjects <- rbind(train.subjects, test.subjects)

# Step-2: Extracts only the measurements on the mean and standard deviation for 
#         each measurement.
colnames(mergedData) <- feature.name
a <- grepl(".*-mean|.*-std", colnames(mergedData))
b <- !grepl(".*-meanFreq", colnames(mergedData))
data <- mergedData[, a&b]
measurements <- feature.name[a&b]

# Step-3: Uses descriptive activity names to name the activities in the data set
data$activity <- seq(along=mergedlabels)
tmp <- mergedlabels$V1
n = length(tmp)
for (i in 1:n ) {  data$activity[i] =  activity.name[tmp[i]]  }
data$activity <- factor(data$activity)
data$person_id <- factor(mergedsubjects$V1)

# Step-4: Appropriately labels the data set with descriptive variable names.
# This part is done in pervious steps, see below,
# colnames(data)

# Step-5: Create a second, independent tidy data set with the average of 
# each variable for each activity and each subject.
dataMelt <- melt(data, id = c("activity","person_id"), measure.vars = measurements)
tidyData <- dcast(dataMelt, activity + person_id ~ variable, mean)

### Output result
# tidy data: 180=30*6 rows, 66 colunms 
write.table(tidyData,"tidyData.txt", row.name = FALSE)
