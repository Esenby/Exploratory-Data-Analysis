#READING DATA into file with new date format
library(dplyr)
plots1<-read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?",stringsAsFactors=FALSE)
plotfew<-filter(plots1, Date=="1/2/2007"|Date=="2/2/2007")
newformat<-as.Date(strptime(plotfew[,1],"%d/%m/%Y"),"%Y-%m-%d")
plotfewformatted<-data.frame(newformat,plotfew[,2:9])

##First Plot

par(las=0,cex.axis=0.7)
library(datasets)

#   Open graphical device "png"
png(filename="plot1.png", height=480, width=480)

#   Creating the figure - with the y labels parallet to the y-axis "las=2" 
hist(plotfewformatted$Global_active_power,col="red",axes=FALSE,ann=FALSE, las=2)
axis(1,at=c(0,2,4,6))
axis(2,las=0, at=c(0,200,400,600,800,1000,1200),labels=c("0","200","400","600","800","1000","1200"))
title(main="Global Active Power",xlab="Global Activity (kilowatts)", ylab="Frequency")

#   Closing the device and resetting the par defaults
dev.off(3)
par(cex.axis=1)