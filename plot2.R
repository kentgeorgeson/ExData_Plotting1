# Exploratory Data Analysis Course - Jan 5th Start
# Student: Kent Georgeson
# Project 1 - Week 1 - Plot 2
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

  ## Set Column Classes
  cols <- rep("NULL",9)
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

  ## Create the data series ensuring numeric value
  series <- as.numeric(powerdata$Global_active_power)

  # Open plot2.png file for output
  png("plot2.png", height=480, width=480)

  ## Create plot graph based on time series (dt) and data series (series) hiding the markers for data points with pch=NA
  plot(dt, series, pch=NA, xlab="", ylab="Global Active Power (kilowatts)")

  ## Add the line to the plot
  lines(dt, series)

  ## Close the PNG device output
  dev.off()
}
