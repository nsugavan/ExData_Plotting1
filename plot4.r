
library(data.table)
temp <- tempfile()

# Downloading the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
# Unzip the file and read the file into a Data table

RawData <- fread(unzip("household_power_consumption.zip", files = "household_power_consumption.txt"), na.strings = "?", colClasses = c(Date="date", Time="character",Global_active_power="numeric",Global_reactive_power="numeric",Voltage="numeric",Global_intensity="numeric",Sub_metering_1="numeric",Sub_metering_2="numeric",Sub_metering_3="numeric"))
# Convert the Date column which was read as Character Data type to Date Data Type so that the filter for date can be applied

RawData$Date <- as.Date(RawData$Date, format="%d/%m/%Y")

# Extracting Data for specified Days
filteredData <- RawData[RawData$Date > as.Date("01/31/2007", format="%m/%d/%Y")  & RawData$Date < as.Date("02/03/2007",format="%m/%d/%Y"),]

png(filename = "Plot4.png")
#Creating 4 frames
par(mfrow=c(2,2))
# Plotting for Global Active based on date time
plot(strptime(paste(filteredData$Date, filteredData$Time), format = "%F %X"),filteredData$Global_active_power,  xlab="Datetime", ylab="Global Active Power (Kilowatts)", type="l")
# Plotting for Voltage based on date time
plot(strptime(paste(filteredData$Date, filteredData$Time), format = "%F %X"),filteredData$Voltage,  xlab="Datetime", ylab="Voltage", type="l")

colors <- rainbow(3)

# Plotting for Global Active based in date time
plot(strptime(paste(filteredData$Date, filteredData$Time), format = "%F %X"),filteredData$Sub_metering_1,  xlab="Datetime", ylab="Energy Sub Metering", type="l")
lines(strptime(paste(filteredData$Date, filteredData$Time), format = "%F %X"),filteredData$Sub_metering_2,type="l",col=colors[1])
lines(strptime(paste(filteredData$Date, filteredData$Time), format = "%F %X"),filteredData$Sub_metering_3,type="l",col=colors[2])
legend( 'topright', c("Sub_1","Sub_2","Sub_3"), col=colors)

# Plotting for Global reactive based in date time
plot(strptime(paste(filteredData$Date, filteredData$Time), format = "%F %X"),filteredData$Global_reactive_power,  xlab="Datetime", ylab="Global Reactive Power (Kilowatts)", type="l")

dev.off()

