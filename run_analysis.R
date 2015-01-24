#getwd()
#setwd("/Users/Anush/Desktop/R_WD/getdata")
library(dplyr)
library(data.table)
library(reshape2)

#read training and testing sets
testSet <- read.table("./test/X_test.txt")
trainSet <- read.table("./train/X_train.txt")

#read all other files
testLabel <- as.vector(as.matrix(read.table("./test/y_test.txt")))
trainLabel <- as.vector(as.matrix(read.table("./train/y_train.txt")))
features <- read.table("features.txt")
activLab <- tbl_df(read.table("activity_labels.txt"))
subjTest <- as.vector(as.matrix(read.table("./test/subject_test.txt")))
subjTrain <- as.vector(as.matrix(read.table("./train/subject_train.txt")))

#remove extra paranthesis in observation names
observ <- sub("\\()", "", as.character(features$V2))

#add names to activities and subject vectors
colnames(activLab) <- c("id", "activity")
colnames(subjTest) <- "subj"

#add a column with id and then merge with activLab to get activity based on the number
trainSet <- mutate(trainSet, id=trainLabel) %>%
  mutate(subj= subjTrain)
trainSet <- merge(activLab, trainSet, by="id", all = TRUE) %>%
  select(id, activity, subj, V1:V561)

testSet <- mutate(testSet, id=testLabel)%>%
  mutate(subj= subjTest)
testSet <- merge(activLab, testSet, by="id", all = TRUE)%>%
  select(id, activity, subj, V1:V561)

#set column names based on features
colnames(trainSet) <- c("id", "activity", "subj",observ)
colnames(testSet) <- c("id", "activity", "subj",observ)

#merge 2 sets
set <- tbl_df(rbind(testSet,trainSet))

#remove all variables except for working set
#rm(list=setdiff(ls(), "set"))

#subset data, get only only columns containing std or mean in names
# and exclude Freq patterns, group and melt to make a tidy data set
set <- set[,grepl("std|mean+[^Freq]|activity|subj",colnames(set))] %>%
       group_by (activity, subj) %>%
       summarise_each(funs(mean)) %>%
       melt(id.vars =c("subj", "activity"))

colnames(set)[3] <- "feature"

#round values to 4 decimal points
set$value <- round(set$value,4)

#save tidy data in a separate file
write.table(set, file = "tidy_dataset.txt", row.names = FALSE)