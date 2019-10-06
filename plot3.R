plot3 <- function() {
  
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
  
  # construct plot3
  plot(data$Time,data$Sub_metering_1 ,pch='', xlab='', ylab='Energy sub metering')
  lines(data$Time, data$Sub_metering_1, col='black')
  lines(data$Time, data$Sub_metering_2, col='red')
  lines(data$Time, data$Sub_metering_3, col='blue')
  legend("topright", 
         legend=c("Sub_metering_1", "Sub_metering_2",'Sub_metering_3'),
         col=c("black",'red',"blue"), lty=1)
  
  # save in plot3.png
  dev.copy(png,'plot3.png')
  dev.off()
  
}

