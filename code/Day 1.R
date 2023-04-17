

library(data.table)
library(readr)
library(magrittr)
url <- "https://raw.githubusercontent.com/jinseob2kim/lecture-snuhlab/master/data/example_g1e.csv"

tblordf <- read_csv(url)
tblordf

dt <- fread(url,header=T)
dt[1:10]
dt[c(1,10)]




## I dont get this!

# 1
flight <- fread("https://raw.githubusercontent.com/Rdatatable/data.table/master/vignettes/flights14.csv")
sum( (arr_delay + dep_delay) < 0) 
flight[,sum( (arr_delay + dep_delay) < 0 )] # why does this return how many trips have had total delay < 0?
nrow(flight[ (arr_delay + dep_delay) < 0 ]) # how is it equal to this?
flight[,141814] #how is it different from this?


# 2
dt[, .(HGHT)] # HGHT as list
dt[, HGHT]   # HGHT as vector
dt$HGHT # HGHT as vector

dt[, "HGHT"] #HGHT as list

v <- "HGHT"
dt[[v]] # HGHT as vector
dt[, v] #doesnt work
dt[, ..v] # HGHT as list
dt[, "HGHT"] # HGHT as list. why does it work without .., weird



# 3


