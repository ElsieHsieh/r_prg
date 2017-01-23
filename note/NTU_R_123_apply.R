#如果有很多For迴圈要執行可以用apply

#for loop counting means for cars variables

result <- rep(NA,times=11)

for(i in 1:length(mtcars)){
  result[i] <- mean(mtcars[,i])
}
names(result) <- names(mtcars)

result