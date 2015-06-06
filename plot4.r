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

par(mfrow=c(2,2),cex=0.675,cex.lab=0.675,cex.axis=0.675)

#   Plot to png file
#png(file="plot4.png",width=480,height=480)


#   Plot 4a
plot(timeplot1$datetime, timeplot1$Global_active_power,ann=F,axes=F)
box() 
axis(2,at=c(0,2,4,6))
axis(1, at=c(1,1440,2880), lab=c("Thu","Fri","Sat"))  
title(ylab="Global Active Power")
lines(timeplot1$datetime, timeplot1$Global_active_power)

#   Plot 4b

plot(timeplot1$datetime, timeplot1$Voltage,axes=F, ann=T)
box() 
axis(2,at=c(234,238,242,246))
axis(1, at=c(1,1440,2880), lab=c("Thu","Fri","Sat"))  
lines(timeplot1$datetime, timeplot1$Voltage)
title(xlab="datetime",ylab="Voltage")


#   Plot 4c

plot(timeplot1$datetime, timeplot1$Sub_metering_1,ann=F,axes=F)
box() 
axis(2,at=c(0,10,20,30),cex.lab=0.8)
axis(1, at=c(1,1440,2880), lab=c("Thu","Fri","Sat"))  
title(ylab="Energy sub metering")
lines(timeplot1$datetime, timeplot1$Sub_metering_1,col=1)
lines(timeplot1$datetime, timeplot1$Sub_metering_2,col=2)
lines(timeplot1$datetime, timeplot1$Sub_metering_3,col=4)
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n",col=c("black","red","blue"),lty=c(1,1,1),cex=0.5)

#   Plot 4d

plot(timeplot1$datetime, timeplot1$Global_reactive_power,axes=F,ann=T)
box() 
axis(2,at=c(0.0,0.1,0.2,0.3,0.4,0.5))
axis(1, at=c(1,1440,2880), lab=c("Thu","Fri","Sat"))  
lines(timeplot1$datetime, timeplot1$Global_reactive_power)
title(xlab="datetime",ylab="Global_reactive_power")

dev.copy(png,"plot4.png",width=480,height=480)
dev.off(3)
par(mfrow=c(1,1),cex=1,cex.lab=1,cex.axis=1)
