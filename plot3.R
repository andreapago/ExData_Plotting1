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




#creates plot3 as required by initializing the graphic device png and plotting the three submeting in a 
#single chart
plot3<-function()
{
  filteredData<-gatherData()
  png("plot3.png", width = 480, height = 480, units = "px")
  with(filteredData, {
    plot(DateTime, Sub_metering_3, type = "n", xlab = "", ylab = "Energy sub metering",ylim=c(0,max(Sub_metering_1)))
    lines(DateTime, Sub_metering_1, lty = 1, lwd = 1)
    lines(DateTime, Sub_metering_2, lty = 1, lwd = 1, col="red")
    lines(DateTime, Sub_metering_3, lty = 1, lwd = 1, col="blue")
    legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()
  })
}