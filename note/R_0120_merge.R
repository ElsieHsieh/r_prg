load(url("https://storage.googleapis.com/r_rookies/straw_hat_df.RData"))
View(straw_hat_df)

load(url("https://storage.googleapis.com/r_rookies/straw_hat_devil_fruit.RData"))
View(straw_hat_devil_fruit)

straw_hat_merged <- merge(straw_hat_df,straw_hat_devil_fruit) 
#內建只保留有交集的值

straw_hat_left_merged <- merge(straw_hat_df,straw_hat_devil_fruit,all.x = TRUE)
#保留左邊所有資料