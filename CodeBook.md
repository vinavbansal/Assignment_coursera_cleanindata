The run_analysis.R script performs the data anaylsis once zip file is downloaded & unzipped in the directory.
Below 5 steps required as described in the course project’s definition.

1. Assign each data to variables

      a) features <- features.txt : 561 rows, 2 columns  :: 
        The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

      b) activities <- activity_labels.txt : 6 rows, 2 columns :: 
        List of activities performed when the corresponding measurements were taken and its codes (labels)

      c) sub_test <- test/subject_test.txt : 2947 rows, 1 column :: 
        contains test data of 9/30 volunteer test subjects being observed

      d) xtest <- test/X_test.txt : 2947 rows, 561 columns  :: 
        contains recorded features test data

      e) ytest <- test/y_test.txt : 2947 rows, 1 columns :: 
        contains test data of activities’code labels

      f) sub_train <- test/subject_train.txt : 7352 rows, 1 column :: 
        contains train data of 21/30 volunteer subjects being observed

      g) xtrain <- test/X_train.txt : 7352 rows, 561 columns :: 
        contains recorded features train data

      h) ytrain <- test/y_train.txt : 7352 rows, 1 columns :: 
        contains train data of activities’code labels

2. Merges the training and the test sets to create one data set

      a) mrg_x (10299 rows, 561 columns) is created by merging xtrain and xtest using rbind() function

      b) mrg_y (10299 rows, 1 column) is created by merging ytrain and ytest using rbind() function

      c) mrg_sub (10299 rows, 1 column) is created by merging sub_train and sub_test using rbind() function

      d) mrg_x_y_sub (10299 rows, 563 column) is created by merging mrg_sub, mrg_yand mrg_x using cbind() function

3. Extracts only the measurements on the mean and standard deviation for each measurement
  
      a) tidydataset (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

4. Uses descriptive activity names to name the activities in the data set
  
      a) Entire numbers in code column of the tidydataset replaced with corresponding activity taken from second column of the  activities variable

5. Appropriately labels the data set with descriptive variable names

      a) code column in tidydataset renamed into activities

      b) All Acc in column’s name replaced by Accelerometer

      c) All Gyro in column’s name replaced by Gyroscope

      d) All BodyBody in column’s name replaced by Body

      e) All Mag in column’s name replaced by Magnitude

      f) All start with character f in column’s name replaced by Frequency

      g) All start with character t in column’s name replaced by Time

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidySet (180 rows, 88 columns) is created by sumarizing tidydataset taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export tidySet into TidyDataSetAvg.txt file.
