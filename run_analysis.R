# run_analysis.R

setwd("C:/R_annam/GCD_proj_1/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals")


##

# - 1 - Merge the training and the test sets to create one data set.


# Read the training datasets given
setwd("C:/R_annam/GCD_proj_1/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Inertial Signals")

train_body_acc_x <- read.table("body_acc_x_train.txt")
train_body_acc_y <- read.table("body_acc_y_train.txt")
train_body_acc_z <- read.table("body_acc_z_train.txt")

train_body_gyro_x <- read.table("body_gyro_x_train.txt")
train_body_gyro_y <- read.table("body_gyro_y_train.txt")
train_body_gyro_z <- read.table("body_gyro_z_train.txt")

train_total_acc_x <- read.table("total_acc_x_train.txt")
train_total_acc_y <- read.table("total_acc_y_train.txt")
train_total_acc_z <- read.table("total_acc_z_train.txt")


# Read the test datasets given
setwd("C:/R_annam/GCD_proj_1/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/Inertial Signals")

test_body_acc_x <- read.table("body_acc_x_test.txt")
test_body_acc_y <- read.table("body_acc_y_test.txt")
test_body_acc_z <- read.table("body_acc_z_test.txt")

test_body_gyro_x <- read.table("body_gyro_x_test.txt")
test_body_gyro_y <- read.table("body_gyro_y_test.txt")
test_body_gyro_z <- read.table("body_gyro_z_test.txt")

test_total_acc_x <- read.table("total_acc_x_test.txt")
test_total_acc_y <- read.table("total_acc_y_test.txt")
test_total_acc_z <- read.table("total_acc_z_test.txt")

###

## 
# now merging data sets - training and test sets

# each table has 128 columns
body_acc_x <- rbind(test_body_acc_x,train_body_acc_x) 
body_acc_y <- rbind(test_body_acc_y,train_body_acc_y)
body_acc_z <- rbind(test_body_acc_z,train_body_acc_z)

body_gyro_x <- rbind(test_body_gyro_x,train_body_gyro_x)
body_gyro_y <- rbind(test_body_gyro_y,train_body_gyro_y)
body_gyro_z <- rbind(test_body_gyro_z,train_body_gyro_z)


# acceleration from acceslerometer X/Y/Z axis - 128 elements
total_acc_x <- rbind(test_total_acc_x,train_total_acc_x)
total_acc_y <- rbind(test_total_acc_y,train_total_acc_y)
total_acc_z <- rbind(test_total_acc_z,train_total_acc_z)

### mean of the measurements

mean_body_acc_x <- rowMeans(body_acc_x)
mean_body_acc_y <- rowMeans(body_acc_y)
mean_body_acc_z <- rowMeans(body_acc_z)

mean_body_gyro_x <- rowMeans(body_gyro_x)
mean_body_gyro_y <- rowMeans(body_gyro_y)
mean_body_gyro_z <- rowMeans(body_gyro_z)


# acceleration from acceslerometer X/Y/Z axis - 128 elements
mean_total_acc_x <- rowMeans(total_acc_x)
mean_total_acc_y <- rowMeans(total_acc_y)
mean_total_acc_z <- rowMeans(total_acc_z)


##

### std of the measurements

std_body_acc_x <- apply(body_acc_x,1,sd)
std_body_acc_y <- apply(body_acc_y,1,sd)
std_body_acc_z <- apply(body_acc_z,1,sd)

std_body_gyro_x <- apply(body_gyro_x,1,sd)
std_body_gyro_y <- apply(body_gyro_y,1,sd)
std_body_gyro_z <- apply(body_gyro_z,1,sd)


# acceleration from acceslerometer X/Y/Z axis - 128 elements
std_total_acc_x <- apply(total_acc_x,1,sd)
std_total_acc_y <- apply(total_acc_y,1,sd)
std_total_acc_z <- apply(total_acc_z,1,sd)

###


# set working directory and load required files 

# Read test datasets
setwd("C:/R_annam/GCD_proj_1/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test")

subject_test    <- read.table("subject_test.txt")
X_test          <- read.table("X_test.txt")
y_test          <- read.table("y_test.txt")


##
# Read training datasets
setwd("C:/R_annam/GCD_proj_1/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train")

subject_train <- read.table("subject_train.txt")
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")

##
# 1 - Merge the datasets
subject <- rbind(subject_train, subject_test) # each row identifies the subject
X <- rbind (X_train, X_test) # training/test set - with 561 features
y <- rbind(y_train, y_test) # training/test labels - activity label



# - 3 and 4
# preparing descriptive activity names
        index <- c(1:6)
        desc <- c("Walking","Walking Upstairs", "Walking Downstairs", "Sitting", 
                  "Standing", "Laying")
        activity <- data.frame(index, desc)
        
        y_desc <- activity$desc[y[,1]]
        
        names(subject)[names(subject)=="V1"] <- "subject"   
        
        
        # create clean dataset
        clean_data <- cbind(subject, y_desc,
                            mean_body_acc_x, 
                            mean_body_acc_y, 
                            mean_body_acc_z, 
                            
                            mean_body_gyro_x, 
                            mean_body_gyro_y, 
                            mean_body_gyro_z, 
                            
                            
                            mean_total_acc_x, 
                            mean_total_acc_y, 
                            mean_total_acc_z,
                            
                            std_body_acc_x, 
                            std_body_acc_y, 
                            std_body_acc_z, 
                            
                            std_body_gyro_x, 
                            std_body_gyro_y, 
                            std_body_gyro_z, 
                            
                            
                            std_total_acc_x, 
                            std_total_acc_y, 
                            std_total_acc_z 
                            
                            )
        
        
        names(clean_data)[names(clean_data)=="y_desc"] <- "activity_type" 


# - 5
# Creating second tidy dataset from the datastep 4.
# with average of each variable for each activity and each subject

        install.packages("doBy")
        library(doBy)
        
        clean_data2 <- summaryBy( mean_body_acc_x+mean_body_acc_y+mean_body_acc_z +
                                          mean_body_gyro_x +mean_body_gyro_y+mean_body_gyro_z +
                                                mean_total_acc_x+mean_total_acc_y+mean_total_acc_z
                                         ~activity_type+subject, 
                                 data=clean_data, FUN=c(mean))
        
        
write.table(clean_data2, file = "dataset2.txt", row.names = FALSE)

