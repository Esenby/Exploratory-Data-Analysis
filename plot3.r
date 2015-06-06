#READING DATA into file with new date format
library(dplyr)
plots1<-read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?",stringsAsFactors=FALSE)
plotfew<-filter(plots1, Date=="1/2/2007"|Date=="2/2/2007")
newformat<-as.Date(strptime(plotfew[,1],"%d/%m/%Y"),"%Y-%m-%d")
plotfewformatted<-data.frame(newformat,plotfew[,2:9])

##  Third Plot
library(datasets)
library(lubridate)

#   Convert Date and Time into datetime
timeplot1<-sapply(plotfewformatted$Time, function(x) gsub("\\:","\\-",x))
datetime<-paste(plotfewformatted$Date,timeplot1)
timeplot1<-data.frame(datetime,plotfewformatted)

#   Plot to png file
png(file="prog3.png",width=480,height=480)

#   Plot 3 - Sub_metering tests (1,2,3) against time (datetime)

#   Open graphical device "png"
png(filename="plot3.png", height=480, width=480)

#   Plot including legend
plot(timeplot1$datetime, timeplot1$Sub_metering_1,ann=F,axes=F)
box() 
axis(2,at=c(0,10,20,30),cex.lab=0.8)
axis(1, at=c(1,1440,2880), lab=c("Thu","Fri","Sat"),cex.lab=0.8)  
title(ylab="Energy sub metering")
lines(timeplot1$datetime, timeplot1$Sub_metering_1,col=1)
lines(timeplot1$datetime, timeplot1$Sub_metering_2,col=2)
lines(timeplot1$datetime, timeplot1$Sub_metering_3,col=4)
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1),cex=0.8)












dev.off(3)


