#非監督式學習 <- 資料裡面沒有答案，學習出來的結果沒辦法精準判斷是否對或錯

library(ggplot2)

temperature <- c(29, 28, 34, 31, 25, 29, 32, 31, 24, 33, 25, 31, 26, 30)
iced_tea_sales <- c(77, 62, 93, 84, 59, 64, 80, 75, 58, 91, 51, 73, 65, 84)
iced_tea_df <- data.frame(temperature, iced_tea_sales)

ggplot(iced_tea_df, aes(x = temperature, y = iced_tea_sales)) +
  geom_point() + 
  ggtitle("Temperature vs. Iced Tea Sales") +
  xlab("Temperature")+ylab("Sales") + geom_smooth(method = lm)

# 挑出與每個點距離差距總和最小的線出來呈現
# 梯度遞減

# lm() 參數第一個位置formula要指定哪個變數是y哪個變數是x

#因為要預測銷量所以把sales放前面
lm_fit <- lm(iced_tea_sales~temperature,data=iced_tea_df)
# lm_fit$coefficients 最常用

#predict
to_be_predict <- data.frame(temperature=30)
predicted_sales <- predict(lm_fit,newdata = to_be_predict)
#在30度時，銷售75.7杯 = (3.737885 * 30) - 36.361233  coefficients
to_be_predict <- cbind(to_be_predict,iced_tea_sales=predicted_sales)

#因為是根據模型去預測，所以一定落在線上面
ggplot(iced_tea_df, aes(x = temperature, y = iced_tea_sales)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) + 
  geom_point(data = to_be_predict, colour = "red", shape = 17, size = 3)

#評估指標RMSE 越低越好
y_hat <- predict(lm_fit, newdata = data.frame(temperature))

rmse <- (iced_tea_sales-y_hat)^2 %>%
  sum() %>%
  `/`(length(iced_tea_sales)) %>%
  sqrt()

#評估指標R-squared（愈接近 1 愈好）
summary(lm_fit)$r.squared

#建立模型
store_area <- c(10, 8, 8, 5, 7, 8, 7, 9, 6, 9)
dist_to_station <- c(80, 0, 200, 200, 300, 230, 40, 0, 330, 180)
monthly_sales <- c(469, 366, 371, 208, 246, 297, 363, 436, 198, 364)
bakery_df <- data.frame(store_area, dist_to_station, monthly_sales)

lm_fit2 <- lm(monthly_sales ~ store_area + dist_to_station , data = bakery_df)

#RMSE

y_hat2 <- predict(lm_fit2, newdata = bakery_df[,c("store_area","dist_to_station")])
rmse2 <- (monthly_sales - y_hat2)^2 %>%
  sum() %>%
  `/`(length(monthly_sales))%>%
  sqrt()