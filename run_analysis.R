# Check if dependencies are installed and require them.
RequireOrInstall <- function(package) {
    suppressWarnings({
        if (!require(package,character.only=TRUE)) {
            installPackage <- readline(paste("Package",package,"not found. Install? (y for yes, otherwise for no): "))
            if (installPackage == "y") {
                install.packages(package)
            }
            require(package,character.only=TRUE)  
        }})
}

run_analysis <- function () {
RequireOrInstall("plyr")

# Step 1: Merge training and test sets to create one data set

# read training dataset
x_train <- read.table("./getData_proj_dataset/train/X_train.txt")
y_train <- read.table("./getData_proj_dataset/train/y_train.txt")
subject_train <- read.table("./getData_proj_dataset/train/subject_train.txt")

# read test dataset
x_test <- read.table("./getData_proj_dataset/test/X_test.txt")
y_test <- read.table("./getData_proj_dataset/test/y_test.txt")
subject_test <- read.table("./getData_proj_dataset/test/subject_test.txt")

# combine training and test datasets into one
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)


# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject

# 66 <- 68 columns but last two (activity & subject)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)
# Step 2: Extract only the measurements on the mean and standard deviation for each measurement
# x_data contains the measurements

feat <- read.table("./getData_proj_dataset/features.txt")

# get only columns with mean() or std() in their names
mean_and_std <- grep("-(mean|std)\\(\\)", feat[, 2])
x_data <- x_data[, mean_and_std]

# correct the column names
names(x_data) <- feat[mean_and_std, 2]

# Step 3: Use descriptive activity names to name the activities in the data set
# y_data contains the activities

# read activities
activities <- read.table("./getData_proj_dataset/activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"

# Step 4: Label the data set with descriptive variable names

# correct column name
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- data.frame()
all_data <- cbind(x_data, y_data, subject_data)

# Step 5: Create a second, independent tidy data set with the average of 
# each variable for each activity and each subject

tidy_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

# write out tidy_data.txt file
write.table(tidy_data, "./tidy_data.txt", row.name=FALSE)
}
