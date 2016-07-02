best <- function(state, outcome) {
## Read outcome data

## Check that state and outcome are valid

## Return hospital name in that state with lowest 30-day death
## rate

#read in the desired data 
data <- read.csv("outcome-of-care-measures.csv", colClasses = "character") 

#----------------------------------
#> nrow(data)
#[1] 4706
#> ncol(data)
#[1] 46
#> class(data)
#[1] "data.frame"
#> names(data)
# [1] "Provider.Number"                                                                      
# [2] "Hospital.Name"                                                                        
# [3] "Address.1"                                                                            
#.....
# [6] "City"                                                                                 
# [7] "State"                                                                                
#.....
#[11] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"  
#.....
#[17] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"                           
#.....
#[22] "Footnote...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"                
#[23] "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"                               
#[24] "Comparison.to.U.S..Rate...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"    
#.....
#----------------------------------
#> nrow(data)
#[1] 4706
#> data$State
#   [1] "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL"
#  [20] "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL" "AL"
#..... 
#[4675] "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX"
#[4694] "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX" "TX"
#----------------------------------

## Check that state and outcome are valid
if ((state %in% data$State) == FALSE) 
    stop(print("invalid state")) 

## Check outcome to valid
if(outcome == "heart attack") #11
  {     #[11] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"  
   outcome <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack" 
  } 
else if (outcome == "heart failure") #17 
  {     #[17] "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
   outcome <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure" 
  }                                
else if (outcome == "pneumonia") #23
  {     #[23] "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
   outcome <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia" 
  }     
else 
  {stop("invalid outcome") 
  } 

#----------------------------------
#> outcome <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack" 
#> as.numeric(data[,outcome])
#   [1] 14.3 18.5 18.1   NA   NA   NA 17.7 18.0 15.9   NA 19.6 17.3   NA 17.8 17.5 15.4   NA 16.3   NA
#.....
#  [20] 15.0 17.1 17.1   NA 16.4 15.2 16.7   NA   NA 16.7 16.9 14.5 16.6   NA   NA   NA 15.8 15.2 16.2
#.....
#[4694]   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
#Warning message:
#NAs introduced by coercion 

#--------- Example 1. All columns
# Extract data with ALL columns and state = 'AL'
#> state <- "AL"
#> extrctedFrame_1 <- subset(data, data$State==state)
# See how many rows + columns:
#> nrow(extrctedFrame_1)
#[1] 98 
#> ncol(extrctedFrame_1)
#[1] 46

#--------- Example 2. only 2 necessary columns
# Extract data with 2 columns: [1]= "Hospital.Name" [2]= outcome
# and state = 'AL'
#extrctedFrame_2 <- subset(data, data$State==state, select = c("Hospital.Name", outcome))
# See how many rows + columns and what is into:
#> nrow(extrctedFrame_2)
#[1] 98
#> ncol(extrctedFrame_2)
#[1] 2
#> str(extrctedFrame_2)
#'data.frame':   98 obs. of  2 variables:
# $ Hospital.Name : chr  "SOUTHEAST ALABAMA MEDICAL CENTER" "MARSHALL MEDICAL CENTER SOUTH" "ELIZA COFFEE MEMORIAL HOSPITAL" "MIZELL MEMORIAL HOSPITAL" ...
# $ Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack: chr  "14.3" "18.5" "18.1" "Not Available" ...

#--------- Example 3. 2 columns and exclude "Not Available"
# Extract data with 2 columns: [1]= "Hospital.Name" [2]= outcome
# and state = 'AL'
# exclude data in data[,outcome] = "Not Available"
#extrctedFrame_3 <- subset(data, data$State==state & data[,outcome] != "Not Available" , select = c("Hospital.Name", outcome))
#> nrow(extrctedFrame_3)
#[1] 51
#> ncol(extrctedFrame_3)
#[1] 2
#str(extrctedFrame_3)
#'data.frame':   51 obs. of  2 variables:
# $ Hospital.Name : chr  "SOUTHEAST ALABAMA MEDICAL CENTER" "MARSHALL MEDICAL CENTER SOUTH" "ELIZA COFFEE MEMORIAL HOSPITAL" "ST VINCENT'S EAST" ...
# $ Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack: chr  "14.3" "18.5" "18.1" "17.7" ...
#----------------------------------
 

#--------- Final. 2 columns + exclude "Not Available", "NA"
# Extract data with 2 columns: [1]= "Hospital.Name" [2]= outcome
# and state = 'AL'
# exclude data in data[,outcome] == "Not Available":  != "Not Available"
# exclude data in data[,outcome] == "NA":  !is.na(data[,outcome])
extrctedFrame <- subset(data, data$State==state & data[,outcome] != "Not Available" & !is.na(data[,outcome]) , select = c("Hospital.Name", outcome))

#----------------------------------
#nrow(extrctedFrame)
#[1] 51
#str(extrctedFrame)
#'data.frame':   51 obs. of  2 variables:
# $ Hospital.Name  : chr  "SOUTHEAST ALABAMA MEDICAL CENTER" "MARSHALL MEDICAL CENTER SOUTH" "ELIZA COFFEE MEMORIAL HOSPITAL" "ST VINCENT'S EAST" ...
# $ Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack: chr  "14.3" "18.5" "18.1" "17.7" ...

# Convert Char data in column ='outcome' to Number
#
# this section I don't use, because you can see down 
# I use as.numeric(...) operator each time
#
#extrctedFrame[,outcome] <- suppressWarnings(as.numeric(extrctedFrame[,outcome]))
#> str(extrctedFrame)
#'data.frame':   51 obs. of  2 variables:
# $ Hospital.Name  : chr  "SOUTHEAST ALABAMA MEDICAL CENTER" "MARSHALL MEDICAL CENTER SOUTH" "ELIZA COFFEE MEMORIAL HOSPITAL" "ST VINCENT'S EAST" ...
# $ Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack: num  14.3 18.5 18.1 17.7 18 15.9 19.6 17.3 17.8 17.5 ...
#----------------------------------

## Return hospital name in that state with lowest 30-day death
## rate

#Find minimum value of the 'Outcome':
minRate <- min(as.numeric(extrctedFrame[, outcome]))

# Select All hospitals with the same minimum rate:
bestHospitals <- extrctedFrame[which(as.numeric(extrctedFrame[, outcome]) == minRate) ,]

#Sort All hospitals in Alphabetical order:
Alphabet_Hospitals<-bestHospitals[order(bestHospitals[,1]),]

#Choose first one by Alphabet:
theBestHospital <-as.vector(head(Alphabet_Hospitals[,1],1))

theBestHospital
}

