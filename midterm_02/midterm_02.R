library(ggplot2)
library(gridExtra)
csv_df <- read.csv("dailyrainfall.csv", encoding = "UTF-8")
head(csv_df)

ml <- csv_df[csv_df$SiteName=="麥寮",]
ml_date <- format(as.Date(ml$MonitorDate, "%Y-%m-%d"), "%d")

cc <- csv_df[csv_df$SiteName=="潮州",]
cc_date <- format(as.Date(cc$MonitorDate, "%Y-%m-%d"), "%d")

gs <- csv_df[csv_df$SiteName=="關山",]
gs_date <- format(as.Date(gs$MonitorDate, "%Y-%m-%d"), "%d")

ym <- csv_df[csv_df$SiteName=="陽明",]
ym_date <- format(as.Date(ym$MonitorDate, "%Y-%m-%d"), "%d")


p1 <- ggplot(ml,aes(x=ml_date,y=ml$Rainfall24hr,group = 1))+
  geom_point( color="blue", size=2,alpha=.5)+
  geom_line(alpha=.3)+
  ggtitle("2016年11月麥寮測站日雨量圖") +
  xlab("Date") +
  ylab("Rainfall(mm)")

p2 <- p1 <- ggplot(cc,aes(x=cc_date,y=cc$Rainfall24hr,group = 1))+
  geom_point( color="blue", size=2,alpha=.5)+
  geom_line(alpha=.3)+
  ggtitle("2016年11月潮州測站日雨量圖") +
  xlab("Date") +
  ylab("Rainfall(mm)")

p3 <- p1 <- ggplot(gs,aes(x=gs_date,y=gs$Rainfall24hr,group = 1))+
  geom_point( color="blue", size=2,alpha=.5)+
  geom_line(alpha=.3)+
  ggtitle("2016年11月關山測站日雨量圖") +
  xlab("Date") +
  ylab("Rainfall(mm)")

p4 <- p1 <- ggplot(ym,aes(x=ym_date,y=ym$Rainfall24hr,group = 1))+
  geom_point( color="blue", size=2,alpha=.5)+
  geom_line(alpha=.3)+
  ggtitle("2016年11月陽明測站日雨量圖") +
  xlab("Date") +
  ylab("Rainfall(mm)")
grid.arrange(p1,p2,p3,p4, nrow=2, ncol=2)


# geom_bar(stat = "identity")
# ggplot(csv_df,aes(x=MonitorDate,y=Rainfall24hr,color=SiteName,group = 1)) + geom_point() +geom_line()
