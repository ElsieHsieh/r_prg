# create a function
circle.calculate<- function(radius,cal_area=TRUE){
  #cal_area=TRUE 幫它設定一個預設值
  #如果有指定cal_area==TRUE，就給他面積，FALSE給他圓周長
  area <- pi*radius^2
  circum <- 2*pi*radius
  
  if(cal_area==TRUE)
  {
    return(area)
  }else{
    return(circum)
  }
}

# Create input or parameters

my_radius <- 3

# Function call

circle.calculate(my_radius) #default: area
circle.calculate(my_radius,cal_area=FALSE)


#create a function: my.length()
my.length <- function(input_vec){
 
  #計數器迴圈，每次加一，直到跑完，跑完就是vector的長度
  counter <- 0
  for(i in input_vec){
    counter <- counter+1
    print(i)
  }
  return (counter)
}
  
#Create input
 my_runif <- runif(5) 
  my_seq <- seq(from=20,to=45,by=5)
#Function call
  my.length(my_runif)
 my.length(my_seq)
 
 
#create a function: my_sum()
 my_sum <- function(input_vec){
   summation=0
   for(i in input_vec){
     summation <- summation+i
   }
   return(summation)
 }
 
 sum_vec <- seq(from=20,to=45,by=5)
 
 my_sum(sum_vec)
 
 #create a function: my.sort()
 
 
 my.sort.asc <- function(input_vec){
   
   vector_length <- length(input_vec)
   for(i in 1:(vector_length-1)){
     for(j in (i+1):vector_length){
        if(input_vec[i]>input_vec[j]){
          
          box <- input_vec[i]
          input_vec[i] <- input_vec[j]
          input_vec[j] <- box
          
        }
     }
   }
   return(input_vec)
 }
 unsorted_vec <- runif(10)*100
 my.sort.asc(unsorted_vec)
 
 #TRUE=de↓
 
 # length,x bar= mean, sigma=for loop
 # 樣本標準差 Create a function: my.sd()
 my.sd <- function(input_vec){

   x_bar <- mean(input_vec)
   n_minus_one <- length(input_vec)-1
   summation <- 0
   for(x_i in input_vec){
     summation <- summation+(x_i-x_bar)^2
     
   }
   return(sqrt) #sqrt平方根
 }
 # Create an input
 set.seed(87)
   my_seq <- round(runif(10)*100)
   
   my.sd(my_seq)
   
   
#Create a function: BMI.calculator()
   BMI.calculator <- function(w, h){
     h=h/100
     return(w/h^2)
   }
   
# Create input
   heights <- c(173, 168, 171, 189, 179)
   weights <- c(65.4, 59.2, 63.6, 88.4, 68.7)
   heights_and_weights <- data.frame(heights, weights)
   
#Function call
   #mapply
   mapply(FUN=BMI.calculator,w=weights,h=heights)
   #再把他加回去 cbind