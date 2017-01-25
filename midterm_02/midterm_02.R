library(jsonlite)

url <- "water.json" 
water_json <- fromJSON(url,stringsAsFactors = FALSE)

plot(Six_City$PopulationServed, Six_City$DailyWaterPerPerson, main = "六都供水人數vs.每人每日生活用水量", xlab = "人數", ylab = "用水量")

#臺北市各年直方圖
Taipei <- water_json[water_json$ExecutingUnit=="臺北市",]
Date_Taipei <- as.Date(Taipei$Year,format = "%Y/%m/%d")
Year_Taipei <- format(Date_Taipei,format="%Y")
DWP_Taipei <- as.numeric(Taipei$DailyWaterPerPerson) 
plot(Year_Taipei, DWP_Taipei, type = "l", main = "2008年到2014年臺北市生活用水量", xlab = "Year", ylab = "用水量")

#臺中市各年line chart
TaiC <- water_json[grep("臺中",water_json$ExecutingUnit),]
Date_Taichung <- as.Date(TaiC$Year,format = "%Y/%m/%d")
Year_Taichung <- format(Date_Taichung,format="%Y")
DWP_Taichung <- as.numeric(TaiC$DailyWaterPerPerson) 
plot(Year_Taichung, DWP_Taichung, type = "l", main = "2008年到2014年臺中市每人每日生活用水量", xlab = "Year", ylab = "用水量")

#篩出六都(包含升格前後)

filter_city_vec <- c("臺北","桃園","臺中","臺南","新北","高雄")
Six_City=data.frame()
for(i in 1:length(filter_city_vec)){
  result <- water_json[grep(filter_city_vec[i],water_json$ExecutingUnit),]
  Six_City <- rbind(Six_City,result)
}

#處理升格前後的CityName
NewTaipeiCity <- gsub("臺北縣", "新北市", Six_City$ExecutingUnit)
New_City_Name <- gsub("縣", "市", NewTaipeiCity)
Six_City <- cbind(Six_City,New_City_Name)

hist(as.numeric(water_json$DailyWaterPerPerson), main = "Distribution of DailyWater Per Person")
boxplot(as.numeric(Six_City$DailyWaterPerPerson) ~ Six_City$New_City_Name, main = "2008-2014年六都每人每日用水量",ylab="公升")

#1996~2014年平均每人每日用水量變化
formatdate <- format(as.Date(water_json$Year,format = "%Y/%m/%d"),format="%Y")
DWP_mean <- vector("numeric",length=7)
    
  for(i in 1:7){
      PerYear <- water_json[formatdate==i+2007,] #篩選出2008~2014各年度的資料
      DWP_num <- as.numeric(PerYear$DailyWaterPerPerson)
      mean_result <- mean(DWP_num)#算各年的平均
      DWP_mean[i] <- mean_result #將計算結果依序填入vector
  }  

year <- c(2008:2014)
DWP_year_mean <- data.frame(year, DWP_mean) #各年與平均數的df

#只畫2008-2014的圖太醜
#但opendata只開放2008年以後，2008以前只放在網站圖表上
mean_2007 <- c(2007,279)
mean_2006 <- c(2006,279)
mean_2005 <- c(2005,277)
mean_2004 <- c(2004,274)
mean_2003 <- c(2003,275)
mean_2002 <- c(2002,275)
mean_2001 <- c(2001,285)
mean_2000 <- c(2000,280)
mean_1999 <- c(1999,278)
mean_1998 <- c(1998,282)
mean_1997 <- c(1997,286)
mean_1996 <- c(1996,291)
DWP_year_mean <- rbind(DWP_year_mean,mean_2007,mean_2006,mean_2005,mean_2004,
                       mean_2003,mean_2002,mean_2001,mean_2000,mean_1999,
                       mean_1998,mean_1997,mean_1996)

#DWP_year_mean[order(DWP_year_mean$year),]
library(dplyr)

DWP_year_mean <- arrange(DWP_year_mean, year)
mean_year_bar <- barplot(DWP_year_mean$DWP_mean,names = DWP_year_mean$year)

water_json %>%
  group_by(ExecutingUnit) %>%
  summarise(mean_city = mean(as.numeric(DailyWaterPerPerson))
            ) %>%
  View()