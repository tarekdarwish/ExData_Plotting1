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

# global set device to one plot
par(mfrow=c(1,1))
# Create a plot of the Global_active_power with respect to time
plot(extdata$DateTime, extdata$Global_active_power, lty=1,type="l",lwd=1, xlab = "" , 
     ylab = "Global Active Power (killowatts)")
dev.copy(png, "plot2.png")
dev.off()
