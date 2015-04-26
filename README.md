## This is a markdown file
File  : run_analysis.R

- Program first reads the Signals datasets, given for each measurement (all combinations of X, Y and Z with accelarator, gyro and total accelaration).
- Then merges the datasets from training and testing.
- Calculates the mean and std of the measurements.

- Then subject and features and activity type datasets are read (though we are not using the features dataset here for now)
- Subject and training and test data sets are merged.
- descriptive lables for activity are created.

- Then we finally create a clean dataset with the mean and std of the measurements for each subject and with activity type.

- Labels are adjusted to be readable.

- Finally we create another tidy dataset with average measurements for each subject and activity combination.


Code Book:
- Subject -Identifies the subject participated
- activity_type
- mean_body_acc_x

mean_body_gyro

