#要先標準化單位
# nstart 放初始中心點位置，一般擺放大於10次=跑10次收斂結果
#kmeans

iris_for_km <- select(iris,-Species)
head(iris_for_km)
km_fit <- kmeans(iris_for_km, nstart = 10, centers = 4)

par(mfrow = c(1, 2))
plot(x = iris$Sepal.Length, y = iris$Sepal.Width, col = iris$Species, main = "Labeled")
plot(x = iris$Sepal.Length, y = iris$Sepal.Width, col = km_fit$cluster, main = "K-Means", ylab = "")

#評估分群模型


# 找K 手肘點，用這個方式找適合的分群數
#先創一個空的變數，準備儲存每個ratio
ratio_vec <- rep(NA,times=20)
for(k in 1:length(ratio_vec)){
  #每跑一次要算kmeans的ratio
  set.seed(87)#給隨機種子
  km_fit_a <- kmeans(iris_for_km, centers = k, nstart = 10)
  ratio <- km_fit_a$tot.withinss/km_fit_a$totss
  ratio_vec[k] <- ratio #將結果依序填入不同位置
}
ratio_vec

par(mfrow=c(1,1))
plot(ratio_vec, type = "b", xlab = "k", main = "screeplot")
#2 or 3 下降幅度大 5也ok 非監督式 沒一定分成幾類最適當
#主成分分析 <- 要確定歸類為幾個主成分也會用這種方式去找