#extract the data from the provided file and in the reading function the relevant days are filtered in order to save memory.
#check for NA is performed and conversion to POSIXlt of date and time related field is performed
gatherData<-function()
{
  library(sqldf)
  filteredData<-read.csv2.sql(file = "household_power_consumption.txt", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", header = TRUE) 
  filteredData[ filteredData == "?" ] = NA
  filteredData$DateTime<-paste(filteredData$Date, filteredData$Time)
  filteredData$DateTime<-strptime(filteredData$DateTime, "%d/%m/%Y %H:%M:%S")
  return(filteredData)
}




#creates plot1 as required by initializing the graphic device png and plotting the histogram
plot1<-function()
{
  filteredData<-gatherData()
  png("plot1.png",width = 480, height = 480, units = "px")
  with(filteredData, hist(Global_active_power, col = "red", xlab = ("Global Active Power (kilowatts)"), main = "Global Active Power"))
  dev.off()
}