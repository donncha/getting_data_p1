Code Book
=========

The `averages.csv` file consists of 4 variables as follows:

 - `subject_id` : the id of the subject who wore the accelerometer
 - `activity`		: the activity being undertaken while the accelerometer was being worn (a factor with 6 levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
 - `variable`		: the variable being measured by the accelerometer
 - `mean`				: the average measurement of the variable for a particular subject and activity

Method
======
Having downloaded and expanded the UCI HAR Dataset, the features file was read, and the _interesting features_ were recorded as the ids of those features whose name contained either "mean" or "std".

The __Training__ accelerometer data was read as a series of fixed width (16 character) columns, and all columns which were not in the _interesting features_ were discarded. This remaining data was then combined with the corresponding subject and activity data to produce a combined data set.

The above steps were repeated for the __Test__ accelerometer dataset, and the two dataset's were combined to produce a single dataset containing all the accelerometer observations for all subjects and activities.

The activity column was converted to a factor using the activity labels, and the data was then melted by subject and activity to produce a tidy data set with one variable measurement per row. This was then saved to the `mean_and_std_obvs.csv` file.

The final step was to use the `ddply` function to split the measurements into groups by a combination of subject, activity and variable being measured, calculate the average of the resulting groups, and then recombine into the final dataset, which was then written to file as `averages.csv`.


