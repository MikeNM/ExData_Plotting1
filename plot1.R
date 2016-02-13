power.df <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
power.df[power.df == "?"] <- NA
power.df$Date <- as.Date(power.df$Date, format = "%d/%m/%Y")
power.df <- subset(power.df, power.df$Date == "2007-02-01"| power.df$Date == "2007-02-02")
power.df$Global_active_power <- as.character(power.df$Global_active_power)
power.df$Global_active_power <- as.numeric(power.df$Global_active_power)
png(file = "plot1.png")
hist(power.df$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
