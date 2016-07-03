
#> States <- extrctedFrame[,"State"]
#> str(States)
# chr [1:2720] "AL" "AL" "AL" .....
#> factorStates <- factor(extrctedFrame[,"State"])
#> str(factorStates)
# Factor w/ 54 levels "AK","AL","AR",..: 2 2 2 2 2 2 2 2 2 2 ...
#> levels(factorStates)
# [1] "AK" "AL" "AR" "AZ" "CA" "CO" "CT" "DC" "DE" "FL" "GA" "GU" "HI"
#[14] "IA" "ID" "IL" "IN" "KS" "KY" "LA" "MA" "MD" "ME" "MI" "MN" "MO"
#[27] "MS" "MT" "NC" "ND" "NE" "NH" "NJ" "NM" "NV" "NY" "OH" "OK" "OR"
#[40] "PA" "PR" "RI" "SC" "SD" "TN" "TX" "UT" "VA" "VI" "VT" "WA" "WI"
#[53] "WV" "WY"
#sortedNamesStates <- sort(levels(factor(extrctedFrame[,"State"])),decreasing=FALSE,na.last=NA)
#> sortedNameState
# [1] "AK" "AL" "AR" "AZ" "CA" "CO" "CT" "DC" "DE" "FL" "GA" "GU" "HI"
#[14] "IA" "ID" "IL" "IN" "KS" "KY" "LA" "MA" "MD" "ME" "MI" "MN" "MO"
#[27] "MS" "MT" "NC" "ND" "NE" "NH" "NJ" "NM" "NV" "NY" "OH" "OK" "OR"
#[40] "PA" "PR" "RI" "SC" "SD" "TN" "TX" "UT" "VA" "VI" "VT" "WA" "WI"
#[53] "WV" "WY"
