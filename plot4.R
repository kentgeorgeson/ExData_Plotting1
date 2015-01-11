# Exploratory Data Analysis Course - Jan 5th Start
# Student: Kent Georgeson
# Project 1 - Week 1 - Plot 4
# This R file is to recreate a time series line plot as assigned in the project notes. This assignment uses data from the 
# UC Irvine Machine Learning Repository, specifically will are using the “Individual household electric power" 

## First step is to confirm data is present, if not already download it retrieve the data by downloading the file as a ZIP 
## and unzipping it to the working directory.

file <- "household_power_consumption.txt"
if (!file.exists(file)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip",method="curl")
  unzip("household_power_consumption.zip")
 }

if (file.exists(file)) {

  ## Default series colors
  colors <- c("black", "red", "blue")

  ## Set Column Classes
  cols <- rep("numeric",9)
  cols[1] <- "character"
  cols[2] <- "character"
  cols[3] <- "numeric"

  # Read data, convert dates, fix for missing observations and subset for 2 days in February 2007
  data <- read.table(file, colClasses=cols, sep=';', header=T, na.strings='?', comment.char="")
 
  ## Set the date range
  daterange <- c(as.Date("2007-02-01"),as.Date("2007-02-02"))
 
  ## Filter the data to the specific dates
  powerdata <- data[which(as.Date(data$Date,"%d/%m/%Y") %in% daterange), ]

  ## Format the date and time fields into a single, combined, data and time variable
  dt <- strptime(paste(powerdata$Date, powerdata$Time), "%d/%m/%Y %H:%M:%S") 

  # Open plot2.png file for output
  png("plot3.png", height=480, width=480)

  ## Create plot graph based on time series (dt) and the first data series (series1)
  plot(dt, as.numeric(powerdata$Sub_metering_1), type="l", pch=NA, xlab="", ylab="Energy sub metering", col=colors[1])

  ## Add additional series to the plot
  lines(dt, as.numeric(powerdata$Sub_metering_2), col=colors[2])
  lines(dt, as.numeric(powerdata$Sub_metering_3), col=colors[3])

  ## Add the plot legend
  legend("topright", col=colors, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lty=c(1,1,1))

  ## Close the PNG device output
  dev.off()
}
