# gettingandcleaningdata
gettingandcleaningdata
1.Merges the training and the test sets to create one data set
Reading the contents in provided UCI HAR Data Files and Folder
```{r}
library(dplyr)
getwd()
list.files()
```

Reading contents of the UCI HAR Folder
Codebook to create.txt is the copy of "feature_info.txt" (which will be used to create the final codebook)
```{r}
list.files("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset")
```

Reading contents of the "train" folder and sub-folder
Sub-folder Inertial Signals contain readings from accelerometer and gyroscope sensor for movements in all the 3 Dimensions.
```{r}
list.files("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/train")
list.files("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/train/Inertial Signals")
```

Reading contents of the "test" sub-folder
Sub-folder Inertial Signals contain readings from accelerometer and gyroscope sensor for movements in 3D
```{r}
list.files("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/test")
list.files("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/test/Inertial Signals")
```

Reading text data to data frame
```{r}
X_train<- read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/train/X_train.txt", header = FALSE)
Y_train<- read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/train/y_train.txt", header = FALSE)
X_test<- read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/test/X_test.txt", header = FALSE)
Y_test<- read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/test/y_test.txt", header = FALSE)
S_train<- read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
S_test<- read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
```

Combining the training and test data by rows
```{r}
X<- rbind(X_train, X_test)
Y<- rbind(Y_train, Y_test)
S<- rbind(S_train, S_test)
```

2.Extracts only the measurements on the mean and standard deviation for each measurement.
Reading the features table and giving then friendly name
```{r}
features<-read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/features.txt")
head(features)
names(features)<- c('ID', "Name")
```

Extracting mean and standard deviation from each measurement
```{r}
extract_features<- grep("mean|std", features$Name)
X<- X[, extract_features]
dim(X)
```

3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names.
Reading Activity labels and assigning friendly names
```{r}
activity<- read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/activity_labels.txt")
head(activity)
names(activity)<- c('activity_id', 'activity_name')
Y[, 1]<- activity[Y[, 1],2]
names(Y)<- "activity"
dim(S)
names(S)<- "subject"
```

Combining the three tables and writing it in the work directory in text format
```{r}
tidy_data<- cbind(S, Y, X)
names(tidy_data)
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)
```

5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject
```{r}
tidy_data_new<- tidy_data[, 3:dim(tidy_data)[2]]
write.table(tidy_data_new, file = "tidy_data_new.txt", row.names = FALSE)
tidy_data_average<- aggregate(tidy_data_new, list(tidy_data$subject, tidy_data$activity), mean)
names(tidy_data_average)[1] <- "subject"
names(tidy_data_average)[2] <- "activity"
write.table(tidy_data_average, file = "tidy_data_average.txt", row.names = FALSE)
