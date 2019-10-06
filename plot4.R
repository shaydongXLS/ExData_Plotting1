plot4 <- function() {
  
  # download and unzip data, if not already exist
  filename='exdata_data_household_power_consumption.zip'
  if(!file.exists(filename)){
    fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
    download.file(fileURL,filename, method='curl')
  }
  
  if(!file.exists('household_power_consumption.txt')){
    unzip(filename)
  }
  
  
  # read data of 1/2/2007 and 2/2/2007 (d/m/y)
  library(sqldf)
  data <-read.csv.sql("household_power_consumption.txt", 
                      "select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                      header= TRUE, sep = ";")
  
  # convert the Date and Time variables to one Date/Time variable
  data$Time <- paste(data$Date,data$Time, sep='/')
  data$Time <- strptime(data$Time,'%d/%m/%Y/%H:%M:%S')
  data <- data[-1]
  
  # construct plot4
  par(mfrow=c(2,2))
  # 1st plot
  plot(data$Time, data$Global_active_power,pch='', xlab='', ylab='Global Active Power (kilowatts)')  
  lines(data$Time, data$Global_active_power)
  # 2nd plot
  plot(data$Time, data$Voltage,pch='', xlab='datetime', ylab='Voltage')
  lines(data$Time, data$Voltage)
  # 3rd plot
  plot(data$Time,data$Sub_metering_1 ,pch='', xlab='', ylab='Energy sub metering')
  lines(data$Time, data$Sub_metering_1, col='black')
  lines(data$Time, data$Sub_metering_2, col='red')
  lines(data$Time, data$Sub_metering_3, col='blue')
  legend("topright", 
         legend=c("Sub_metering_1", "Sub_metering_2",'Sub_metering_3'),
         col=c("black",'red',"blue"), lty=1,bty = "n")
  # 4th plot
  plot(data$Time, data$Global_reactive_power,pch='', ylab='Global_reactive_power', xlab='datetime')  
  lines(data$Time, data$Global_reactive_power)
  

  # save in plot4.png
  dev.copy(png,'plot4.png')
  dev.off()
  
}

