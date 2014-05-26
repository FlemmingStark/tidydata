require(reshape2)

setwd("~/Study/Coursera/Getting and Cleaning Data/tidydata")


subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")



subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")


subject_final<-rbind(subject_test,subject_train)
x_final<-rbind(x_test,x_train)
y_final<-rbind(y_test,y_train)

colnames(subject_final)<-"Subject"
colnames(y_final)<-"Activity.id"

features<-read.table("./UCI HAR Dataset/features.txt")
colnames(features)<-c("Feature.id","Feature.name")

colnames(x_final)<-features$Feature.name

tidy_dataset<-cbind(subject_final,y_final,x_final)

tidy_dataset.selected<-grep("-mean\\(\\)|-std\\(\\)", colnames(tidy_dataset))
tidy_dataset<-tidy_dataset[,c(1,2,tidy_dataset.selected)]

activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
colnames(activity_labels)<-c("Activity.id","Activity.name")
tidy_dataset<-merge(tidy_dataset, activity_labels, by="Activity.id")

write.table(tidy_dataset, file = "./TidyData.csv", sep = " ", row.names = FALSE, col.names = TRUE)
