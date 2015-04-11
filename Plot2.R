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
par(mfcol = c(1, 1))
plot(data_use$Date_Time,data_use$Global_active_power,type="l",main="",ylab="Global Active Power (kilowatts)",xlab="")
dev.copy(png, file = "plot2.png") ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!