library(ggplot2)
mtcars_col_names <- names(mtcars)

#回傳字串向量
for (mtcars_col_name in mtcars_col_names) {
  print(mtcars_col_name)
}
mtcars_col_name

#回傳數字
for (i in 1:length(mtcars_col_names)) {
  print(mtcars_col_names[i])
}
i

#外面那圈先固定不動，內部會全部先跑完，再向外動一個，再跑全部內圈
#依據列的方向填入
my_mat <- matrix(nrow=2,ncol=3)
my_vector <- 1:4
for(i in 1:ncol(my_mat)){#col
  for(j in 1:nrow(my_mat)){#row col為1時，row要從1跑到2
    my_mat[j,i] <- my_vector[1] # 1,1 2,1
    my_vector <- my_vector[-1] # 丟掉最前面的數字 1234->234就可依序填入
  }
}

#依據欄的方向填入
my_mat1 <- matrix(nrow=2,ncol=3)
my_vector1 <- 1:4

for(i in 1:nrow(my_mat1)){#col
  for(j in 1:ncol(my_mat1)){#row row為1時，col要從1跑到2
    my_mat1[i,j] <- my_vector1[1] # 1,1 1,2
    my_vector1 <- my_vector1[-1] # 丟掉最前面的數字 1234->234就可依序填入
  }
}

#while loop for printing variable of mtcars
var_names <- names(mtcars)
i <- 1
while(i<=length(var_names)){
  print(var_names[i])  
  i <- i+1
}
i

x <- 2 # 修改 x 看看結果有何不同？
# 兩個分支的流程控制
if (x %% 2 == 0) {
  print(paste(x,"是偶數!"))
} else {
  print(paste(x,"是奇數!"))
}

x <- 5.2 # 修改 x 看看結果有何不同？
# 三個分支的流程控制
if (x %% 3 == 0) {
  print("x 除以 3 的餘數為 0！")
} else if (x %% 3 == 1) {
  print("x 除以 3 的餘數為 1！")
} else if (x %% 3 == 2){
  print("x 除以 3 的餘數為 2！")
} else{
  print(paste(x,"除以 3 的餘數為",x %% 3))
}

#加入break中斷,next跳過
var_names <- names(mtcars)
for(var_name in var_names){
  if(var_name == "wt"){
   break 
  }
}
print(var_name)


#印出一到九月的while寫法
i <- 1
while(month.name[i]!="October"){
  print(month.name[i])
  i <- i+1
}




