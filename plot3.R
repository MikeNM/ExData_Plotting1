### Load data and create data frame for plot.
power.df <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
power.df$DateTime <- strptime(paste(power.df$Date, power.df$Time), "%d/%m/%Y %H:%M:%S")
power.df$Date <- as.Date(power.df$Date, format = "%d/%m/%Y")
power.df <- subset(power.df, power.df$Date == "2007-02-01"| power.df$Date == "2007-02-02")

### Code for function that creates plot.
makeplot3 <- function(x){with(x, { plot(power.df$DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
  colors <- c("black", "red", "blue")
  #Create list of the column names for each line on plot.
  meters <- paste0("Sub_metering_", 1:3)
  #Draw line for each "Sub_metering..." variable.
  for (i in seq_along(meters)){
    metername <- meters[i]
    plotdata <- power.df[[metername]]
    lines(power.df$DateTime, plotdata, col = colors[i])
  }
  #add legend.
  legend(x= "topright", legend = meters, col = colors, lty = "solid")
})
}
### Open png graphics device, call function to create plot, close graphics device and save file.
png("plot3.png")
makeplot3(power.df)
dev.off()
rm(power.df, makeplot3)