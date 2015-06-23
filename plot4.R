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
  # We are creating a containing 4 plots.

  png("plot4.png", width=480, height=480)

  # we specify there will be a 2 * 2 grid of plots
  par(mfrow=c(2,2))

  # Top left plot: same as plot 2, shorter y label
  with(matched, plot(datetime, Global_active_power, type="l", 
                            xlab="", ylab="Global active power"))

  # Top right plot: Voltage against datetime, line
  with(matched, plot(datetime, Voltage, type="l"))

  # Bottom left plot: Same as plot 3, no border around the legend
  plot3 <- with(matched, plot(datetime, Sub_metering_1, col="black", type="l", 
                            xlab="", ylab="Energy sub metering"))
  plot3 <- lines(matched$datetime, matched$Sub_metering_2, col="red")
  plot3 <- lines(matched$datetime, matched$Sub_metering_3, col="blue")
  plot3 <- legend("topright", col=c("black","red", "blue"), legend=c("Sub_metering_1",
                                                                   "Sub_metering_2",
                                                                   "Sub_metering_3"),
                lty=c(1,1,1),
                bty="n")

  # Bottom right plot: Global_reactive_power against datetime, line
  plot4 <- with(matched, plot(datetime, Global_reactive_power, type="l"))
  
  dev.off()