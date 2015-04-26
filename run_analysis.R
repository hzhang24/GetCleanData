### Step1. Merges the training and the test sets to create one data set.
setwd("~/RData/L3 CleaningData/UCI HAR Dataset")

#read both training and testing data, and merge into one date set
trainx <- read.table("./train/X_train.txt")
dim(trainx) #[1] 7352  561
head(trainx)
trainy <- read.table("./train/y_train.txt")
dim(trainy) #[1] 7352  1
head(trainy)
table(trainy)
trainsubject <- read.table("./train/subject_train.txt")
dim(trainsubject) #[1] 7352  1
head(trainsubject)

testx <- read.table("./test/X_test.txt")
dim(testx) #[1] 2947  561
head(testx)
testy <- read.table("./test/y_test.txt")
dim(testy) #[1] 2947    1
head(testy)
table(testy)
testsubject <- read.table("./test/subject_test.txt")
dim(testsubject) #[1] 2947    1
head(testsubject)

joinx <- rbind(trainx, testx)
dim(joinx) # [1] 10299   561
joiny <- rbind(trainy, testy)
dim(joiny) # [1] 10299     1
joinsubject <- rbind(trainsubject, testsubject)
dim(joinsubject) # [1] 10299     1

### step 2. Extracts only the measurements on the mean and 
### standard deviation for each measurement.

features <- read.table("features.txt")
dim(features) # 561   2
head(features, 5)
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2]) #mean and std indices
length(meanStdIndices) # 66
meanStdIndices
joinx <- joinx[, meanStdIndices]
dim(joinx) # [1] 10299    66

names(joinx) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(joinx) <- gsub("mean", "Mean", names(joinx)) # capitalize M
names(joinx) <- gsub("std", "Std", names(joinx)) # capitalize S
names(joinx) <- gsub("-", "", names(joinx)) # remove "-" in column names 


# Step3. Uses descriptive activity names to name the activities in 
# the data set
activity <- read.table("activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joiny[, 1], 2]
joiny[, 1] <- activityLabel
names(joiny) <- "activity"

# Step4. Appropriately labels the data set with descriptive activity names.
names(joinsubject) <- "subject"
cleanedData <- cbind(joinsubject, joiny, joinx)
dim(cleanedData) # [1] 10299    68
write.table(cleanedData, "merged_data.txt") # write out the 1st dataset

# Step5. Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject. 
subjectLen <- length(table(joinsubject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
        for(j in 1:activityLen) {
                result[row, 1] <- sort(unique(joinsubject)[, 1])[i]
                result[row, 2] <- activity[j, 2]
                bool1 <- i == cleanedData$subject
                bool2 <- activity[j, 2] == cleanedData$activity
                result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
                row <- row + 1
        }
}
head(result)
write.table(result, "data_with_means.txt") # write out the 2nd dataset

# data <- read.table("data_with_means.txt")
# data[1:12, 1:3]
