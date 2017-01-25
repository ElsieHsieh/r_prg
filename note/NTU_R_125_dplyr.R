library(dplyr)
filtered_df <- filter(iris,Sepal.Length<6&Species=="versicolor")

filtered_df2 <- iris %>% 
  filter(Sepal.Length>6)%>%
  filter(Species == "versicolor")
dim(filtered_df2)

dim(filtered_df)
View(filtered_df)

iris%>%select(Sepal.Length)
iris_subset <- iris %>% 
  filter(Sepal.Width>mean(Sepal.Width))%>%
  select(-Species) #加上減號就會排除該欄位
dim(iris_subset)
View(iris_subset)

heights <- c(173, 168, 171, 189, 179)
weights <- c(65.4, 59.2, 63.6, 88.4, 68.7)
heights_and_weights <- data.frame(heights, weights)

BMI_result <- heights_and_weights %>%
        mutate(height_in_meter = heights/100,
         BMI = weights/(height_in_meter^2))%>%
  arrange(desc(BMI))

  View(BMI_result)
  #幫DF取名
  
  water_json %>%
    group_by(ExecutingUnit) %>%
    summarise(mean_city = mean(as.numeric(DailyWaterPerPerson))
    ) %>%
    View()
