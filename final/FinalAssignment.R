library(ggplot2)
library(dplyr)
library(scales)
library(mice)
library(rpart)
library(randomForest)
library(plotly)

train <- read.csv('kaggle_titanic_train.csv')
test  <- read.csv('kaggle_titanic_test.csv')
titanic  <- bind_rows(train, test)

summary(train)

#觀察登船港口遺漏資料
#發現他們的Fare都是80元，Passenger Class是1
embark_missing <- titanic %>%
  filter(Embarked == "")
head(embark_missing)

#過濾掉Embarked遺漏值
embark_fare <- titanic %>%
  filter(Embarked != "")
#以登船港口和乘客等級分別繪製票價盒鬚圖
#發現票價80元與C港口高階乘客票價中位數差不多，故將Embarked兩個遺漏值指派為C
ggplot(embark_fare, aes(x = Embarked, y = Fare, fill = factor(Pclass))) +
  geom_boxplot()
titanic$Embarked[titanic$Embarked == ""] <- "C"

#挑出遺漏Fare的資料來觀看
#Pclass == '3', Embarked == 's' 觀察符合這些條件的票價情況
fare_missing <- subset(titanic,is.na(titanic$Fare))

third_s <- titanic[titanic$Pclass == '3' & titanic$Embarked == 'S', ]
fare_density <- ggplot(third_s , aes(x = Fare)) + 
  geom_density(fill = '#2fb8be',alpha=0.5) + 
  ggtitle("")
ggplotly(fare_density)
#這些條件下Fare最多落在8左右，與其中位數差不多，故以此填補Fare遺漏值
summary(third_s$Fare)
titanic$Fare[is.na(titanic$Fare)] <- median(third_s$Fare, na.rm = TRUE)

mice_data <- titanic[, !names(titanic) %in% c('PassengerId','Name','Ticket','Cabin','Survived')]
mice_result <- mice(mice_data, method='rf',seed = 9487) 
mice_output <- complete(mice_result)
titanic$Age <- mice_output$Age

#建模型
titanic$Survived <- factor(titanic$Survived)
titanic$Embarked <- factor(titanic$Embarked)
train <- titanic[1:891,]
test <- titanic[892:1309,]

set.seed(87)

Forest_fit <- randomForest(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked , data = train, ntree = 200)
Forest_prediction <- predict(Forest_fit, newdata = test[, c("Pclass", "Sex", "Age", "SibSp", "Parch", "Fare", "Embarked")])

#tree_fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data = train, method = "class")
#predicted <- predict(tree_fit, newdata = test[, c("Pclass", "Sex", "Age", "SibSp", "Parch", "Fare", "Embarked")],type = "class")
# prediction <- predict(tree_fit, test, type = "class")

to_submit <- data.frame(test[, "PassengerId"], Forest_prediction)
#to_submit <- data.frame(PassengerId=to_predict$PassengerId, Survived=predicted)
names(to_submit) <- c("PassengerId", "Survived")
head(to_submit, n = 10)

write.csv(to_submit,file="to_be_submitted_rf.csv",row.names = FALSE)


library(rpart.plot) 
prp(tree_fit,         # 模型
    faclen=0,           # 呈現的變數不要縮寫
    fallen.leaves=TRUE, # 讓樹枝以垂直方式呈現
    shadow.col="gray",  # 最下面的節點塗上陰影
    # number of correct classifications / number of observations in that node
    extra=2)  
