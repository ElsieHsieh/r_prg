url = "https://storage.googleapis.com/2017_ithome_ironman/data/kaggle_titanic_train.csv"
titanic <- read.csv(url)
titanic <- titanic[complete.cases(titanic), ] #取完整的資料筆數

# Embarked 有兩個空值，以 S 填補
titanic$Embarked <- as.character(titanic$Embarked)
titanic$Embarked[titanic$Embarked == ""] <- "S"
titanic$Embarked <- factor(titanic$Embarked)

titanic$Survived <- factor(titanic$Survived)
n <- nrow(titanic)
set.seed(80) #為了讓洗牌的sample一致，不然每次洗牌結果會不一樣
shuffled_titanic <- titanic[sample(n), ] 
#洗牌，sample是隨機抽樣的意思，抽完不放回，所以抽全部等於把全部的順序弄散
#分割訓練/測試樣本
train_indices <- 1:round(0.7 * n)
train <- shuffled_titanic[train_indices, ]
test_indices <- (round(0.7 * n) + 1):n
test <- shuffled_titanic[test_indices, ]

library(rpart)
#分類模型
#把要預測的y放在~的左邊，而~右邊放要用來預測的x變數們
tree_fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")

#預測是生還死，跟test本身的survived去比對
#用test資料集，以及設定指定欄位
prediction <- predict(tree_fit, test[, c("Pclass", "Sex", "Age", "SibSp", 
                                         "Parch", "Fare", "Embarked")], type = "class")
#把實際的放在列，預測放在欄
confusion_matrix <- table(test$Survived, prediction)
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
accuracy


#隨機森林模型是決策樹的加強版
library(randomForest)
#要把目標變數先轉成factor <- line 4
Forest_fit <- randomForest(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked , data = train, ntree = 200)

Forest_prediction <- predict(Forest_fit, newdata = test[, c("Pclass", "Sex", "Age", "SibSp", "Parch", "Fare", "Embarked")])
Forest_confusion_matrix <- table(test$Survived, Forest_prediction)
Forest_accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
Forest_accuracy


#沒有存活答案的資料集
library(dplyr)
library(magrittr)
url <- "https://storage.googleapis.com/py_ds_basic/kaggle_titanic_test.csv"
to_predict <- read.csv(url)
summary(to_predict)

#把missing的fare value填補
mean_fare <- mean(to_predict$Fare,na.rm=TRUE)

to_predict$Fare[is.na(to_predict$Fare)] <- mean_fare
summary(to_predict$Fare)

#na.rm=TRUE 把NA值移除
#round()取整數
mean_age_by_Pclass <- to_predict %>%
  group_by(Pclass) %>%
  summarise(mean_age = round(mean(Age,na.rm=TRUE)))

#分出三種階級中age是NA的筆數

filter_1 <- is.na(to_predict$Age) & to_predict$Pclass == 1
filter_2 <- is.na(to_predict$Age) & to_predict$Pclass == 2
filter_3 <- is.na(to_predict$Age) & to_predict$Pclass == 3

to_predict[filter_1, ]$Age <- 41
to_predict[filter_2, ]$Age <- 29
to_predict[filter_3, ]$Age <- 24

# Summary after imputation
summary(to_predict)

predicted <- predict(Forest_fit, newdata = to_predict[, c("Pclass", "Sex", "Age", "SibSp", "Parch", "Fare", "Embarked")])

to_submit <- data.frame(to_predict[, "PassengerId"], predicted)
#to_submit <- data.frame(PassengerId=to_predict$PassengerId, Survived=predicted)

names(to_submit) <- c("PassengerId", "Survived")
head(to_submit, n = 10)

write.csv(to_submit,file="to_be_submitted.csv",row.names = FALSE)