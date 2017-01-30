# 準確率的可精進方向
# 把titanic的177筆遺漏值Age填補回去
# 分類模型決策樹與森林決策樹，調整參數
# 換分類器...支持向量機、神經網絡....
# mice 套件 遺漏值處理

library(dplyr)
library(magrittr)
#沒有存活答案的資料集
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