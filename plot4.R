library(downloader)
library(lubridate)
zip_file <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
data_file <- "household_power_consumption.txt"
if (!file.exists(data_file)){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download(url, dest=zip_file, mode="wb") 
    unzip (zip_file, exdir = "./")
    file.remove(zip_file)
}

epc <- read.table(data_file, header=TRUE, sep=";", na.strings = "?")
epc$Datetime  <- dmy_hms(paste(epc$Date, epc$Time))
epc_sub <- subset(epc, (Datetime >= ymd_hms("2007-02-01 0:0:0") & Datetime <= ymd_hms("2007-02-02 23:59:59")))


png(file="plot4.png", width=480, height = 480)
par(mfrow = c(2, 2))

# 1
with(epc_sub, plot(Datetime, Global_active_power, type = "l", xlab="", ylab="Global Active Power"))

# 2
with(epc_sub, plot(Datetime, Voltage, type = "l", xlab="datetime"))

# 3
with(epc_sub, plot(Datetime, Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering", col="black"))
with(epc_sub, points(Datetime, Sub_metering_2, type = "l", col="red"))
with(epc_sub, points(Datetime, Sub_metering_3, type = "l", col="blue"))
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, bty ="n")

# 4
with(epc_sub, plot(Datetime, Global_reactive_power, type = "l", xlab="datetime"))
dev.off()
