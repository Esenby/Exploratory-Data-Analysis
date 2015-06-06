#READING DATA into file with new date format
library(dplyr)
plots1<-read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?",stringsAsFactors=FALSE)
plotfew<-filter(plots1, Date=="1/2/2007"|Date=="2/2/2007")
newformat<-as.Date(strptime(plotfew[,1],"%d/%m/%Y"),"%Y-%m-%d")
plotfewformatted<-data.frame(newformat,plotfew[,2:9])

##  Second Plot
library(datasets)
library(lubridate)

#   Convert Date and Time into datetime
timeplot1<-sapply(plotfewformatted$Time, function(x) gsub("\\:","\\-",x))
datetime<-paste(plotfewformatted$Date,timeplot1)
timeplot1<-data.frame(datetime,plotfewformatted)

#   Plot to png file
png(file="prog2.png",width=480,height=480)
plot(timeplot1$datetime, timeplot1$Global_active_power,ann=F,axes=F)
box() 
axis(2,at=c(0,2,4,6))
axis(1, at=c(1,1440,2880), lab=c("Thu","Fri","Sat"))  
title(ylab="Global Activity (kilowatts)")
lines(timeplot1$datetime, timeplot1$Global_active_power)
dev.off(3)
