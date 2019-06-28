##creating datset of trainings, reading training tables xtrain & ytrain & subjecttrain
xtrain=read.table(file.path(pathdata,"train", "X_train.txt"),header = FALSE)
ytrain=read.table(file.path(pathdata,"train", "y_train.txt"),header = FALSE)
sub_train=read.table(file.path(pathdata,"train","subject_train.txt"),header = FALSE)

#Now reading the test table
xtest=read.table(file.path(pathdata,"test", "X_test.txt"),header = FALSE )
ytest=read.table(file.path(pathdata,"test", "y_test.txt"),header = FALSE)
sub_test=read.table(file.path(pathdata,"test","subject_test.txt"),header = FALSE)

##Read the features data
features=read.table(file.path(pathdata, "features.txt"),header = FALSE)

##Read the activity labels data
activityLabels=read.table(file.path(pathdata, "activity_labels.txt"),header = FALSE)

##Tagging the test & training data
colnames(xtrain) = features[,2]
colnames(ytrain) = "activityId"
colnames(sub_train) = "subjectId"

colnames(xtest) = features[,2]
colnames(ytest) = "activityId"
colnames(sub_test) = "subjectId"

colnames(activityLabels) <- c('activityId', 'activityType')

##Objective1: Merges the training and test sets to create one dataset
mrg_train = cbind(ytrain, sub_train, xtrain)
mrg_test = cbind(ytest, sub_test, xtest)
mrg_train_test = rbind(mrg_train, mrg_test)

##Objective2: Extracts only the measurements on the mean & standard deviation for each measurement
colNames = colnames(mrg_train_test)
mean_std = (grepl("activityId", colNames) | grepl("subjectId", colNames) | grepl("mean..", colNames)
            | grepl("std..", colNames))
subSetMean_Std <- mrg_train_test[ ,mean_std == TRUE]


##Objective3&4: Uses descriptive activity names to name the activities in the dataset & 
##Approprately lables the datasets with descriptive variable names
setActivityNames = merge(subSetMean_Std, activityLabels, by='activityId', all.x=TRUE)

##Objective5:Create tidy set
tidySet <- aggregate(. ~subjectId + activityId, setActivityNames, mean)
tidySet <- tidySet[order(tidySet$subjectId, tidySet$activityId),]


##writing it to the text file
write.table(tidySet, "tidydataset.txt", row.names=FALSE)
