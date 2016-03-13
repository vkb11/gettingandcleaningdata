library(dplyr)
getwd()
list.files()
list.files("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset")
list.files("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/train")
list.files("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/train/Inertial Signals")
list.files("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/test")
list.files("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/test/Inertial Signals")
X_train<- read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/train/X_train.txt", header = FALSE)
Y_train<- read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/train/y_train.txt", header = FALSE)
X_test<- read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/test/X_test.txt", header = FALSE)
Y_test<- read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/test/y_test.txt", header = FALSE)
S_train<- read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
S_test<- read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
X<- rbind(X_train, X_test)
Y<- rbind(Y_train, Y_test)
S<- rbind(S_train, S_test)
features<-read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/features.txt")
head(features)
names(features)<- c('ID', "Name")
extract_features<- grep("mean|std", features$Name)
X<- X[, extract_features]
dim(X)
activity<- read.table("C:/Users/vkumar16/Desktop/R Data_Assg/Project_DCM/Data Cleaning/UCI HAR Dataset/activity_labels.txt")
head(activity)
names(activity)<- c('activity_id', 'activity_name')
Y[, 1]<- activity[Y[, 1],2]
names(Y)<- "activity"
dim(S)
names(S)<- "subject"
tidy_data<- cbind(S, Y, X)
names(tidy_data)
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)
tidy_data_new<- tidy_data[, 3:dim(tidy_data)[2]]
write.table(tidy_data_new, file = "tidy_data_new.txt", row.names = FALSE)
tidy_data_average<- aggregate(tidy_data_new, list(tidy_data$subject, tidy_data$activity), mean)
names(tidy_data_average)[1] <- "subject"
names(tidy_data_average)[2] <- "activity"
write.table(tidy_data_average, file = "tidy_data_average.txt", row.names = FALSE)
