rankall <- function(outcome, num = "best") {
## Read outcome data

## Check that state and outcome are valid

## For each state, find the hospital of the given rank

## Return a data frame with the hospital names and the
## (abbreviated) state name
resultFrame   <- data.frame(hospital= character(), state=character())

#read in the desired data 
data <- read.csv("outcome-of-care-measures.csv", colClasses = "character") 


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


#--------- Examples with detailed description in best.R
# Extract data with 2 columns: [1]= "Hospital.Name" [2]= outcome
# exclude data in data[,outcome] == "Not Available":  != "Not Available"
# exclude data in data[,outcome] == "NA":  !is.na(data[,outcome])
extrctedFrame <- subset(data, data[,outcome] != "Not Available" & !is.na(data[,outcome]) , select = c("State", "Hospital.Name", outcome))
# Convert Char data in column ='outcome' to Number
extrctedFrame[,outcome] <- suppressWarnings(as.numeric(extrctedFrame[,outcome]))

#--------- Create a list of states
# easy way to have names ALL state get them from 
# inner implemented R-structure = 'state' property = 'state.abb'
#sortedt_list <- sort(state.abb,decreasing=FALSE,na.last=NA)	

#--------- take names form "outcome-of-care-measures.csv"
sortedNamesStates <- sort(unique(extrctedFrame[,"State"]))

for (i in seq(sortedNamesStates)) 
    {data.state <- extrctedFrame[extrctedFrame$State==sortedNamesStates[i],]
     # order data by outcome + Hospital.Name
     sorted.data.state <- data.state[order(data.state[,outcome], data.state[,"Hospital.Name"],decreasing=FALSE), ]
     
     if (num =="best") 
         index <- 1
     if (num =='worst') 
         index = nrow(sorted.data.state) 
     if (is.numeric(num)) 
         index <- as.numeric(num)
     resultFrame <- rbind(resultFrame, data.frame(hospital = sorted.data.state[index,"Hospital.Name"],
                                                  state = sortedNamesStates[i])
                         )

    }
resultFrame
}
