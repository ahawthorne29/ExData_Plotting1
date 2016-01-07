library(dplyr)

##read the data

data1 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

##Merge the date and time columns and transform them into a proper date variable

data1 <- transform(data1, Date = as.Date(Date, "%d/%m/%Y"))
mydate <- as.Date(c("2007-02-01","2007-02-02"),"%Y-%m-%d")
data1 <- subset(data1, Date %in% mydate)     ##Pick out the 2 days of interest
data1 <- mutate(data1, newdate = paste(Date, Time, sep ="-"))
data1 <- transform(data1, newdate = strptime(newdate, "%Y-%m-%d-%H:%M:%S"))

##draw the fourth graph

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar = c(4, 4, 4,4))
with(data1, plot(newdate, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
with(data1, plot(newdate, Voltage, type="l", ylab="Voltage", xlab="datetime"))
with(data1, plot(newdate, Sub_metering_1, type ="l", ylab="Energy sub metering", xlab=""))
with(data1, lines(newdate, Sub_metering_2, col="red"))
with(data1, lines(newdate, Sub_metering_3, col="blue"))
legend("topright", pch="-", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(data1, plot(newdate, Global_reactive_power, type="l", ylab="global_reactive_power", xlab="datetime"))
dev.off()




