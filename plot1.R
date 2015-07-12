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


png(file="plot1.png", width=480, height = 480)
with(epc_sub, hist(Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()
