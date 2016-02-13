power.df <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
power.df$DateTime <- strptime(paste(power.df$Date, power.df$Time), "%d/%m/%Y %H:%M:%S")
power.df$Date <- as.Date(power.df$Date, format = "%d/%m/%Y")
power.df <- subset(power.df, power.df$Date == "2007-02-01"| power.df$Date == "2007-02-02")

makeplot4 <- function(x){
  par(mfrow = c(2,2))
  with(x, {
    ## Makes plot for upper left.
    plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
    
    ## Makes plot for upper right.
    plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
    
    ### Makes plot for lower left.
    ## Create canvas
    plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
    colors <- c("black", "red", "blue")
    # Makes names of variables.
    meters <- paste0("Sub_metering_", 1:3)
    
    for(i in seq_along(meters)){
      metername <- meters[i]
      plotdata <- power.df[[metername]]
      lines(DateTime, plotdata, col = colors[i])
    } #end for loop
    legend(x= "topright", legend = meters, col = colors, lty = "solid", bty = "n")
    
    ### Makes plot for lower right.
    plot(DateTime, Global_reactive_power, type = "l", )
  }) #end with()
} #end makeplot4 function

#Open png graphics device, calls function to create the image, and saves image and closes device.
png("plot4.png")
makeplot4(power.df)
dev.off()
rm(power.df, makeplot4)