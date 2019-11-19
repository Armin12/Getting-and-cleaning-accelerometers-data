1. Merges the training and the test sets to create one data set.

Training data ("X_train") and their labels ("y_train"), test data ("X_test") and their labels ("y_test") were read from .txt files with the same names.

Function, called "cleaner", converts a single row of X (e.g. "X_train" or "X_test") into a character class. It then replaces double spaces "  " with single space " " to make a more uniform data. Then it splits the text (character data) by the space between the values. At the end the obtained characters are transformed into numeric values. The first value is NA which is not part of the extracted data. So, it is removed by taking [2:562] which is 561 feature in total. The above cleaner function was applied to every row in the "X_train" and "X_test" and the result was transformed into a matrix with every column represent a feature (variable) and every row was a sample (data point).

"Xtrain": matrix representation of "X_train"
"Xtest": matrix representation of "X_test"

"X_train" and "X_test" were concatenated into "DATA" 
"y_train" and "y_test" were concatenated into "LABELS"

2. Extracts only the measurements on the mean and standard deviation for each measurement.

The "features.txt" was read and saved into "feature" data frame. It includes names of all the features with its number at the begining.

"FEATURES": transformed "features" into character 

"meanstdfeatures": index of features with the measurements on the mean and standard deviation are selected. It searches through "FEATURES" to find those with one of mean, Mean, std, or Std in their names. Features whose index are presented in the "meanstdfeatures" are extracted. Then, part of the "DATA" corresponding to those features were extracted.

3. Uses descriptive activity names to name the activities in the data set

File "activity_labels.txt" was read and saved in "activity_labels" variable.

"ACTIVITY_LABELS": character form of "activity_labels" with the number at their begining is removed using gsub function.

Function called "namer", takes a label of an activity in the "LABEL" variable and gives its corresponding name. This function was applied to all the recordings (samples) and was saved in  "NAME_LABEL". So, "NAME_LABEL" is the same as "LABEL" but with labels presented as names instead of numbers labeling.

4. Appropriately labels the data set with descriptive variable names.

"DATA_FRAME": the data frame representation of "DATA"

The names given to the columns of this data frame are the same as "FEATURES" but with the numbers at their begining has been removed.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The subject data were read and saved in "subject_train" and "subject_test"

"subject_train" and "subject_test" were Concatenated into "subject" and were transformed into character class.

"AVE_ACTIVITY_SUBJECT" is a tidy data set matrix with the average of each variable for each activity and each subject

"AVE_ACTIVITY_SUBJECT_DF" is the data frame representation of "AVE_ACTIVITY_SUBJECT" with specified names
