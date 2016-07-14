# Read data
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
data <- tbl_df(data)
# change date column to date type
data$Date <- dmy(data$Date)
# chnage time column to tims type
data$Time <- chron(times = data$Time)
#extract data for just 2 days
extdata <- filter (data, (Date == "2007-02-01" | Date == "2007-02-02"))
# global set device to one plot
par(mfrow=c(1,1))
# Create Histogram for Global Active Power column
hist(extdata$Global_active_power, col= "red", xlab = "Global Active Power (killowatts)",
     main = "Global Active Power")
dev.copy(png, "plot1.png")
dev.off()
