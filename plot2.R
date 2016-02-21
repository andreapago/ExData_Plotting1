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




#creates plot2 as required by initializing the graphic device png and plotting the line diagram of the reactive power
plot2<-function()
{
  filteredData<-gatherData()
  png("plot2.png",width = 480, height = 480, units = "px")
  with(filteredData, {
    plot(DateTime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
    lines(DateTime, Global_active_power, lty = 1, lwd = 1)
  })
  dev.off()
}