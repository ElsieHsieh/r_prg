library(jsonlite)

url <- "http://opendata.epa.gov.tw/ws/Data/WAT00328/?%24skip=0&%24top=1000&format=json" 
water_json <- fromJSON(url)

plot(water_json$DailyWaterPerPerson, water_json$PopulationServed, main = "每人每日生活用水量 vs. 供水人數 ", xlab = "DailyWaterPerPerson", ylab = "PopulationServed")

Taipei <- water_json[water_json$ExecutingUnit=="臺北市",]

Year_Date <- as.Date(Taipei$Year,format = "%Y/%m/%d")
Year_Taipei <- format(Year_Date,format="%Y")
PopulationServed_Taipei <- as.numeric(Taipei$PopulationServed) 

plot(Year_Taipei, PopulationServed_Taipei, type = "l", main = "2008年到2014年臺北市生活用水量", xlab = "Year", ylab = "用水量")

TPE <- water_json[grep("臺北",water_json$ExecutingUnit),]
Taoyuan  <- water_json[grep("桃園",water_json$ExecutingUnit),]
Taichung <- water_json[grep("臺中",water_json$ExecutingUnit),]
Tainan <- water_json[grep("臺南",water_json$ExecutingUnit),]
NewTai <- water_json[grep("新北",water_json$ExecutingUnit),]
Kaohsiung <- water_json[grep("高雄",water_json$ExecutingUnit),]

Six_City <- rbind(TPE,Taoyuan,Taichung,Tainan,NewTai,Kaohsiung)
NewTaipeiCity <- gsub("臺北縣", "新北市", Six_City$ExecutingUnit)
New_City_Name <- gsub("縣", "市", NewTaipeiCity)
Six_City <- cbind(Six_City,New_City_Name)

Six_City_2014 <- Six_City[format(as.Date(Six_City$Year,format = "%Y/%m/%d"),format="%Y")==2014,]
#par(mfrow = c(3, 2)) # 建立一個 1x2 的網格畫布
hist(as.numeric(water_json$DailyWaterPerPerson), main = "Distribution of DailyWater Per Person")
boxplot(as.numeric(Six_City$DailyWaterPerPerson) ~ Six_City$New_City_Name, main = "2008-2014年六都每人每日用水量",ylab="公升")

#2008~2014年平均每人每日用水量變化
formatdate <- format(as.Date(water_json$Year,format = "%Y/%m/%d"),format="%Y")

DWP_mean <- vector("numeric",length=7)
    
    for(i in c(2008:2014)){
      
      PerYear <- water_json[formatdate==i,]
      DWP_num <- as.numeric(PerYear$DailyWaterPerPerson)
      mean_result <- mean(DWP_num)
      print(mean_result)
      DWP_mean[i-2007] <- mean_result
      
     }  

year <- c(2008:2014)
DWP_year_mean <- data.frame(year, DWP_mean)
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

