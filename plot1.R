# Exploratory Data Analysis Course - Jan 5th Start
# Student: Kent Georgeson
# Project 1 - Week 1
# This R file is to recreate a histogram plot as assigned in the project notes. This assignment uses data from the UC Irvine Machine Learning Repository, specifically will are using the “Individual household electric power" 

## First step is to confirm data is present, if not already download it retrieve the data by downloading the file as a ZIP and unzipping it to the working directory.
file <- "household_power_consumption.txt"
if (!file.exists(file)) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip",method="curl")
  unzip("household_power_consumption.zip")
}

## Second step if the data file exists is to read the file in and then filter the data to the specific date range of Feb 01 2007 to Feb 02 2007.
if (file.exists(file)) {
  
  ## Set Column Classes
  cols <- rep("NULL",9)
  cols[1] <- "character"
  cols[3] <- "numeric"
  
  ## Read the file
  data <- read.table(file, colClasses=cols, sep=';', header=T, na.strings='?', comment.char="")
  
  ## Set the date range
  daterange <- c(as.Date("2007-02-01"),as.Date("2007-02-02"))
  
  ## Filter the data to the specific dates
  powerdata <- data[which(as.Date(data$Date,"%d/%m/%Y") %in% daterange), 2]

  ## Create a PNG output file for this histogram, draw the histogram in the PNG and then close the device.
  png(filename="plot1.png",width=480, height=480)
  hist(powerdata, col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
  dev.off()
}
