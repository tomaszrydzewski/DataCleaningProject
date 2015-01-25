# Test set 

features <- read.table("./projectfiles/features.txt")
names(features) <- c("FeatureID","FeatureName")

clean_names<- gsub("\\)","",features$FeatureName) 
clean_names<- gsub("\\(","",clean_names) 
clean_names<- gsub("-","",clean_names) 
clean_names<- gsub("mean","Mean",clean_names)
clean_names<- gsub("std","STD",clean_names)
clean_names<- gsub("\\,","",clean_names)
features$FeatureName <- clean_names



activity_labels <- read.table("./projectfiles/activity_labels.txt")
names(activity_labels) <- c("ActivityID","ActivityName")

x_test <- read.table("./projectfiles/test/X_test.txt")
names(x_test) <-features$FeatureName

y_test <- read.table("./projectfiles/test/y_test.txt")
names(y_test) <- c("SubjectID")
  
subject_test <- read.table("./projectfiles/test/subject_test.txt")
names(subject_test) <- c("ActivityID")


## Add the activity names to the data table i.e. merge x with y
x_test$ActivityID <-y_test$SubjectID
x_test$SubjectID <-subject_test$ActivityID

## Merge the y_test with the label names
x_test_merged <- merge(x_test,activity_labels,by.x="ActivityID",by.y="ActivityID",all=FALSE)


## Training set 

x_train <- read.table("./projectfiles/train/X_train.txt")
names(x_train) <-features$FeatureName

y_train <- read.table("./projectfiles/train/y_train.txt")
names(y_train) <- c("SubjectID")

subject_train <- read.table("./projectfiles/train/subject_train.txt")
names(subject_train) <- c("ActivityID")


## Add the activity names to the data table i.e. merge x with y
x_train$ActivityID <-y_train$SubjectID
x_train$SubjectID <-subject_train$ActivityID

## Merge the y_test with the label names
x_train_merged <- merge(x_train,activity_labels,by.x="ActivityID",by.y="ActivityID",all=FALSE)

#merge the training data and the test data together
tidy_data<-rbind(x_test_merged,x_train_merged)

## Get the column names that have teh mean or std in the name
Column_names <- names(tidy_data)
Column_names <- Column_names[grep("Mean|STD",Column_names)]


Column_names <- c("SubjectID","ActivityName",Column_names)

# Get the columns for 
tidy_data_FINAL<-tidy_data[,Column_names]

final= aggregate(tidy_data_FINAL, by=list(carb=mtcars$carb, am=mtcars$am), mean)

aggdata <-aggregate(tidy_data_FINAL[,], by=list(tidy_data_FINAL$ActivityName,tidy_data_FINAL$SubjectID),FUN=mean, na.rm=TRUE)
aggdata$ActivityName <- aggdata$Group.1
aggdata$SubjectID <- aggdata$Group.2
aggdata<-aggdata[,3:90]

write.table(aggdata, file = "dataexport.txt", row.name=FALSE)




