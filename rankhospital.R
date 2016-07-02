rankhospital <- function(state, outcome, num = "best") {
## Read outcome data

## Check that state and outcome are valid

## Return hospital name in that state with the given rank
## 30-day death rate

#read in the desired data 
data <- read.csv("outcome-of-care-measures.csv", colClasses = "character") 

## Check that state and outcome are valid
if ((state %in% data$State) == FALSE) 
    stop(print("invalid state")) 

#> outcome <- c("heart attack")
#> state <- c("TX")

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

#--------- Final (descripion from best.R)
# Extract data with 2 columns: [1]= "Hospital.Name" [2]= outcome
# and state = 'AL'
# exclude data in data[,outcome] == "Not Available":  != "Not Available"
# exclude data in data[,outcome] == "NA":  !is.na(data[,outcome])
extrctedFrame <- subset(data, data$State==state & data[,outcome] != "Not Available" & !is.na(data[,outcome]) , select = c("Hospital.Name", outcome))

# Create index by 2 columns
index <- with(extrctedFrame, order( as.numeric(extrctedFrame[,outcome]), extrctedFrame[,"Hospital.Name"]), decreasing=FALSE)

# Create Sorted Frame
sortedFrame <- extrctedFrame[index,]


if (is.character(num) == TRUE)  
   {if (num == "best") 
       {mHospital <- sortedFrame[1,"Hospital.Name"]
       }
    else if (num == "worst") 
       {#Find max Rate value:
        maxRate <- sortedFrame[nrow(sortedFrame),outcome]
        # Select All hospitals with the same maximum rate:
        worstHospitals <- sortedFrame[which(as.numeric(sortedFrame[, outcome]) == as.numeric(maxRate)) ,]
        #Sort All hospitals in Alphabetical order:
        Alphabet_Hospitals<-worstHospitals[order(worstHospitals[,1]),]
        #Choose first one by Alphabet:
        mHospital <-as.vector(head(Alphabet_Hospitals[,1],1))
       } 
   } 
else
   {mHospital <- sortedFrame[num, "Hospital.Name"]
   }
mHospital
}
