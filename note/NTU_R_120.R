# 角色設定的向量
name <- c("Monkey D. Luffy", "Roronoa Zoro", "Nami", "Usopp", "Vinsmoke Sanji", "Tony Tony Chopper", "Nico Robin", "Franky", "Brook")
gender <- c("Male", "Male", "Female", "Male", "Male", "Male", "Female", "Male", "Male")
occupation <- c("Captain", "Swordsman", "Navigator", "Sniper", "Cook", "Doctor", "Archaeologist", "Shipwright", "Musician")
bounty <- c(500000000, 320000000, 66000000, 200000000, 177000000, 100, 130000000, 94000000, 83000000)
age <- c(19, 21, 20, 19, 21, 17, 30, 36, 90)
birthday <- c("05-05", "11-11", "07-03", "04-01", "03-02", "12-24", "02-06", "03-09", "04-03")
height <- c(174, 181, 170, 176, 180, 90, 188, 240, 277)

# 建立草帽海賊團角色設定的資料框
straw_hat_df <- data.frame(name, gender, occupation, bounty, age, birthday, height)

#date <- Sys.Date() #回傳系統日期
#year <- substr(date,1,4) #切出2017

fyear_char <- format(Sys.Date(),format="%Y") #年是字串，無法直接運算

birth_year_num <- as.numeric(fyear_char) - straw_hat_df$age

straw_hat_df$birth_year <- birth_year_num

fav_food <- c("Meat", "Food matches wine", "Orange", "Fish", "Food matches black tea", "Sweets", "Food matches coffee", "Food matches coke", "Milk")

straw_hat_df <- cbind(straw_hat_df,fav_food)

straw_hat_df$fav_food <- NULL

# na.rm =TRUE 將NA值刪除

straw_hat_df$birth_year <- NULL

straw_hat_df <- data.frame(name, gender, occupation, bounty, age, birthday, height,stringsAsFactors = FALSE)

# 超過factor相異值 會無法加上去 ，設定不要把字串轉成因素向量

princess_vivi <- c("Nefeltari Vivi", "Female", "Princess of Alabasta", NA, 18, "02-02", NA)

straw_hat_df <- rbind(straw_hat_df,princess_vivi)

straw_hat_df <- straw_hat_df[-9, ] #刪除第九個

id <- c(1:nrow(straw_hat_df)) #新增id欄位

straw_hat_df <- cbind(straw_hat_df,id)        

row.names(straw_hat_df) <- as.character(seq(from = 1, to = nrow(straw_hat_df)))
#這樣就可以更新rownames了
# write.csv(straw_hat_df, file = "MyData.csv",row.names=TRUE)