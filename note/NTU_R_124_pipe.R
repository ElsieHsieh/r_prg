library(magrittr)
sys_date_chr <- Sys.Date()
sys_date_yr_chr <- format(sys_date_chr, format = "%Y")
# sys_date_yr_chr <- substr(sys_date_chr, start = 1, stop = 4)
sys_date_yr_num <- as.numeric(sys_date_yr_chr)

#output == input%>%function 
sys_date_year_num <- Sys.Date()%>%
  format(format="%Y")%>%
  as.numeric()

#切字串
sys_date_year_num <- Sys.Date()%>%
  substr(start=1,stop=4)%>%
  as.numeric()

sys_date_year_num

#用``包住運算子
beyond_age <- Sys.Date()%>%
  format(format="%Y")%>%
  as.numeric()%>%
  `-`(1983)

beyond_age


