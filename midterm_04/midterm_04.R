# 01 自訂排序函數加入 decreasing = 的參數（預設為 FALSE）
# 讓使用者可以指定降冪或升冪排序

my.sort <- function(input_vec,decreasing = FALSE){
  
  vector_length <- length(input_vec)
  
  for(i in 1:(vector_length-1)){
    for(j in (i+1):vector_length){
      if(decreasing == TRUE){
        if(input_vec[i]<input_vec[j]){
          box <- input_vec[i]
          input_vec[i] <- input_vec[j]
          input_vec[j] <- box
        }
      }
      else{
        if(input_vec[i]>input_vec[j]){
          box <- input_vec[i]
          input_vec[i] <- input_vec[j]
          input_vec[j] <- box
        }
      }
    }
  }
  return(input_vec)
}

unsorted_vec <- round(runif(10)*100)
my.sort(unsorted_vec,decreasing = TRUE)

-----------------# 02 樣本標準差-----------------

my.sd <- function(input_vec){
  
  x_bar <- mean(input_vec)
  n_minus_one <- length(input_vec)-1
  summation <- 0
  for(x_i in input_vec){
    summation <- summation+(x_i-x_bar)^2
  }
  return(sqrt(summation/n_minus_one)) #sqrt平方根
}

set.seed(9487)
my_seq <- round(runif(10)*100)
my.sd(my_seq)

-----------------#03 BMI-----------------

BMI_calculator <- function(w,h){
  h <- h/100
  BMI <- w/h^2
  return(BMI)
}
heights <- c(173, 168, 171, 189, 179)
weights <- c(65.4, 59.2, 63.6, 88.4, 68.7)
heights_and_weights <- data.frame(heights, weights)

#mapply
BMIs <- mapply(FUN = BMI_calculator,w=weights,h=heights)
heights_and_weights$BMI <- BMIs

#mutate
library(magrittr)
library(dplyr)
heights_and_weights %>%
  mutate(bmi = weights/(heights/100)^2) %>%
  View()