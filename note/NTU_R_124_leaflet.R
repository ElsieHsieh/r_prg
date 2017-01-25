library(leaflet)
stores <- read.csv("https://storage.googleapis.com/r_rookies/stores711inTP.csv",encoding="UTF-8")
markers_711 <- leaflet(data = stores) %>%
  addTiles() %>%
  addMarkers(~lng, ~lat, popup = ~as.character(popups1),clusterOptions =  markerClusterOptions(),icon = list(iconUrl = "https://storage.googleapis.com/r_rookies/711_logo.gif", iconSize = c(20, 20)))
  #clusterOptions = TRUE can also work
markers_711