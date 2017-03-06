## Getting and Cleaning Data Project
## by: Johnson Lim (@scjlim)
## Date: 6th March, 2017

# Loading the plyr library (really handy!)
library(plyr)



# Step 1: Merging two sets - training set + test set, into a single set
#######################################################################

x_train <- read.table("train/X_train.txt") # loading data (training)
y_train <- read.table("train/y_train.txt") # loading labels (training)
subject_train <- read.table("train/subject_train.txt") # loading subject data (training) 

x_test <- read.table("test/X_test.txt") # loading data (test)
y_test <- read.table("test/y_test.txt") # loading labels (test)
subject_test <- read.table("test/subject_test.txt") # loading subject data (test) 

# Merging operation using rbind()

x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)



# Step 2: Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################################

# Loading the feature file
features <- read.table("features.txt")

# using regular expression, to obtain columns that ends with either mean() or std() in their names
mean_and_sd_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subsetting the desired columns on combined data
x_data <- x_data[, mean_and_sd_features]

# correct the column names on combined data
names(x_data) <- features[mean_and_sd_features, 2]



# Step 3: Use descriptive activity names to name the activities in the data set
###############################################################################

# loading activity labels
activities <- read.table("activity_labels.txt")

# replacing label values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]


# assigning column label
names(y_data) <- "activity"


# Step 4: Appropriately label the data set with descriptive variable names
##########################################################################


# assigning column label
names(subject_data) <- "subject"

# merge all data, in orders of subject, activity and sensor data
all_data <- cbind(subject_data, y_data, x_data)



# Step 5: Create a second, independent tidy data set with the 
# average of each variable for each activity and each subject
#############################################################

# A function is defined for calculating column means from 3rd column onwards (with values of mean and SD)
avg <- function(x) colMeans(x[, 3:68])

# using ddply to execute function according to subject followed by activity
averaged_data <- ddply(all_data, c("subject", "activity"), avg )

# Output results to a .txt file, as per requirement
write.table(averages_data, "averaged_data.txt", row.name=FALSE)


### End of Code.

