# Set the working directory and create (if necessary) a subdir for data in it 
# setwd("C:/Users/nl22423/Documents/R/Coursera/ExplDataAn")
if(!file.exists("data")) { dir.create("data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipname <-"./data/household_power_consumption.zip"
download.file(fileUrl,destfile = zipname)
unzip_name<-unzip(zipname,list = TRUE,exdir="data")[1]$Name
unzip_name<-paste("./data/",unzip_name ,sep="")
unzip(zipname, exdir = "data")
data<-read.table(unzip_name,header = TRUE, sep = ";",na.strings = "?", as.is = TRUE)
library(dplyr)
data_sub <- filter(data, Date == "1/2/2007"|Date == "2/2/2007")
data_use <- select(data_sub,Global_active_power:Sub_metering_3)
data_use$Date_Time <- strptime(paste(data_sub$Date,data_sub$Time),"%d/%m/%Y %H:%M:%S")
Sys.setlocale("LC_TIME", "English")
par(mfcol = c(2, 2))
plot(data_use$Date_Time,data_use$Global_active_power,type="l",main="",ylab="Global Active Power",xlab="")
plot(data_use$Date_Time,data_use$Sub_metering_1,type="l",main="",ylab="Energy sub metering",xlab="")
lines(data_use$Date_Time,data_use$Sub_metering_2,col="red")
lines(data_use$Date_Time,data_use$Sub_metering_3,col="blue")
legend("topright", lty = 1, col = c("black","blue", "red"), bty="n",cex=0.7,legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
plot(data_use$Date_Time,data_use$Voltage,type="l",main="",ylab="Voltage",xlab="datetime")
plot(data_use$Date_Time,data_use$Global_reactive_power,type="l",main="",ylab="Global_reactive_power",xlab="datetime")
dev.copy(png, file = "plot4.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!