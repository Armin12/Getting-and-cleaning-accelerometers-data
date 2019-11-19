
#1. Merges the training and the test sets to create one data set.

#Read training data (X_train) and their labels (y_train)
X_train<-read.delim("X_train.txt",header = FALSE)
y_train<-read.delim("y_train.txt",header = FALSE)

#Read test data (X_test) and their labels (y_test)
X_test<-read.delim("X_test.txt",header = FALSE)
y_test<-read.delim("y_test.txt",header = FALSE)

#Explore the training data
typeof(X_train)
class(X_train)
names(X_train)
dim(X_train)

#Explore the test data
typeof(X_test)
class(X_test)
names(X_test)
dim(X_test)

#This function, called cleaner, converts a single row of X (e.g. X_train or X_test)
#and converts it into a character class. It then replaces double spaces "  "
#with single space " " to make a more uniform data. Then it splits the text (character data)
#by the space between the values. At the end the obtained characters are transformed
#into numeric values. The first value is NA which is not part of the extracted data. So, I remove it by
#taking the [2:562] which is 561 feature in total.
cleaner<-function(rinput,X){
  as.numeric(strsplit(gsub("  "," ",as.character(X[rinput,]),), " ")[[1]])[2:562]
}

#The above cleaner function was applied to every row in the X_train and X_test.
#and then the result was transformed into a matrix with every column represent a feature (variable)
#ans every row was a sample (data point).
#Xtrain: matrix representation of X_train
#Xtest: matrix representation of X_test
Xtrain<-t(sapply(1:7352 , function(x) cleaner(x,X_train)))
Xtest<-t(sapply(1:2947, function(x) cleaner(x,X_test)))


#X_train and X_test were concatenated into DATA 
#y_train and y_test were concatenated into LABELS
DATA<-rbind(Xtrain,Xtest)
dim(DATA)
LABEL<-rbind(y_train,y_test)
dim(LABEL)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.

#Read the features.txt into feature data frame
#It includes names of all the features with its number at the begining
features<-read.delim("features.txt",header = FALSE)

#FEATURES is features with values presented as character 
FEATURES<-sapply(1:561, function(rinput) as.character(features[rinput,1]))

#meanstdfeatures: index of features with the measurements on the mean and standard deviation are selected
#It searches through FEATURES to find those with one of mean, Mean, std, or Std in their names
meanstdfeatures<-union(grep("[Mm]ean",FEATURES),grep("[Ss]td",FEATURES))

#features whose index are presented in meanstdfeatures
FEATURES[unlist(meanstdfeatures)]

#Extracting part of the DATA corresponding to those features and its dimension
DATA[,unlist(meanstdfeatures)]
dim(DATA[,unlist(meanstdfeatures)])

#3. Uses descriptive activity names to name the activities in the data set

#Read file "activity_labels.txt" and save it in activity_labels
activity_labels<-read.delim("activity_labels.txt",header = FALSE)

#ACTIVITY_LABELS is the character form of activity_labels with the number at their
#begining is removed using gsub function
ACTIVITY_LABELS<-sapply(1:6, function(x) as.character(activity_labels[x,1]))
ACTIVITY_LABELS<-gsub("^[0-9] ","",ACTIVITY_LABELS)

#This function, called namer, takes a label of an activity in the LABEL variable
#and gives its corresponding name
namer<-function(x){ACTIVITY_LABELS[LABEL[x,1]]}

#Function namer was applied to all the recordings (samples) and NAME_LABEL
#was generated. So, NAME_LABEL is the same as LABEL but with labels presented
#as names instead of numbers labeling.
NAME_LABEL<-sapply(1:dim(LABEL)[1],function(x) namer(x))

#4. Appropriately labels the data set with descriptive variable names.

#DATA_FRAME is the data frame representation of DATA
DATA_FRAME<-as.data.frame(DATA)

#The names given to the columns of this data frame are the same as FEATURES
#but with the numbers at their begining has been removed.
names(DATA_FRAME)<-gsub("(^[0-9][0-9][0-9] )|(^[0-9][0-9] )|(^[0-9] )","",FEATURES)

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Read the subject data and save them in subject_train and subject_test

subject_train<-read.delim("subject_train.txt",header = FALSE)
subject_test<-read.delim("subject_test.txt",header = FALSE)

#Concatenate subject_train and subject_test into subject and transform it
#into character class
subject<-rbind(subject_train,subject_test)
subject<-as.character(subject[,1])
dim(subject)

#AVE_ACTIVITY_SUBJECT is a tidy data set matrix with the average of each variable 
#for each activity and each subject 
AVE_ACTIVITY_SUBJECT<-matrix(, nrow = 180, ncol = 561)
i=1
for (a in unique(NAME_LABEL))
{
  for (b in unique(subject))
    {
    AVE_ACTIVITY_SUBJECT[i,]<-colMeans(DATA[NAME_LABEL==a & subject==b,])
    i=i+1
  }
  
}

#AVE_ACTIVITY_SUBJECT_DF is the data frame representation of AVE_ACTIVITY_SUBJECT
#with specified names
AVE_ACTIVITY_SUBJECT_DF<-as.data.frame(AVE_ACTIVITY_SUBJECT)
names(AVE_ACTIVITY_SUBJECT_DF)<-gsub("(^[0-9][0-9][0-9] )|(^[0-9][0-9] )|(^[0-9] )","",FEATURES)

write.table(AVE_ACTIVITY_SUBJECT_DF,file="AVE_ACTIVITY_SUBJECT_DF.txt",row.name=FALSE)
