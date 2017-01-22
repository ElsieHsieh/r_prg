#1/18練習

#char_vec <- c("Female", "Male", "Male", "Female", "Female")
#is.factor(char_vec)

#factor_vec <- factor(char_vec)
#factor_vec[1]>factor_vec[2] #因為沒有指定順序所以回傳NA

speed_vec <- c("Slow", "Fast", "Slow", "Moderate")
speed_factor <- factor(speed_vec,ordered = TRUE,levels=c("Slow","Moderate","Fast"))
#指定因素向量的順序
speed_factor[1]>speed_factor[2] #FALSE
speed_fac <- factor(speed_vec,ordered = TRUE) #不指定levels順序，會以字母先後順序排列，a最小

my_mat <- matrix(1:20,nrow=4,byrow = TRUE)#預設依照欄(直)的方向填入資料，TRUE會依照列

conf_vec <- c(5,2,0,3,3,2,0,1,11)
conf_matrix <- matrix(conf_vec,nrow=3) #混淆矩陣
acc <- sum(diag(conf_matrix))/sum(conf_matrix) #機器學習的預測三種動物準確率是七成 Accuracy

my_matrix <- matrix(1:20,nrow=5)
my_matrix[my_matrix%%3==0]

one_piece_df[one_piece_df$is_female==TRUE,] #回傳是女生的資料

one_piece_df[one_piece_df$is_female==TRUE,"name"] #只給我回傳的特定欄位



my_vector <- 1:8
my_matrix <- matrix(my_vector, nrow = 2, ncol = 4)
name <- c("蒙其D魯夫", "羅羅亞索隆", "娜美", "賓什莫克香吉士")
is_female <- c(FALSE, FALSE, TRUE, FALSE)
age <- c(19, 21, 20, 21)
one_piece_df <- data.frame(name, is_female, age)
my_list <- list(my_matrix,my_vector,one_piece_df)

my_list <- list(item_matrix=my_matrix,item_vector= my_vector,item_df=one_piece_df)#命名

sum(age<25) #age<25 == TRUE，TRUE==1, FALSE==0,只要將邏輯值加總即可知道符合的人數

a <- c(TRUE,TRUE,FALSE)
b <- c(FALSE,TRUE,TRUE)
a & b #資料集內的東西一個一個比
a | b
a && b #比較資料集裡的第一個變數
a || b #比較單一變數時，兩種都可以
