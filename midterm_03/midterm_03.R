library(ggplot2)
library(jsonlite)
url <- "TaipeiMRT.json" 
MRT_json <- fromJSON(url)

ggplot(MRT_json, aes(x = `士林`)) + 
  geom_bar()