# download and unzip the raw data file
obtainRawData = function() {
	filename = 'getdata-projectfiles-UCI HAR Dataset.zip'
	if(!file.exists(filename)) {
		download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
									filename,
									method="curl")
	}
	unzip(filename)
}

# for a given set_type ('train' or 'test'), prepare a single
# data set containing all readings, plus the subject and activy data
combineDataSets = function(set_type, interestingColumns) {
  setwd(set_type)
  
  x_file = paste("X_",set_type,".txt", sep='')
  fixedWidths = vector(mode='integer', 561) + 16
  accelReadings = read.fwf(x_file, fixedWidths)
  accelReadings = accelReadings[,interestingColumns]
  
  y_file = paste("Y_",set_type,".txt", sep='')
  activities = read.fwf(y_file, 2)
  
  subject_file = paste("subject_",set_type,".txt", sep='')
  subjects = read.fwf(subject_file, 2)
  
  combined = data.table(cbind(subjects, activities, accelReadings))
  # some cleanup
  rm(accelReadings);rm(activities);rm(subjects);setwd('../')
  combined
}

produceTidyData = function() {
  setwd("./UCI HAR Dataset/")
  features = read.table("./features.txt", sep=' ', strip.white=T)
  activities = read.table("./activity_labels.txt", sep=' ', strip.white=T)
  interestingColumns = grep("mean|std", features$V2)
  
  # load the training and test data sets and combine them
  trainingSet = combineDataSets("train", interestingColumns)
  testSet = combineDataSets("test", interestingColumns)
  allReadings = rbind(trainingSet, testSet)
  setnames(allReadings, append(c("subject_id", "activity"), as.character(features$V2[interestingColumns])))
  allReadings$activity = factor(allReadings$activity, levels=activities$V1, labels=activities$V2)
  rm(trainingSet);
  rm(testSet)
  rm(features)
  rm(activities)
  
  tidyData = melt(allReadings, id.vars=c('subject_id', 'activity'))
  rm(allReadings)
  setwd("..")
  tidyData
}

library(data.table)
library(reshape2)
library(plyr)
tidy = produceTidyData()
write.csv(tidy, "mean_and_std_obs.csv", row.names=F)
means = ddply(tidy, .(subject_id, activity, variable), summarize, mean=mean(value))
write.csv(means, "averages.csv", row.names=F)
means