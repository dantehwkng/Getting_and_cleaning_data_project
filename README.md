
The script run_analysis.R performs the 5 steps described in the course project's definition.

First, the program installs the plyr library if needed. 

Then all the "X" training and test data, all the "y" training and test data, and all the "subject" training and test data is read in and then merged using the rbind() function. 
For the "X" data, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from features.txt.
The "y" data files contain the activity data, which is named with values 1:6, so the activity names and IDs are taken from activity_labels.txt and are used to descriptively label the dataset.
Over the whole dataset, columns with vague column names are corrected.
Finally, a new datset is generated containing all the average measurements for each subject along with activity type (180 rows in total, corresponding to 30 subjects * 6 activities). 

The tidy data is output to a file called "tidy_data.txt", which has been uploaded to the project submission page.

Variables
Data from the original downloaded files is stored in the variables x_train, y_train, x_test, y_test, subject_train and subject_test.
The training and test datasets are merged into the variables x_data, y_data and subject_data.
The "feat" variable contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std, a numeric vector used to extract the desired data.
The "activities" variable contains the correct names for the y_data dataset, which are appropriately applied to the column names. 
The variable "all_data" is one large dataset, merged from x_data, y_data and subject_datat.
Finally, tidy_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans().
