install.packages("magrittr") # only needed the first time you use it
install.packages("dplyr")    # alternative installation of the %>%
library(magrittr) # need to run every time you start R and want to use %>%
library(dplyr)


Xtrain <- read.table("C:/R/UCI HAR Dataset/train/X_train.txt")
Xtest <- read.table("C:/R/UCI HAR Dataset/test/X_test.txt")
Ytrain <- read.table("C:/R/UCI HAR Dataset/train/Y_train.txt")
Ytest <- read.table("C:/R/UCI HAR Dataset/test/Y_test.txt")
SubTrain <- read.table("c:/R/UCI HAR Dataset/train/subject_train.txt")
SubTest <- read.table("c:/R/UCI HAR Dataset/test/subject_test.txt")
feat <- read.table("C:/R/UCI HAR Dataset/features.txt")
ActivityLabels <- read.table("C:/R/UCI HAR Dataset/activity_labels.txt")

Xtotal <- rbind(Xtrain, Xtest)
Ytotal <- rbind(Ytrain, Ytest)
SubTotal <- rbind(SubTrain, SubTest)
SelectedVar <- feat[grep("mean\\(\\)|std\\(\\)",feat[,2]),]
Xtotal <- Xtotal[,SelectedVar[,1]]

colnames(Ytotal) <- "activity"
ActivityLabels <- Ytotal[,-1]
colnames(Xtotal) <- feat[SelectedVar[,1],2]
colnames(SubTotal) <- "subject"
Ytotal$ActivityLabels <- factor(Ytotal$activity, labels = as.character(ActivityLabels[,2]))


total <- cbind(Xtotal, ActivityLabels, SubTotal)
totalmean <- total %>% group_by(ActivityLabels, subject)%>% summarize_each(list(mean))
write.table(totalmean, file = "C:/R/UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)
total <- cbind(Xtotal, activitylabel, SubTotal)

