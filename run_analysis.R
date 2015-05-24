library(tidyr)  #load tidyr package
library(dplyr)  #load dplyr package

testdat <- read.table("UCI HAR Dataset/test/X_test.txt")              #read test data from test folder
traindat <- read.table("UCI HAR Dataset/train/X_train.txt")           #read training data from train folder
testsubject <- read.table("UCI HAR Dataset/test/subject_test.txt")    #read test subjects from test folder  
trainsubject <- read.table("UCI HAR Dataset/train/subject_train.txt") #read training subjects from train folder
testactivity <- read.table("UCI HAR Dataset/test/y_test.txt")         #read activity performed by test subjects from test folder
trainactivity <- read.table("UCI HAR Dataset/train/y_train.txt")      #read activity performed by training subject from trian folder

combinedat <- rbind(traindat, testdat)                  #combine test and training data row wise(they have same dimensions)
combinesubject <- rbind(trainsubject, testsubject)      #combine test and training subject id's (they have same dimensions)
combineactivity <- rbind(trainactivity, testactivity)   #combine test and training activity data(they have same dimensions)

activitynamesdf <- read.table("UCI HAR Dataset/activity_labels.txt")   #read activity names from 'activity_labels.txt' file in main folder
activitynames <- activitynamesdf$V2                                    #extract the chrachter vector of activity names
activitynames <- tolower(activitynames)                                #convert the char vector to lowercase charachters
activitynames <- gsub(pattern = "\\b([a-z])", replacement = "\\U\\1", activitynames, perl = TRUE)   #change first letter to capital letter

combineactivity$V1 <- as.factor(combineactivity$V1)   #convert combineactivity names to factor variable from integer
levels(combineactivity$V1) <- activitynames           #change labels from numbers to charachter labels (ex "5" to "Standing")

features <- read.table("UCI HAR Dataset/features.txt")   #read the column names of 'combineactivity' from 'features.txt' file
featurevar <- features$V2                                #extract the charachter vecotr of column names from table
featurevar <- as.character(featurevar)                   #convert to charachter from factor

meanvarpos <- grep("mean()", featurevar, fixed = TRUE)   #find column names index hence column varables related to 'mean()'
stdvarpos <- grep("std()", featurevar, fixed = TRUE)     #find column names index hence column varables related to 'mean()'
requiredcol <- c(meanvarpos, stdvarpos)                  #combine both the index vectors 

varnames <- featurevar[requiredcol]                      #extract the required variable names from varable names vector
varnames <- gsub("-", "", varnames)                      #remove all the symbols( "()", "-") and make the variable more descriptive
varnames <- gsub("[()]", "", varnames)                   #for e.x changing 't' to 'time', 'mag' to 'magnitude'
varnames <- gsub("^t", "time", varnames)
varnames <- gsub("^f", "frequency", varnames)
varnames <- gsub("X", "xaxis", varnames)
varnames <- gsub("Y", "yaxis", varnames)
varnames <- gsub("Z", "zaxis", varnames)
varnames <- gsub("Acc", "accelerometer", varnames)
varnames <- gsub("Gyro", "gyroscope", varnames)
varnames <- gsub("Mag", "magnitude", varnames)
varnames <- gsub("std", "standarddeviation", varnames)
varnames <- tolower(varnames)
varnames <- gsub("bodybody", "body", varnames)             #remove repeated words

requireddat <- combinedat[, requiredcol]                          #extrract rquired columns from combined data
finaldat <- cbind(combinesubject, combineactivity, requireddat)   #combine subject, activity and the respective sensor data
colnames <- c("subject", "activity", varnames)                    #name the column names appropriately
names(finaldat) <- colnames
finaldat$subject <- as.factor(finaldat$subject)                   #change the subject variable to factor

#Apply the tidy data principles and functoins from dplyr package to calculate average of each varable for each subject and each activity
#dimension of the new table 180 rows and 68 columns 
  
tidydata <- finaldat %>% gather(measurements, value, -subject, -activity) %>% group_by(subject, activity, measurements) %>% 
summarise(mean(value)) %>% spread(measurements, "mean(value)")

write.table(tidydata, "tidydata.txt", row.names = FALSE)         #write the tidy data in the form of table to a text file
