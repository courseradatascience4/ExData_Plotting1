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

  # filter() in dplyr library lets us subset easily
  matched <- filter(dataset, Date %in% matchingDates)

  # Create datetime column
  matched$datetime <- paste(matched$Date, matched$Time, sep=" ")
  matched$datetime <- strptime(matched$datetime, "%Y-%m-%d %H:%M:%S")
  
# * Plotting *****************************************************************#
  
  # We are creating a line graph of Global_active_power against datetime.
  # There is a y label ("Global active power (kilowatts)") but no x label or
  # title.
  # The x & y axis values & range match the default settings so we do not
  # customise these here.
  
  png("plot2.png", width=480, height=480, bg="white")
  with(matched, plot(datetime, Global_active_power, type="l", 
                     xlab="", ylab="Global active power (kilowatts)"))
  dev.off()