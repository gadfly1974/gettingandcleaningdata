## Import data from txt files in working directory

subject_test <- read.table("subject_test.txt", quote="\"")
subject_train <- read.table("subject_train.txt", quote="\"")
X_test <- read.table("X_test.txt", quote="\"")
X_train <- read.table("X_train.txt", quote="\"")
y_test <- read.table("y_test.txt", quote="\"")
y_train <- read.table("y_train.txt", quote="\"")
features <- read.table("features.txt", quote="\"")

## Create and assign 6 descriptive activity names to the activity lists

activitylabels <- c("walking", "walkingupstairs", "walkingdownstairs", "sitting", "standing", "laying")
activitylist_test <- c()

for (i in 1:2947) {
  activitylist_test[i] <- c(activitylabels[y_test$V1[i]])
}

activitylist_train <- c()

for (i in 1:7352) {
  activitylist_train[i] <- c(activitylabels[y_train$V1[i]])
}

## Create descriptive column names with all lower case letters and without special characters

listoffeatures <- c()

for (i in 1:561) {
  listoffeatures[i] <- c(as.character(features$V2[i]))
}

listt <- sub("t", "time", listoffeatures)
listf <- sub("f", "frequency", listt)
listacc <- sub("Acc", "accelerometer", listf)
listmean <- sub("Mean", "mean", listacc)
listjerk <- sub("Jerk", "jerk", listmean)
listgravity <- sub("Gravity", "gravity", listjerk)
listgyro <- sub("Gyro", "gyroscope", listgravity)
listmag <- sub("Mag", "magnitude", listgyro)
listfreq <- sub("Freq", "frequency", listmag)
listbodybody <- sub("BodyBody", "bodybody", listfreq)
listbody <- sub("Body", "body", listbodybody)
listmeanx <- sub("-mean()-X", "meanxaxis", listbody, fixed=TRUE)
listmeany <- sub("-mean()-Y", "meanyaxis", listmeanx, fixed=TRUE)
listmeanz <- sub("-mean()-Z", "meanzaxis",listmeany, fixed=TRUE)
listmean <- sub("-mean()", "mean", listmeanz, fixed=TRUE)
listmeanfreqx <- sub("-meanfrequency()-X", "meanfrequencyxaxis", listmean, fixed=TRUE)
listmeanfreqy <- sub("-meanfrequency()-Y", "meanfrequencyyaxis", listmeanfreqx, fixed=TRUE)
listmeanfreqz <- sub("-meanfrequency()-Z", "meanfrequencyzaxis", listmeanfreqy, fixed=TRUE)
listmeanfreq <- sub("-meanfrequency()", "meanfrequency", listmeanfreqz, fixed=TRUE)
listmeanaccelerometer <- sub("angle(timebodyaccelerometermean,gravity)", "meanaccelerometerangle", listmeanfreq, fixed=TRUE)
listmeanaccelerometerjerk <- sub("angle(timebodyaccelerometerjerkmean),gravityMean)", "meanaccelerometerjerkangle", listmeanaccelerometer, fixed=TRUE)
listgyroscopemean <- sub("angle(timebodygyroscopemean,gravityMean)", "meangyroscopeangle", listmeanaccelerometerjerk, fixed=TRUE)
listgyroscopejerkmean <- sub("angle(timebodygyroscopejerkmean,gravityMean)", "meangyroscopejerkangle", listgyroscopemean, fixed=TRUE)
listgravityxmean <- sub("angle(X,gravitimeymean)", "meananglexgravity", listgyroscopejerkmean, fixed=TRUE)
listgravityymean <- sub("angle(Y,gravitimeymean)", "meanangleygravity", listgravityxmean, fixed=TRUE)
listgravityzmean <- sub("angle(Z,gravitimeymean)", "meananglezgravity", listgravityymean, fixed=TRUE)
liststdx <- sub("-std()-X", "standarddeviationxaxis", listgravityzmean, fixed=TRUE)
liststdy <- sub("-std()-Y", "standarddeviationyaxis", liststdx, fixed=TRUE)
liststdz <- sub("-std()-Z", "standarddeviationzaxis", liststdy, fixed=TRUE)
liststd <- sub("-std()", "standarddeviation", liststdz, fixed=TRUE)
listxaxis <- sub("()-X", "xaxis", liststd, fixed=TRUE)
listyaxis <- sub("()-Y", "yaxis", listxaxis, fixed=TRUE)
listzaxis <- sub("()-Z", "zaxis", listyaxis, fixed=TRUE)
listnoparen <- sub("()", "", listzaxis, fixed=TRUE)
listfinal <- sub("-stimed", "", listnoparen, fixed=TRUE)


## Select only mean and standard deviation columns

meancolumns <- grep("mean", listoffeatures, value=FALSE)
stdcolumns <- grep("std", listoffeatures, value=FALSE)

meanstdcolumns <- c(meancolumns, stdcolumns)

finalcolnames <- listfinal[meanstdcolumns]

## Create a data frame with descriptive activity and column names

X_test_train <- rbind(X_test, X_train)

MergedMeanSTD <- X_test_train[, meanstdcolumns]
   
for (i in 1:79) {
  colnames(MergedMeanSTD)[i] <- finalcolnames[i]
}

volunteerid <- rbind(subject_test, subject_train)

activity <- c(activitylist_test, activitylist_train)

final.df <- cbind(volunteerid, activity, MergedMeanSTD)

colnames(final.df)[1] <- "volunteerid"

## Open the data.table package for efficient data analysis

library("data.table", lib.loc="C:/Users/Dad/Dropbox/R/R/R-3.0.3/library")

## Convert data frame to data table

final.dt <- as.data.table(final.df)

## Set keys for final analysis

keycols <- c("activity", "volunteerid")
setkeyv(final.dt, keycols)

## Create final solution data table

solution <- final.dt[, lapply(.SD,mean), by = key(final.dt)]

## Export tab delimited file to working directory

PathUpload <- paste(getwd(),"/mydata.txt",sep="") 
write.table(solution, PathUpload, sep="\t")