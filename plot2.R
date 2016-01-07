library(dplyr)

##read the data

data1 <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

##Merge the date and time columns and transform them into a proper date variable

data1 <- transform(data1, Date = as.Date(Date, "%d/%m/%Y"))
mydate <- as.Date(c("2007-02-01","2007-02-02"),"%Y-%m-%d")
data1 <- subset(data1, Date %in% mydate)     ##Pick out the 2 days of interest
data1 <- mutate(data1, newdate = paste(Date, Time, sep ="-"))
data1 <- transform(data1, newdate = strptime(newdate, "%Y-%m-%d-%H:%M:%S"))

##draw the second graph

png("plot2.png", width = 480, height = 480)
with(data1, plot(newdate, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()
