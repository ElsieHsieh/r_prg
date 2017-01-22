library(tidyr)
library(ggplot2)
load(url("https://storage.googleapis.com/r_rookies/straw_hat_df.RData"))
straw_hat_df_3_col <- straw_hat_df[, c("name", "age", "height")]
# View(straw_hat_df_3_col)

straw_hat_df_3_col_long <- gather(straw_hat_df_3_col,key = age_or_height,value = val,age,height)
# 寬表格變長表格

straw_hat_df_4_col <- straw_hat_df[,c("name","age","height","bounty")]
head(straw_hat_df_4_col,n=3)

new <- c("Amy","22","150","10000")
straw_hat_df_4_col <- rbind(straw_hat_df_4_col,new)
straw_hat_df_4_col_long <- gather(straw_hat_df_4_col,key = age_or_height_b,value = val,age,height,bounty)

straw_hat_df_4_col_wide <- spread(straw_hat_df_4_col_long, key = age_or_height_b, value = val)

ggplot(straw_hat_df_3_col_long, aes(x = factor(name), y = val, fill = age_or_height)) + geom_bar(stat = "identity", position = "dodge")