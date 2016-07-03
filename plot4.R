# Read data
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
data <- tbl_df(data)
# change date column to date type
data$Date <- dmy(data$Date)
# chnage time column to tims type
data$Time <- chron(times = data$Time)
#extract data for just 2 days
extdata <- filter (data, (Date == "2007-02-01" | Date == "2007-02-02"))
#combine data and time to DateTime new column
extdata<-within (extdata, { DateTime = as.POSIXct(paste(Date, Time))})

# global set device to 2x2 plots
par(mfrow=c(2,2))

# Plot 1: time vs Global active power
plot(extdata$DateTime, extdata$Global_active_power, lty=1,type="l",lwd=1, xlab = "" , 
     ylab = "Global Active Power (killowatts)")

# Plot 2: time vs Voltage
plot(extdata$DateTime, extdata$Voltage, lty=1,type="l",lwd=1, xlab = "datetime" , 
     ylab = "Voltage")

# Plot 3: time vs Energy submetering
# Initialize plot
plot(extdata$DateTime, extdata$Sub_metering_1, type = "n", xlab = "", ylab = "Energy Sub Metering")
# Add the sub metering 1 data with black color
points(extdata$DateTime, extdata$Sub_metering_1, lty=1,type="l",lwd=1)
# Add the sub metering 2 data with red color
points(extdata$DateTime, extdata$Sub_metering_2, lty=1,type="l",lwd=1, col = "red")
# Add the sub metering 3 data with blue color
points(extdata$DateTime, extdata$Sub_metering_3, lty=1,type="l",lwd=1, col = "blue")
# Add legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"),
       lty = c(1,1,1))

# Plot 4: time vs Global reactive power
plot(extdata$DateTime, extdata$Global_reactive_power, lty=1,type="l",lwd=1, xlab = "datetime" , 
     ylab = "Global_reactive_power")

dev.copy(png, "plot4.png")
dev.off()
