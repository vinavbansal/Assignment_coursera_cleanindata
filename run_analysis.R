library(dplyr)

##creating datset of trainings, reading training tables xtrain & ytrain & subjecttrain
xtrain=read.table(file.path(pathdata,"train", "X_train.txt"),col.names = features[,2])
ytrain=read.table(file.path(pathdata,"train", "y_train.txt"),col.names = "code")
sub_train=read.table(file.path(pathdata,"train","subject_train.txt"),col.names = "subject")

#Now reading the test table
xtest=read.table(file.path(pathdata,"test", "X_test.txt"),col.names = features[,2] )
ytest=read.table(file.path(pathdata,"test", "y_test.txt"),col.names = "code")
sub_test=read.table(file.path(pathdata,"test","subject_test.txt"),col.names = "subject")

##Read the features data
features=read.table(file.path(pathdata, "features.txt"),col.names = c("n","functions"))

##Read the activity labels data
activityLabels=read.table(file.path(pathdata, "activity_labels.txt"),col.names = c("code", "activity"))

##Objective1: Merges the training and test sets to create one dataset
mrg_x <- rbind(xtrain, xtest)
mrg_y <- rbind(ytrain, ytest)
mrg_sub <- rbind(sub_train, sub_test)
mrg_x_y_sub <- cbind(mrg_sub, mrg_y, mrg_x)

##Objective2: Extracts only the measurements on the mean & standard deviation for each measurement
tidydataset <- mrg_x_y_sub %>% select(subject, code, contains("mean"), contains("std"))

##Objective3: Uses descriptive activity names to name the activities in the dataset
tidydataset$code <- activityLabels[tidydataset$code, 2]

##Objective4: Approprately lables the datasets with descriptive variable names
names(tidydataset)[2] = "activity"
names(tidydataset)<-gsub("Acc", "Accelerometer", names(tidydataset))
names(tidydataset)<-gsub("Gyro", "Gyroscope", names(tidydataset))
names(tidydataset)<-gsub("BodyBody", "Body", names(tidydataset))
names(tidydataset)<-gsub("Mag", "Magnitude", names(tidydataset))
names(tidydataset)<-gsub("^t", "Time", names(tidydataset))
names(tidydataset)<-gsub("^f", "Frequency", names(tidydataset))
names(tidydataset)<-gsub("tBody", "TimeBody", names(tidydataset))
names(tidydataset)<-gsub("-mean()", "Mean", names(tidydataset), ignore.case = TRUE)
names(tidydataset)<-gsub("-std()", "STD", names(tidydataset), ignore.case = TRUE)
names(tidydataset)<-gsub("-freq()", "Frequency", names(tidydataset), ignore.case = TRUE)
names(tidydataset)<-gsub("angle", "Angle", names(tidydataset))
names(tidydataset)<-gsub("gravity", "Gravity", names(tidydataset))

##Objective5: create tideyset
tidySet <- tidydataset %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(tidySet, "TidyDataSetAvg.txt", row.name=FALSE)