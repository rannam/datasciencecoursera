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

test_train_flag = as.factor(rep(1,length(train_body_acc_z$V1)))

train_body_acc_x <- cbind(train_body_acc_x,test_train_flag)
train_body_acc_y <- cbind(train_body_acc_y,test_train_flag)
train_body_acc_z <- cbind(train_body_acc_z,test_train_flag)

train_body_gyro_x <- cbind(train_body_gyro_x,test_train_flag)
train_body_gyro_y <- cbind(train_body_gyro_y,test_train_flag)
train_body_gyro_z <- cbind(train_body_gyro_z,test_train_flag)

train_total_acc_x <- cbind(train_total_acc_x,test_train_flag)
train_total_acc_y <- cbind(train_total_acc_y,test_train_flag)
train_total_acc_z <- cbind(train_total_acc_z,test_train_flag)


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

test_train_flag = as.factor(rep(2,length(test_body_acc_z$V1)))

test_body_acc_x <- cbind(test_body_acc_x,test_train_flag)
test_body_acc_y <- cbind(test_body_acc_y,test_train_flag)
test_body_acc_z <- cbind(test_body_acc_z,test_train_flag)

test_body_gyro_x <- cbind(test_body_gyro_x,test_train_flag)
test_body_gyro_y <- cbind(test_body_gyro_y,test_train_flag)
test_body_gyro_z <- cbind(test_body_gyro_z,test_train_flag)

test_total_acc_x <- cbind(test_total_acc_x,test_train_flag)
test_total_acc_y <- cbind(test_total_acc_y,test_train_flag)
test_total_acc_z <- cbind(test_total_acc_z,test_train_flag)




###

setwd("C:/R_annam/GCD_proj_1/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test")
subject_test <- read.table("subject_test.txt")
X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
test_train_flag = as.factor(rep(2,length(subject_test$V1)))

subject_test <- cbind(subject_test,test_train_flag)
X_test <- cbind(X_test, test_train_flag)
y_test <- cbind(y_test, test_train_flag)

##
setwd("C:/R_annam/GCD_proj_1/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train")
subject_train <- read.table("subject_train.txt")
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
test_train_flag = as.factor(rep(1,length(subject_train$V1)))

subject_train <- cbind(subject_train,test_train_flag)
X_train <- cbind(X_train, test_train_flag)
y_train <- cbind(y_train, test_train_flag)

##

subject <- rbind(subject_train, subject_test) # each row identifies the subject
X <- rbind (X_train, X_test) # training/test set - with 561 features
y <- rbind(y_train, y_test) # training/test labels - activity label


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


X1 <- X[,c(1:6, 562)]


index <- c(1:6)
desc <- c("Walking","Walking Upstairs", "Walking Downstairs", "Sitting", 
          "Standing", "Laying")
activity <- data.frame(index, desc)

y_desc <- activity$desc[y[,1]]
      
names(subject)[names(subject)=="V1"] <- "subject"   
names(subject)[names(subject)=="test_train_flag"] <- "subj_test_train_flag"  

tidy_data <- cbind(subject, X1, y_desc)       
tidy_data$subj_test_train_flag <- NULL       
tidy_data$test_train_flag <- NULL       
names(tidy_data)[names(tidy_data)=="V1"] <- "tBodyAcc_mean_X"   
names(tidy_data)[names(tidy_data)=="V2"] <- "tBodyAcc_mean_Y"   
names(tidy_data)[names(tidy_data)=="V3"] <- "tBodyAcc_mean_Z"   
names(tidy_data)[names(tidy_data)=="V4"] <- "tBodyAcc_std_X"   
names(tidy_data)[names(tidy_data)=="V5"] <- "tBodyAcc_std_Y"   
names(tidy_data)[names(tidy_data)=="V6"] <- "tBodyAcc_std_Z" 
names(tidy_data)[names(tidy_data)=="y_desc"] <- "activity_type" 


install.packages("doBy")
library(doBy)
tidy_data2 <- summaryBy(tBodyAcc_mean_X~activity_type+subject, 
                        data=tidy_data, FUN=c(mean))














