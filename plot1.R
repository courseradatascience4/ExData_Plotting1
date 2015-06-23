# * READING IN DATA - Same for every plot ************************************#
  library(data.table)
  library(dplyr)
  
  dataset <- read.table("./Course Project 1/household_power_consumption.txt",
                      header=TRUE, nrows = 2075259, na.strings="?", sep=";",
                      colClasses = c(rep("character",2),rep("numeric", 7)))
  
  # Convert the date column to date objects
  dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

  # we only need dates 2007-02-01 and 2007-02-02
  matchingDates <- as.Date(c("01/02/2007", "02/02/2007"), "%d/%m/%Y")

  matched <- filter(dataset, Date %in% matchingDates)
  
  # Create datetime column
  matched$datetime <- paste(matched$Date, matched$Time, sep=" ")
  matched$datetime <- strptime(matched$datetime, "%Y-%m-%d %H:%M:%S")
  
# * Plotting *****************************************************************#
  
  # We are creating a histogram to show the frequency of Global Active Power
  # values. The x-axis is labelled "Global Active Power (kilowatts)".
  # The main title is "Global Active Power"
  
  # We do not need to specify the following as they are the defaults here:
  #   y axis label ("Frequency")
  #   4 breaks per major unit (12 total)
  #   x axis - 0 - 6 (major tick = 2)
  #   Frequency axis - 0 - 1200 (major tick = 200)
  
  png("plot1.png", width=480, height=480, bg="white")
  hist(matched$Global_active_power, col="red", 
       main="Global Active Power", xlab="Global Active Power (kilowatts)")
  dev.off()