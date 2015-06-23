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
  # We are creating a line graph showing the relationships between each 
  # submetering type & the date/time.
  # There is a y label ("Energy sub metering") but no x label or
  # title.
  # There is a legend with the names of the Sub_metering variables & their
  # matching line colour in the top-right corner.
  
  png("plot3.png", width=480, height=480, bg="white")
  
  # Plot the initial graph with the first submeter type
  with(matched, plot(datetime, Sub_metering_1, col="black", type="l", 
                   xlab="", ylab="Energy sub metering"))

  # Add additional lines for the other sub meter types
  lines(matched$datetime, matched$Sub_metering_2, col="red")
  lines(matched$datetime, matched$Sub_metering_3, col="blue")

  # Finally, add the legend
  legend("topright", col=c("black","red", "blue"), legend=c("Sub_metering_1",
                                                          "Sub_metering_2",
                                                          "Sub_metering_3"),
       lty=c(1,1,1))

  dev.off()