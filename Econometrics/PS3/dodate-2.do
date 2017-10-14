//drop t    // clears old variable name double  slashes indicate comment, use on same line as command.
local time observation_date //   "local" command tells stata to refer to actual variable "observation_date" from FRED as shorter "time"
gen t=date(`time',"YMD") // generate new variable "t" from time,  note reference to the local in ` ' NOT ' ' 
format t %td// formats time into human readable format (HUR)
//drop month2
 gen month2=month(t) // pulls "month" out of "t" and generates new variable 1-12
// drop year
 gen year= year(t)
// drop monthdum*
 tabulate month, generate(monthdum) // uses "tabulate" command to generate 12 dummy variables for each month
 local season monthdum1 monthdum2 monthdum3 monthdum4 monthdum5 monthdum6 monthdum7 monthdum8 monthdum9 monthdum10 monthdum11 monthdum12
 reg paynsa `season', hascons //uses short reference to "season" rather than list the 12 dummy variables, then tells stata it has a constant
 //drop r1  // doing this as r1 was in the file
 predict r1,resid  //generates the residuals from previous regression
 //drop time2
 gen time2=ym(year,month2) //generates new variable based on year month variables
 format time2 %tm  // formats time2 in HRF
// drop empmean
 egen double empmean=mean (paynsa) //pulls the mean out od employment
 //drop empseas3
 gen empseas3=empmean+r1   // add in the residuals to the mean of employment to get the seasonally adjusted
 twoway(line  empseas3 time2) ( line payems time2)  // graphs the two
