library(ggplot2)

library(jsonlite)
library(plotly)
crime_df <- read.csv("2007_2015_Taipei_Larcenies.csv")
url <- "2016_Taipei_Crime.json" 
crime_2016_df <- fromJSON(url)

pointchart <- ggplot(crime_df, aes(x = TotalEvent, y = OffenseClearedNumber)) + 
  geom_point(aes(colour = factor(Year)))+
  ggtitle("2007-2015年臺北市各行政區 竊盜案件數 vs. 破獲件數") +
  xlab("竊盜案件數") +
  ylab("破獲件數") +
  scale_colour_hue(name = "Year")
ggplotly(pointchart)

Sum_Offenders_Year <- aggregate(crime_df$Offenders, by=list(Year=crime_df$Year), FUN=sum)
colnames(Sum_Offenders_Year) <- c("Year", "Offenders")
Sum_OffenseClearedNumber_Year <- aggregate(crime_df$OffenseClearedNumber, by=list(Year=crime_df$Year), FUN=sum)
colnames(Sum_OffenseClearedNumber_Year) <- c("Year", "OffenseClearedNumber")
Sum_TotalEvent_Year <- aggregate(crime_df$TotalEvent, by=list(Year=crime_df$Year), FUN=sum)
colnames(Sum_TotalEvent_Year) <- c("Year", "TotalEvent")

Sum_Year <- merge(Sum_Offenders_Year, Sum_OffenseClearedNumber_Year, all.x = TRUE)
Sum_Year <- merge(Sum_Year, Sum_TotalEvent_Year, all.x = TRUE)
library(tidyr)
Sum_Year_long_df <- gather(Sum_Year, key = Category, value = values, Offenders, OffenseClearedNumber,TotalEvent)

linechart <- ggplot(Sum_Year_long_df, aes(x = Year, y = values , colour = Category)) + 
  geom_point() +
  geom_line()+
  ggtitle("2007-2015年臺北市竊盜犯罪案件與嫌疑犯人數統計") +
  xlab("Year") +
  ylab("Value")
ggplotly(linechart)

histochart <- ggplot(crime_2016_df, aes(x = Type)) +
  geom_histogram(stat="count",fill = "#81d8d0") +
  ggtitle("2016年臺北市犯罪類型件數統計") +
  xlab("犯罪類型") +
  ylab("計數")
ggplotly(histochart)

boxplotchart <- ggplot(crime_df, aes(x = TownName, y = CrimeRate)) +
  geom_boxplot(fill = "#AFEEEE", colour = "#585858") +
  ggtitle("2007-2015年臺北市各行政區竊盜案件") +
  xlab("行政區") +
  ylab("發生率(件/十萬人)")
ggplotly(boxplotchart)

library(dplyr)
crime_2015 <- crime_df[crime_df$Year==2015,]
crime_2015_sel <- select(crime_2015,TownName,TotalEvent,OffenseClearedNumber,Offenders)
crime_2015_long_df <- gather(crime_2015_sel, key = Category, value = values, TotalEvent, OffenseClearedNumber,Offenders)

bar2015 <- ggplot(crime_2015_long_df, aes(x = TownName, y = values)) +
  geom_bar(aes(fill = Category),stat = "identity",position = "dodge")+
  ggtitle("2015年臺北市各行政區竊盜犯罪統計") +
  xlab("Town") +
  ylab("Value") + 
  scale_fill_brewer(palette = "Set3", name = "統計項目")
ggplotly(bar2015)

bar2016 <- ggplot(crime_2016_df, aes(x = TownName)) +
  geom_bar(aes(fill = Type),stat = "count")+
  ggtitle("2016年臺北市各行政區犯罪類型統計") +
  xlab("Town") +
  ylab("Count") + 
  scale_fill_brewer(palette = "Set3",name = "犯罪類型")
ggplotly(bar2016)
