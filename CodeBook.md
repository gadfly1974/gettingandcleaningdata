### Code Book for Getting and Cleaning Data Course Project

#### UCI HAR Dataset downloaded here
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##### features.txt file
+ List of 561 different variables
##### subject_test.txt file
+ Volunteer ID, 1:30
##### subject_train.txt file
+ Volunteer ID, 1:30
##### X_test
+ 2947 observations of 561 variables
##### X_train
+ 7532 observations of 561 variables
##### y_test
+ 2947 observations of 1 variable
+ 6 different activities
##### y_train
+ 7532 observations of 1 variable
+ 6 different activities

##### Activity labels
1 walking
2 walkingupstairs
3 walking downstairs
4 sitting
5 standing
6 laying

#### Series of sub() functions to generate tidy variable names

#### grep() functions to select mean and standard deviation variable columns

#### Reduced to 79 mean and standard deviation measurements
1	timebodyaccelerometermeanxaxis
2	timebodyaccelerometermeanyaxis
3	timebodyaccelerometermeanzaxis
4	timegravityaccelerometermeanxaxis
5	timegravityaccelerometermeanyaxis
6	timegravityaccelerometermeanzaxis
7	timebodyaccelerometerjerkmeanxaxis
8	timebodyaccelerometerjerkmeanyaxis
9	timebodyaccelerometerjerkmeanzaxis
10	timebodygyroscopemeanxaxis
11	timebodygyroscopemeanyaxis
12	timebodygyroscopemeanzaxis
13	timebodygyroscopejerkmeanxaxis
14	timebodygyroscopejerkmeanyaxis
15	timebodygyroscopejerkmeanzaxis
16	timebodyaccelerometermagnitudemean
17	timegravityaccelerometermagnitudemean
18	timebodyaccelerometerjerkmagnitudemean
19	timebodygyroscopemagnitudemean
20	timebodygyroscopejerkmagnitudemean
21	frequencybodyaccelerometermeanxaxis
22	frequencybodyaccelerometermeanyaxis
23	frequencybodyaccelerometermeanzaxis
24	frequencybodyaccelerometermeanfrequencyxaxis
25	frequencybodyaccelerometermeanfrequencyyaxis
26	frequencybodyaccelerometermeanfrequencyzaxis
27	frequencybodyaccelerometerjerkmeanxaxis
28	frequencybodyaccelerometerjerkmeanyaxis
29	frequencybodyaccelerometerjerkmeanzaxis
30	frequencybodyaccelerometerjerkmeanfrequencyxaxis
31	frequencybodyaccelerometerjerkmeanfrequencyyaxis
32	frequencybodyaccelerometerjerkmeanfrequencyzaxis
33	frequencybodygyroscopemeanxaxis
34	frequencybodygyroscopemeanyaxis
35	frequencybodygyroscopemeanzaxis
36	frequencybodygyroscopemeanfrequencyxaxis
37	frequencybodygyroscopemeanfrequencyyaxis
38	frequencybodygyroscopemeanfrequencyzaxis
39	frequencybodyaccelerometermagnitudemean
40	frequencybodyaccelerometermagnitudemeanfrequency
41	frequencybodybodyaccelerometerjerkmagnitudemean
42	frequencybodybodyaccelerometerjerkmagnitudemeanfrequency
43	frequencybodybodygyroscopemagnitudemean
44	frequencybodybodygyroscopemagnitudemeanfrequency
45	frequencybodybodygyroscopejerkmagnitudemean
46	frequencybodybodygyroscopejerkmagnitudemeanfrequency
47	timebodyaccelerometerstandarddeviationxaxis
48	timebodyaccelerometerstandarddeviationyaxis
49	timebodyaccelerometerstandarddeviationzaxis
50	timegravityaccelerometerstandarddeviationxaxis
51	timegravityaccelerometerstandarddeviationyaxis
52	timegravityaccelerometerstandarddeviationzaxis
53	timebodyaccelerometerjerkstandarddeviationxaxis
54	timebodyaccelerometerjerkstandarddeviationyaxis
55	timebodyaccelerometerjerkstandarddeviationzaxis
56	timebodygyroscopestandarddeviationxaxis
57	timebodygyroscopestandarddeviationyaxis
58	timebodygyroscopestandarddeviationzaxis
59	timebodygyroscopejerkstandarddeviationxaxis
60	timebodygyroscopejerkstandarddeviationyaxis
61	timebodygyroscopejerkstandarddeviationzaxis
62	timebodyaccelerometermagnitudestandarddeviation
63	timegravityaccelerometermagnitudestandarddeviation
64	timebodyaccelerometerjerkmagnitudestandarddeviation
65	timebodygyroscopemagnitudestandarddeviation
66	timebodygyroscopejerkmagnitudestandarddeviation
67	frequencybodyaccelerometerxaxis
68	frequencybodyaccelerometeryaxis
69	frequencybodyaccelerometerzaxis
70	frequencybodyaccelerometerjerkxaxis
71	frequencybodyaccelerometerjerkyaxis
72	frequencybodyaccelerometerjerkzaxis
73	frequencybodygyroscopexaxis
74	frequencybodygyroscopeyaxis
75	frequencybodygyroscopezaxis
76	frequencybodyaccelerometermagnitude
77	frequencybodybodyaccelerometerjerkmagnitude
78	frequencybodybodygyroscopemagnitude
79	frequencybodybodygyroscopejerkmagnitude

#### cbind() to link all 10299 observations

#### rbind() to link all 30 volunteers to their observational data

#### final analysis calculates the average of each variable for each activity and each subject
```r
library("data.table", lib.loc="~/R/R/R-3.0.3/library")

final.dt <- as.data.table(final.df)

keycols <- c("activity", "volunteerid")
setkeyv(final.dt, keycols)

solution <- final.dt[, lapply(.SD,mean), by = key(final.dt)]
```

#### License:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

###### For more information about this dataset contact: 
activityrecognition@smartlab.ws

> Written with [StackEdit](https://stackedit.io/).