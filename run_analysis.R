#set working directory to the repository directory
#the data to work with is provided inside the repository
setwd(".")


#get test datasets
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")


#get training datasets
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")


#combine test and training to get final datasets
subject_final<-rbind(subject_test,subject_train)
x_final<-rbind(x_test,x_train)
y_final<-rbind(y_test,y_train)


#setting column names 
colnames(subject_final)<-"Subject"
colnames(y_final)<-"Activity.id"
features<-read.table("./UCI HAR Dataset/features.txt")
colnames(features)<-c("Feature.id","Feature.name")
colnames(x_final)<-features$Feature.name


#binding independent parts to create data set
tidy_dataset<-cbind(subject_final,y_final,x_final)

#selecting the columns containing the mean and the std only
tidy_dataset.selected<-grep("-mean\\(\\)|-std\\(\\)", colnames(tidy_dataset))
tidy_dataset<-tidy_dataset[,c(1,2,tidy_dataset.selected)]

#setting activities labels
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
colnames(activity_labels)<-c("Activity.id","Activity.name")
tidy_dataset<-merge(tidy_dataset, activity_labels, by="Activity.id")

#writing dataset to file
write.table(tidy_dataset, file = "./TidyData.csv", sep = " ", row.names = FALSE, col.names = TRUE)
